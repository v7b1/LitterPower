/*
	File:		ccc~.c

	Contains:	1/f noise, using the Schuster/Procaccia deterministic (chaotic) algorithm.

	Written by:	Peter Castine

	Copyright:	© 2001-2003 Peter Castine

	Change History (most recent first):

         <7>   23–3–2006    pc      Remove unneeded references to Taus88 code.
         <6>   23–3–2006    pc      Update #includes for new LitterLib organization.
         <5>     11–1–04    pc      Update for Windows.
         <4>    7–7–2003    pc      Use new LitterInfo method (incl. gModDate, LitterAddClass, etc.)
         <3>    6–3–2003    pc      Drop faux 'Vers' resource and related modifications. Add object
                                    version to CCCInfo().
         <2>  28–11–2002    pc      Tidy up after initial check in.
         <1>  28–11–2002    pc      Initial Check-In.
		28-Apr-2002:		First implementation.
*/


/******************************************************************************************
	1/f noise can be created using random noise generators but it can also be producted
	using deterministic functions. One such method is a finite difference equation
	proposed by I. Procaccia and H. Schuster. It is simply

		x' = (x + x^2) mod 1
	
	References

	Schuster, H.G.
	Deterministic Chaos - An Introduction
	Physik verlag, Weinheim, 1984 

	Procaccia, I. and Schuster, H.G.
	Functional renormalisation group theory of universal 1/f noise in dynamical systems.
	Phys Rev 28 A, 1210-12 (1983) 
 ******************************************************************************************/

#pragma mark • Include Files

#include "LitterLib.h"
//#include "TrialPeriodUtils.h"
#include "MiscUtils.h"

//#include <float.h>


#pragma mark • Constants

const char*			kClassName		= "lp.ccc~";			// Class name

const char* lpversion = "64-bit version. Copyright 2001-08 Peter Castine, Part of Litter Power 1.8";


	// Indices for STR# resource
enum {
	strIndexInEnable	= lpStrIndexLastStandard + 1,
	strIndexTheOutlet,
	
	strIndexInLeft		= strIndexInEnable,
	strIndexOutLeft		= strIndexTheOutlet
	};


#pragma mark • Type Definitions



#pragma mark • Object Structure

typedef struct {
	t_pxobject		coreObject;
	
	double			curVal;
	} tPink;


#pragma mark • Global Variables



#pragma mark • Function Prototypes

	// Class message functions
void*	CCCNew(void);

	// Object message functions
static void CCCTattle(tPink*);
static void	CCCAssist(tPink*, void* , long , long , char*);
static void	CCCInfo(tPink*);

	// MSP Messages
void BuildDSPChain(tPink*, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags);
void PerformPink64(tPink*, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam);


#pragma mark -
/*****************************  I M P L E M E N T A T I O N  ******************************/

#pragma mark • Inline Functions



#pragma mark -

/******************************************************************************************
 *
 *	main()
 *	
 *	Standar Max/MSP External Object Entry Point Function
 *	
 ******************************************************************************************/

int C74_EXPORT main(void)
	
	{
	//LITTER_CHECKTIMEOUT(kClassName);
	t_class *c;
        
	// Standard Max/MSP initialization mantra
	c = class_new(kClassName,
			(method) CCCNew,			// Instance creation function
			(method) dsp_free,			// Default deallocation function
			sizeof(tPink),				// Class object size
			NIL,						// No menu function
			A_NOTHING,					// No arguments
			0);		
	
	class_dspinit(c);
	
	// Messages
	class_addmethod(c, (method) CCCTattle,	"dblclick",	A_CANT, 0);
	class_addmethod(c, (method) CCCTattle,	"tattle",	A_NOTHING);
	class_addmethod(c, (method) CCCAssist,	"assist",	A_CANT, 0);
	class_addmethod(c, (method) CCCInfo,	"info",		A_CANT, 0);
	
	// MSP-Level messages
	class_addmethod(c, (method) BuildDSPChain, "dsp64",		A_CANT, 0);

	// Initialize Litter Library
	//LitterInit(kClassName, 0);
        class_register(CLASS_BOX, c);
        gObjectClass = c;
        
        post("%s: %s", kClassName, lpversion);
        return 0;
	
	}



#pragma mark -
#pragma mark • Class Message Handlers

/******************************************************************************************
 *
 *	CCCNew(iNN)
 *	
 *	Arguments: nn factor.
 *
 ******************************************************************************************/

void*
CCCNew(void)
	
	{
	tPink*	me	= NIL;
	
	// Let Max/MSP allocate us, our inlets, and outlets.
	me = object_alloc(gObjectClass);
	dsp_setup(&(me->coreObject), 1);				// Signal inlet for benefit of begin~
	outlet_new(me, "signal");
	
	// Set up object components
	me->curVal = ULong2Unit_zo(MachineKharma());

	return me;
	}

#pragma mark -
#pragma mark • Object Message Handlers

/******************************************************************************************
 *
 *	CCCTattle(me)
 *
 *	Post state information
 *
 ******************************************************************************************/

void
CCCTattle(
	tPink* me)
	
	{
	post("%s state", kClassName);
	post("  CurVal: %lf", me->curVal);
	}


/******************************************************************************************
 *
 *	CCCAssist()
 *	CCCInfo()
 *
 *	Generic Assist/Info methods
 *	
 *	Many parameters are not used.
 *
 ******************************************************************************************/

void CCCAssist(tPink* me, void* box, long iDir, long iArgNum, char* oCStr)
	{
	#pragma unused(me, box)
	
	//LitterAssist(iDir, iArgNum, strIndexInLeft, strIndexOutLeft, oCStr);
	}

void CCCInfo(tPink* me)
	{ LitterInfo(kClassName, &me->coreObject.z_ob, (method) CCCTattle); }


#pragma mark -
#pragma mark • DSP Methods

/******************************************************************************************
 *
 *	BuildDSPChain(me, ioDSPVectors, iConnectCounts)
 *
 ******************************************************************************************/

void BuildDSPChain(tPink* me, t_object *dsp64, short *count, double samplerate, long maxvectorsize, long flags)

	{

	object_method(dsp64, gensym("dsp_add64"), me, PerformPink64, 0, NULL);
	
	}
	

/******************************************************************************************
 *
 *	PerformPink(iParams)
 *
 *	Parameter block for PerformSync contains 8 values:
 *		- Address of this function
 *		- The performing object
 *		- Vector size
 *		- output signal
 *		- Imaginary output signal
 *
 ******************************************************************************************/

void PerformPink64(tPink* me, t_object *dsp64, double **ins, long numins, double **outs, long numouts, long sampleframes, long flags, void *userparam)
	
	{
	const double kMinPink = 1.0 / 525288.0;
	
	long			vecCounter;
	tSampleVector	outNoise;

	double			curVal;
	
	if (me->coreObject.z_disabled) return;
	
	// Copy parameters into registers
	vecCounter	= sampleframes;
	outNoise	= outs[0];
	curVal		= me->curVal;
	
	// Sanity check... due to limitations in accuracy, we can die at very small values.
	// Only check once per PerformPink(), we can wait that long.
	// Also, we prefer to only "nudge" the value towards chaos... 
	if (curVal <= kMinPink) {
		if (curVal == 0.0)	curVal  = kMinPink;
		else				curVal += curVal;
		}
	
	// Do our stuff
	do {
		curVal = curVal * curVal + curVal;
		if (curVal >= 1.0)					// Cheaper than fmod(), and works quite nicely
			curVal -= 1.0;					// in the range of values that can occur.
		
		*outNoise++ = curVal;
		} while (--vecCounter > 0);
	
	me->curVal	= curVal;
	
	}

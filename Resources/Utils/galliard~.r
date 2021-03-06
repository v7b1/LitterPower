/*
	File:		twist~.r

	Contains:	Resources for Max/MSP external object twist~.

	Written by:	Peter Castine

	Copyright:	 � 2007 Peter Castine. All rights reserved.

	Change History (most recent first):

*/


	//
	// Configuration values for this object
	//
	// These must be unique within Litter Package. The Names must match constant values used
	// in the C/C++ source code (we try never to access resources by ID).
#define LPobjID			17591
#define LPobjName		"lp.galliard~"

	// -----------------------------------------
	// 'vers' stuff we need to maintain manually
//#define LPobjStarter		1								// Comment out for Pro Bundles

#define LPobjMajorRev		1								// 1-99 (decimal)
#define LPobjMinorRev		0								// 1-9	(decimal)
#define LPobjBugFix			0								// 1-9	(decimal)
#define LPobjStage			developStage					// Apple #defined build stage
#define LPobjStageBuild		1								// 1-255 (preferred over BCD 1-99)
#define LPobjRegion			0								// US
#define LPobjVersStr		"1.0.d1"
#define LPobjCRYears		"2007"

#define	LPobjLitterCategory	"Litter Utilities"
#define LPobjMax3Category	"MSP"							// Category for Max 2.2 - 3.6x
#define LPobjMax4Category	"MSP Modifiers"					// Category starting at Max 4

	// Description string (for Windows Properties box, taken from documentation)
#define LPobjDescription	"Polynomial evaluator"

	// The following sets up the 'mAxL', 'vers', and 'Vers' resources
	// It relies on the values above for resource IDs and names, as
	// well as concrete values for the 'vers'(1) resource.
#include "Litter Globals.r"
	//
	// -----------------------------------------


	//
	// Other resource definitions 
	//


#define LPAssistIn1			"Signal to process, list of coefficients"
#define LPAssistOut1		"Signal (Processed signal)"

#ifdef RC_INVOKED					// Must be Windows RC Compiler

	STRINGTABLE DISCARDABLE
		BEGIN
		lpStrIndexLastStandard + 1,		LPAssistIn1
		lpStrIndexLastStandard + 2,		LPAssistOut1
		END

#else								// Must be Mac OS Resource Compiler

	resource 'STR#' (LPobjID, LPobjName) {
		{	/* array StringArray */
			LPStdStrings,					// Standard Litter Strings
			
			// Assist strings
			LPAssistIn1,					// Inlet
			LPAssistOut1					// Outlet
		}
	};

#endif


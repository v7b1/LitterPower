/*	File:		lbj.im.r	Contains:	Resources for lbj.im.c	Written by:	Peter Castine	Copyright:	Copyright � 2006 Peter Castine. All rights reserved.	Change History (most recent first):         <2>    9�5�2006    pc      Correct build information         <1>    8�5�2006    pc      first checked in.*//****************************************************************************************** ******************************************************************************************/	//	// Configuration values for this object	//	// These must be unique within Litter Package. The Names must match constant values used	// in the C/C++ source code (we try never to access resources by ID).#define LPobjID			17582#define LPobjName		"lbj.jim"	// 'vers' stuff we need to maintain manually#define LPobjLBJ			1#define LPobjMajorRev		1							// 1-99 (decimal)#define LPobjMinorRev		0							// 1-9	(decimal)#define LPobjBugFix			0							// 1-9	(decimal)#define LPobjStage			developStage				// Apple standard stage #defines#define LPobjStageBuild		2							// 1-255 (0 for Golden Master only)#define LPobjRegion			0							// US#define LPobjVersStr		"1.0d2"#define LPobjCRYears		"2006-08"#define	LPobjLitterCategory	"Litter Bundle Jitter"		// Litter Category#define LPobjMax3Category	""							// Category for Max 2.2 - 3.6x (N/A)#define LPobjMax4Category	"Jitter Compositing"		// Category starting at Max 4	// Description string (for Windows Properties box, taken from documentation)#define LPobjDescription	"Interval mutation for Jitter matrices"	// The following sets up the 'mAxL' and 'vers' resources on Mac OS	// and VERSIONINFO resource on Windows	// It relies on the values above for resource IDs and names, as	// well as concrete values for the 'vers'/VERSIONINFO resources.#include "Litter Globals.r"	//	// -----------------------------------------	//	// Other Resource definitions 	//		// Assistance strings	#ifdef RC_INVOKED 			// Special characters for Windows		#define		ellipsisSymbol		"..."		#define		muSymbol			0xb5		#define		piSymbol			"pi"		#define		deltaSymbol			""	#else						// Special characters for Mac OS		#define		ellipsisSymbol		"�"		#define		muSymbol			"�"		#define		piSymbol			"�"		#define		deltaSymbol			", �"	#endif	#define LPAssistIn1			"Source Matrix"#define LPAssistIn2			"Target Matrix "#define LPAssistIn3			"Float (Mutation index, " muSymbol ")"#define LPAssistIn4			"Float (Clumping factor, " piSymbol ")"#define LPAssistIn5			"Float (Delta emphasis" deltaSymbol ")"#define LPAssistOut1		"Mutant Matrix"#define LPAssistOut2		"Obligatory Dump outlet"#ifdef RC_INVOKED					// Must be Windows RC Compiler	STRINGTABLE DISCARDABLE		BEGIN		lpStrIndexLastStandard + 1,		LPAssistIn1		lpStrIndexLastStandard + 2,		LPAssistIn2		lpStrIndexLastStandard + 3,		LPAssistIn3		lpStrIndexLastStandard + 4,		LPAssistIn4		lpStrIndexLastStandard + 5,		LPAssistIn5		lpStrIndexLastStandard + 6,		LPAssistOut1		lpStrIndexLastStandard + 7,		LPAssistOut2		END#else								// Must be Mac OS Resource Compiler	resource 'STR#' (LPobjID, LPobjName) {		{	/* array StringArray */			LPStdStrings,								// Standard Litter Strings						// Assist strings			LPAssistIn1, LPAssistIn2,					// Inlets			LPAssistIn3, LPAssistIn4, LPAssistIn5,			LPAssistOut1, LPAssistOut2					// Outlets		}	};#endif		
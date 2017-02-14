/*	File:		lbj.linnie.r	Contains:	Faster white noise	Written by:	Peter Castine	Copyright:	Copyright � 2002-2005 Peter Castine. All rights reserved.	Change History (most recent first):         <4>   12�8�2005    pc      Update to final for "LBJ Preview"         <3>      5�3�05    pc      Correct copyright year.         <2>      5�3�05    pc      Tidy up.         <1>      5�3�05    pc      Initial check in.*//******************************************************************************************	Prior History:		11-Jul-2003:		First implementation. ******************************************************************************************/	//	// Configuration values for this object	//	// These must be unique within Litter Package. The Names must match constant values used	// in the C/C++ source code (we try never to access resources by ID).#define LPobjID			17587#define LPobjName		"lbj.linnie"	// 'vers' stuff we need to maintain manually#define LPobjLBJ			1#define LPobjMajorRev		1							// 1-99 (decimal)#define LPobjMinorRev		0							// 1-9	(decimal)#define LPobjBugFix			0							// 1-9	(decimal)#define LPobjStage			developStage					// Apple standard stage #defines#define LPobjStageBuild		1							// 1-255 (0 for Golden Master only)#define LPobjRegion			0							// US#define LPobjVersStr		"1.0d1"#define LPobjCRYears		"2006"#define	LPobjLitterCategory	"Litter Bundle Jitter"		// Litter Category#define LPobjMax3Category	""							// Category for Max 2.2 - 3.6x#define LPobjMax4Category	"Jitter Generators"			// Category starting at Max 4	// Description string (for Windows Properties box, taken from documentation)#define LPobjDescription	"Generate triangular and linear noise distributions"	// The following sets up the 'mAxL' and 'vers' resources on Mac OS	// and VERSIONINFO resource on Windows	// It relies on the values above for resource IDs and names, as	// well as concrete values for the 'vers'/VERSIONINFO resources.#include "Litter Globals.r"	//	// -----------------------------------------	//	// Other Resource definitions 	//		// Assistance strings	#define LPAssistIn1			"Bang, other messaages"#define LPAssistOut1		"Triangular noise"#define LPAssistOut2		"Dump"#ifdef RC_INVOKED					// Must be Windows RC Compiler	STRINGTABLE DISCARDABLE		BEGIN		lpStrIndexLastStandard + 1,		LPAssistIn1		lpStrIndexLastStandard + 2,		LPAssistOut1		lpStrIndexLastStandard + 3,		LPAssistOut2		END#else								// Must be Mac OS Resource Compiler	resource 'STR#' (LPobjID, LPobjName) {		{	/* array StringArray */			LPStdStrings,								// Standard Litter Strings						// Assist strings			LPAssistIn1,								// Inlets			LPAssistOut1, LPAssistOut2					// Outlets		}	};#endif		
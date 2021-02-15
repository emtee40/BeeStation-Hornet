//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.
//Uncomment if you want logs about the time it takes for parts of the shadows to generate
//and turfs to be coloured depending on their grouping to a light source.
//#define SHADOW_DEBUG

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Mining\Lavaland.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
		#include "map_files\MetaStation\MetaStation.dmm"
		#include "map_files\PubbyStation\PubbyStation.dmm"
		#include "map_files\BoxStation\BoxStation.dmm"
		#include "map_files\Donutstation\Donutstation.dmm"
		#include "map_files\KiloStation\KiloStation.dmm"

		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif

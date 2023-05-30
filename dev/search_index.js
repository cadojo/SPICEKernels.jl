var documenterSearchIndex = {"docs":
[{"location":"#SPICEKernels.jl","page":"SPICEKernels.jl","title":"SPICEKernels.jl","text":"","category":"section"},{"location":"","page":"SPICEKernels.jl","title":"SPICEKernels.jl","text":"Solar system ephemeris data for free!","category":"page"},{"location":"","page":"SPICEKernels.jl","title":"SPICEKernels.jl","text":"While HorizonsAPI.jl provides a precise interface which matches the JPL Horizons API, SPICEKernels.jl provides an interface for downloading General Kernel files from NASA JPL's public website. More documentation en route!","category":"page"},{"location":"","page":"SPICEKernels.jl","title":"SPICEKernels.jl","text":"warning: Warning\nMore documentation will come, but for now, SPICEKernels only has humble docstrings! For more information, take a look at the project's GitHub repository. There, and in docstrings, you'll find a recurring warning which is reiterated here: this project is not affiliated with or endorsed by NASA, JPL, Caltech, or any other organization!","category":"page"},{"location":"docstrings/#Documentation","page":"Documentation","title":"Documentation","text":"","category":"section"},{"location":"docstrings/","page":"Documentation","title":"Documentation","text":"All docstrings!","category":"page"},{"location":"docstrings/","page":"Documentation","title":"Documentation","text":"Modules = [\n    SPICEKernels,\n]\nOrder = [:module, :type, :function, :constant]","category":"page"},{"location":"docstrings/#SPICEKernels.SPICEKernels","page":"Documentation","title":"SPICEKernels.SPICEKernels","text":"Download any and all General Kernels provided by NASA JPL!\n\nwarning: Warning\nThis package is not affiliated with or endorsed by NASA, JPL, or any other organization! This is an independently written package by an astrodynamics hobbyist.\n\nExtended Help\n\nREADME\n\n(Image: Tests) (Image: Docs) (Image: SciML Code Style)\n\nSPICEKernels.jl\n\nAll General Kernels provided by NASA!\n\nNoteThis package is under development. Check back by June!\n\nWarningThis package is not affiliated with or endorsed by NASA, JPL, Caltech, or any other organization! This is an independently written package by an astrodynamics hobbyist.\n\nInstallation\n\nNot yet registered.\n\nChoose one of the following two lines!\n\nPkg.add(\"https://github.com/cadojo/SPICEKernels.jl\")\n\n]add https://github.com/cadojo/SPICEKernels.jl # in the Julia REPL\n\nMotivation\n\nWhy this?\n\nThis package allows you to check out what general kernels are available, all from the Julia REPL / language server! Each kernel is represented by a type, where the SPICE kernel flavor is encoded in Julia's type system and within an enumerated type. Each requested kernel is cached by default, so there's no need to download a kernel more than once!\n\nImports\n\nAstroTime\nBase\nCore\nDates\nDocStringExtensions\nHTTP\nScratch\n\nExports\n\n\n\n\n\n","category":"module"},{"location":"docstrings/#SPICEKernels.DigitalShapeKernel","page":"Documentation","title":"SPICEKernels.DigitalShapeKernel","text":"abstract type DigitalShapeKernel <: SPICEKernels.SPICEKernel\n\nA supertype representing Digital Shape Kernels (DSK).\n\nExtended Help\n\nAll subtypes must implement the following methods.\n\nSPICEKernels.bodies(kernel)::AbstractSet{<:Integer}\nSPICEKernels.name(kernel)::AbstractString\n\n\n\n\n\n","category":"type"},{"location":"docstrings/#SPICEKernels.EphemerisKernel","page":"Documentation","title":"SPICEKernels.EphemerisKernel","text":"abstract type EphemerisKernel <: SPICEKernels.SPICEKernel\n\nA supertype representing Spacecraft and Planet Kernels, also known as ephemeris kernels (SPK).\n\nExtended Help\n\nAll subtypes must implement the following methods.\n\nSPICEKernels.bodies(kernel)::AbstractSet{<:Integer}\nSPICEKernels.name(kernel)::AbstractString\n\n\n\n\n\n","category":"type"},{"location":"docstrings/#SPICEKernels.FramesKernel","page":"Documentation","title":"SPICEKernels.FramesKernel","text":"abstract type FramesKernel <: SPICEKernels.SPICEKernel\n\nA supertype representing Frames Kernels (FK).\n\nExtended Help\n\nAll subtypes must implement the following methods.\n\nSPICEKernels.bodies(kernel)::AbstractSet{<:Integer}\nSPICEKernels.name(kernel)::AbstractString\n\n\n\n\n\n","category":"type"},{"location":"docstrings/#SPICEKernels.LeapsecondsKernel","page":"Documentation","title":"SPICEKernels.LeapsecondsKernel","text":"abstract type LeapsecondsKernel <: SPICEKernels.SPICEKernel\n\nA supertype representing Leapseconds Kernels (LSK).\n\nExtended Help\n\nAll subtypes must implement the following methods.\n\nSPICEKernels.bodies(kernel)::AbstractSet{<:Integer}\nSPICEKernels.name(kernel)::AbstractString\n\n\n\n\n\n","category":"type"},{"location":"docstrings/#SPICEKernels.PlanetaryConstantsKernel","page":"Documentation","title":"SPICEKernels.PlanetaryConstantsKernel","text":"abstract type PlanetaryConstantsKernel <: SPICEKernels.SPICEKernel\n\nA supertype representing Planetary Constants Kernels (PCK).\n\nExtended Help\n\nAll subtypes must implement the following methods.\n\nSPICEKernels.bodies(kernel)::AbstractSet{<:Integer}\nSPICEKernels.name(kernel)::AbstractString\n\n\n\n\n\n","category":"type"},{"location":"docstrings/#SPICEKernels.SPICEKernel","page":"Documentation","title":"SPICEKernels.SPICEKernel","text":"abstract type SPICEKernel\n\nA supertype for all SPICE Kernels! To satisfy the SPICEKernel interface, your new type must implement each of the methods below.\n\nSPICEKernels.bodies(kernel)::AbstractSet{<:Integer}\nSPICEKernels.type(kernel)::AbstractString\nSPICEKernels.name(kernel)::AbstractString\nSPICEKernels.path(kernel)::AbstractString\n\n\n\n\n\n","category":"type"},{"location":"docstrings/#SPICEKernels.SPK","page":"Documentation","title":"SPICEKernels.SPK","text":"struct SPK <: SPICEKernels.EphemerisKernel\n\nA spacecraft and planet kernel (SPK).\n\n\n\n\n\n","category":"type"},{"location":"docstrings/#SPICEKernels.bodies","page":"Documentation","title":"SPICEKernels.bodies","text":"Return the bodies contained within the provided kernel, if they are explicitly provided.\n\n\n\n\n\n","category":"function"},{"location":"docstrings/#SPICEKernels.getkernel","page":"Documentation","title":"SPICEKernels.getkernel","text":"getkernel(identifier)\ngetkernel(identifier, type; directory, cache)\n\n\nGiven the ephemeris file name, download the file and return a path to the file location. If a full URL is provided, that URL will be used. Otherwise, the identifier is assumed to be a SPICE General Kernel. If directory is set, the file is downloaded to the provided path. If cache is enabled –- and it is by default –- the ephemeris file is downloaded to the SPICEKernels.jl scratch space.\n\n\n\n\n\n","category":"function"},{"location":"docstrings/#SPICEKernels.name","page":"Documentation","title":"SPICEKernels.name","text":"Return the kernel file name.\n\n\n\n\n\n","category":"function"},{"location":"docstrings/#SPICEKernels.path","page":"Documentation","title":"SPICEKernels.path","text":"Return the path to the kernel. This can be a URL!\n\n\n\n\n\n","category":"function"},{"location":"docstrings/#SPICEKernels.type","page":"Documentation","title":"SPICEKernels.type","text":"Return the underlying SPICE kernel type.\n\n\n\n\n\n","category":"function"}]
}

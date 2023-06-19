"""
Download any and all General Kernels provided by NASA JPL!

!!! warning
    This package is not affiliated with or endorsed by NASA, JPL, or any
    other organization! This is an independently written package by an
    astrodynamics hobbyist.

# Extended Help

## README

$(README)

## Imports

$(IMPORTS)

## Exports

$(EXPORTS)

"""
module SPICEKernels

using DocStringExtensions
include("docstrings.jl")

using HTTP
using Dates
using Scratch
using AstroTime

SPICE_KERNEL_DIR = ""
const GENERAL_KERNEL_URL = "https://naif.jpl.nasa.gov/pub/naif/generic_kernels"

function __init__()
    global SPICE_KERNEL_DIR = @get_scratch!("spice-kernels")
end

include(joinpath("gen", "kernels.jl"))

"""
Given the ephemeris file name, download the file and return a path to the file location. If
a full URL is provided, that URL will be used. Otherwise, the `identifier` is assumed to be
a SPICE General Kernel. If `directory` is set, the file is downloaded to the provided path.
If `cache` is enabled --- and it is by default --- the ephemeris file is downloaded to the
`SPICEKernels.jl` scratch space.
"""
function getkernel(
        kernel::AbstractString;
        to::Union{<:AbstractString,Nothing}=nothing,
        cache::Bool=true
    )

    global SPICE_KERNEL_DIR

    try
        path = GENERAL_KERNELS[kernel]
    catch e
        if e isa KeyError
            path = kernel
        else
            rethrow(e)
        end
    end

    filename = joinpath(SPICE_KERNEL_DIR, basename(path))

    if !cache || !isfile(filename)
        download(path, filename)
    end

    if !isnothing(to)
        Base.cp(filename, to)
    end

    return filename
end

"""
A supertype for all SPICE Kernels! To satisfy the `SPICEKernel` interface, your new type
must implement each of the methods below.

- `SPICEKernels.type(kernel)::AbstractString`
- `SPICEKernels.path(kernel)::AbstractString`
"""
abstract type SPICEKernel end


function (kernel::SPICEKernel)(; cache=true, to=nothing)
    return getkernel(path(kernel); to=to, cache=cache)
end

"""
Return the underlying SPICE kernel type.
"""
function type end

"""
Return the path to the kernel. This can be a URL!
"""
function path end

"""
A supertype representing Digital Shape Kernels (DSK).

# Extended Help

All subtypes must implement the following methods.

- `SPICEKernels.bodies(kernel)::AbstractSet{<:Integer}`
- `SPICEKernels.name(kernel)::AbstractString`
"""
abstract type DigitalShapeKernel <: SPICEKernel end
type(::DigitalShapeKernel) = "DSK"

"""
A supertype representing Frames Kernels (FK).

# Extended Help

All subtypes must implement the following methods.

- `SPICEKernels.bodies(kernel)::AbstractSet{<:Integer}`
- `SPICEKernels.name(kernel)::AbstractString`
"""
abstract type FramesKernel <: SPICEKernel end
type(::FramesKernel) = "FK"

"""
A supertype representing Leapseconds Kernels (LSK).

# Extended Help

All subtypes must implement the following methods.

- `SPICEKernels.name(kernel)::AbstractString`
"""
abstract type LeapsecondsKernel <: SPICEKernel end
type(::LeapsecondsKernel) = "LSK"

"""
A supertype representing Planetary Constants Kernels (PCK).

# Extended Help

All subtypes must implement the following methods.

- `SPICEKernels.bodies(kernel)::AbstractSet{<:Integer}`
- `SPICEKernels.name(kernel)::AbstractString`
"""
abstract type PlanetaryConstantsKernel <: SPICEKernel end
type(::PlanetaryConstantsKernel) = "PSK"

"""
A supertype representing Spacecraft and Planet Kernels, also known as ephemeris kernels (SPK).

# Extended Help

All subtypes must implement the following methods.

- `SPICEKernels.bodies(kernel)::AbstractSet{<:Integer}`
- `SPICEKernels.name(kernel)::AbstractString`
"""
abstract type EphemerisKernel <: SPICEKernel end
type(::EphemerisKernel) = "SPK"


const SPICE_EXTENSIONS = Base.ImmutableDict(
    ".bsp" => EphemerisKernel,
    ".dsk" => DigitalShapeKernel,
    ".pck" => PlanetaryConstantsKernel,
    ".bds" => DigitalShapeKernel,
    ".tf" => FramesKernel,
    ".bpc" => PlanetaryConstantsKernel,
    ".tpc" => PlanetaryConstantsKernel,
    ".bpc" => PlanetaryConstantsKernel,
    ".tls" => LeapsecondsKernel,
)

"""
Fallback method to inspect the file extension of the provided kernel, and 
return the expected kernel type. If the file extension is not recognized, 
a `KeyError` is thrown.
"""
function type(kernel::Union{<:SPICEKernel, <:AbstractString})
    if kernel isa SPICEKernel
        name = basename(path(kernel))
    else
        name = basename(kernel)
    end

    ext = splitext(name)

    return SPICE_EXTENSIONS[ext]
end


end # module SPICEKernels

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

"""
Given the ephemeris file name, download the file and return a path to the file location. If
a full URL is provided, that URL will be used. Otherwise, the `identifier` is assumed to be
a SPICE General Kernel. If `to` is set, the file is downloaded to the provided path. If
`cache` is enabled --- and it is by default --- the ephemeris file is downloaded to the
`SPICEKernels.jl` scratch space.
"""
function getkernel(identifier::AbstractString, type::Union{<:AbstractString,Nothing}; to=nothing, cache=true)

    global SPICE_KERNEL_DIR

    if occursin("/", identifier)
        filename = joinpath(SPICE_KERNEL_DIR, isnothing(type) ? "" : type, last(split(identifier, "/")))
    else
        filename = joinpath(SPICE_KERNEL_DIR, isnothing(type) ? "" : type, identifier)
    end

    if !cache || !isfile(filename)
        download(HTTP.safer_joinpath(GENERAL_KERNEL_URL, isnothing(type) ? "" : type, identifier), filename)

        if !isnothing(to)
            Base.cp(filename, joinpath(to, isnothing(type) ? "" : type, identifier))
            return to
        else
            return filename
        end

    else
        return filename
    end

end

"""
An enumerated type with all possible SPICE kernel flavors.
"""
@enum KernelType DigitalShape Frames Leapseconds PlanetaryConstants Ephemeris

"""
A supertype for all SPICE Kernels! To satisfy the `SPICEKernel` interface, your new type
must implement each of the methods below.

- `SPICEKernels.bodies(kernel)::Union{Nothing, <:AbstractSet{<:Integer}}`
- `SPICEKernels.type(kernel)::SPICEKernels.KernelType`
- `SPICEKernels.name(kernel)::AbstractString`
"""
abstract type SPICEKernel end

"""
Return the underlying SPICE kernel type.
"""
function type end

"""
Return the bodies contained within the provided kernel, if they are explicitly provided.
"""
function bodies end

"""
Return the file path to kernel.
"""
function name end

"""
A supertype representing Digital Shape Kernels (DSK).
"""
abstract type DigitalShapeKernel <: SPICEKernel end

"""
A supertype representing Frames Kernels (FK).
"""
abstract type FramesKernel <: SPICEKernel end

"""
A supertype representing Leapseconds Kernels (LSK).
"""
abstract type LeapsecondsKernel <: SPICEKernel end

"""
A supertype representing Planetary Constants Kernels (PCK).
"""
abstract type PlanetaryConstantsKernel <: SPICEKernel end

"""
A supertype representing Spacecraft and Planet Kernels, also known as ephemeris kernels (SPK).
"""
abstract type EphemerisKernel <: SPICEKernel end

include("spk.jl")

end # module SPICEKernels

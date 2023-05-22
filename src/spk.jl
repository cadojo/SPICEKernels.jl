#
# The General SPK Gernels
#

"""
A spacecraft and planet kernel (SPK).
"""
struct SPK <: EphemerisKernel
    name::String
    bodies::Set{Int}
    timespan::NTuple{2,AstroTime.TDBEpoch}

    SPK(name, bodies, timespan) = new(name, bodies, timespan)
end

SPICEKernels.name(kernel::SPK) = kernel.name
SPICEKernels.bodies(kernel::SPK) = kernel.bodies

de430 = SPK(
    "de430.bsp",
    Set{Int}((1:10..., 199, 299, 301, 399)),
    (AstroTime.TDBEpoch("1549-12-31T00:00:00.000"), AstroTime.TDBEpoch("2650-01-25T00:00:00.000"))
)

# de431_part1 = SPK(
#     "de431_part-1.bsp",
#     Set{Int}((1:10..., 199, 299, 301, 399)),
#     (AstroTime.TDBEpoch("-13200-05-07T00:00:41.184", "yyyy-mm-ddTHH:mm:ss:ff"), AstroTime.TDBEpoch("0001-01-01T00:00:41.184"))
# )

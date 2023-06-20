using Test, Scratch
using SPICEKernels

KERNEL = let 
    iskernel(x) = getproperty(SPICEKernels, x) isa SPICEKernels.SPICEKernel && isconcretetype(typeof(getproperty(SPICEKernels, x)))
    all = map(name -> getproperty(SPICEKernels, name), filter(iskernel, propertynames(SPICEKernels)))
    rand(all)
end

@info "Testing for $KERNEL"

@testset "Kernel Downloading" begin
    @test KERNEL(ignorecache=true) isa String
end

@testset "Kernel Caching" begin
    @test KERNEL(ignorecache=false) isa String
end

@testset "Kernel Copying" begin
    tmp = mktempdir()
    path = KERNEL(ignorecache=false, directory=tmp)
    @test path isa String
    Base.rm(path)
end

Scratch.clear_scratchspaces!(SPICEKernels)

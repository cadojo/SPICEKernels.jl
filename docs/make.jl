using Documenter, SPICEKernels

makedocs(
    sitename="SPICEKernels",
    format=Documenter.HTML(size_threshold=nothing),
    modules=[SPICEKernels],
)

deploydocs(
    target="build",
    repo="github.com/cadojo/SPICEKernels.jl.git",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "manual", "v#.#", "v#.#.#"],
)

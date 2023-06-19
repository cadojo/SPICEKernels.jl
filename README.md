[![Tests](https://github.com/cadojo/SPICEKernels.jl/workflows/UnitTests/badge.svg)](https://github.com/cadojo/SPICEKernels.jl/actions?query=workflow%3AUnitTests)
[![Docs](https://github.com/cadojo/SPICEKernels.jl/workflows/Documentation/badge.svg)](https://cadojo.github.io/SPICEKernels.jl)
[![SciML Code Style](https://img.shields.io/static/v1?label=Style&message=SciML&color=9668e2&labelColor=3E474F)](https://github.com/SciML/SciMLStyle)

# `SPICEKernels.jl`

_All General Kernels provided by NASA!_

> **Warning**
>
> This package is not affiliated with or endorsed by NASA, JPL, Caltech, or any
> other organization! This is an independently written package by an
> astrodynamics hobbyist.

## Installation

_Not yet registered._

Choose one of the following two lines!

```julia
Pkg.add("https://github.com/cadojo/SPICEKernels.jl")
```

```julia
]add https://github.com/cadojo/SPICEKernels.jl # in the Julia REPL
```

## Motivation

_Why this?_

This package allows you to check out what general kernels are available, all
from the Julia REPL / language server! Each kernel is represented by a type,
where the SPICE kernel flavor is encoded in Julia's type system and within an
enumerated type. Each requested kernel is cached by default, so there's no need
to download a kernel more than once!

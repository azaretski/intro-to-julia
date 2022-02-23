# Intro to Julia
# This program was tested on Julia 1.7.2
# (c) Aliaksandr Zaretski, 2022

# General points
# (1) Comments start with "#". 
# (2) In VS Code, blocks/sections of code start with "##". There is a command to execute just the current block.
# (3) For instructional purposes, most code in this workshop is executed in global scope; in practice, you should put time-consuming code inside functions.

# Executing code in VS Code (irrelevant if you run Julia REPL from terminal)
# (1) Go to "View" -> "Command Palette" -> type "julia repl" and "julia execute" -> observe hotkeys relevant for your machine. (The following applies to Windows.)
# (2) Click "Julia: Execute active File in REPL" in the top right corner to run the whole active file.
# (3) Ctrl + Enter runs the current line of code.
# (4) Shift + Enter runs the current line of code and goes to the next line.
# (5) Alt + Enter runs the current block of code.

# Getting help
# (1) Enter help mode by typing "?" in Julia REPL -> the prefix will change from "julia>" to "help?>".
# (2) Type the command you wish to know about.

# Using the package manager
# (1) Enter package mode by typing "]" in Julia REPL -> the prefix will change from "julia>" to "pkg>".
# (2) Do the necessary operations.
# (3) Exit package mode by typing "Backspace".

# Activating project package environment (optional for this workshop)
# (-) In the package mode, execute "activate path", where "path" is the full path to the project directory.
# (-) In the package mode, execute "activate ." if the project is in the current working directory.

# Adding external packages to project package environment (this workshop does not use any external packages)
# (1) Activate project package environment.
# (2) Execute "add name", where "name" is the name of the package you wish to add to project.

# Instantiating project package environment on another machine
# (1) Activate project package environment; your project directory must have "Project.toml" and "Manifest.toml" files created on another machine.
# (2) Execute "instantiate" -> this will install, if needed, all packages relevant for your project.



versioninfo()   # Julia function "versioninfo" that returns some info about your machine and Julia version



## -----------
#  File system
#  -----------

# Working directory (wd)
pwd()       # current wd
readdir()   # contents of wd

# Changing wd
cd("C:/GitHub/intro-to-julia")  # full path
cd("..")                        # set wd to that containing the current one (one level up)
cd("intro-to-julia")            # come back
cd("../..")                     # two levels up
cd("GitHub/intro-to-julia")     # come back

# Existence of directories
isdir("../intro-to-julia")  # is there such directory? (yes, it is our wd)
isdir("tmp")                # no such directory
isdir("main.jl")            # this is a file, not a directory

# Existence of files
isfile("main.jl")           # is there such file in wd?
isfile("../intro-to-julia") # this is a directory, not a file

# Existence of paths (either directory or file)
ispath("../intro-to-julia")
ispath("main.jl")



## -------------------------------
#  Variables, types, and constants
#  -------------------------------

# Numeric scalars
x=10            # variable "x" with integer value "10"
typeof(x)       # type of x
sizeof(x)       # size of x in memory in bytes
bitstring(x)    # binary representation (64 bits)

# More numeric types
x=11;           # assign a new value to "x"; if you run this directly in the terminal, the value will not be displayed (note ";" at the end of line)
x=11.0          # real float (note the decimal point)
x=2//3          # rational with numerator 2 and denominator 3
x=2+3*im        # complex with real part 2 and imaginary part 3 ("im" is the imaginary unit)
x=2.0+3.0*im    # note the difference in types with previous variable
real(x)         # real part
imag(x)         # imaginary part
isreal(x)       # check for being (convertable to) a real number
isfinite(x)     # check for being a complex number with finite real and imaginary parts

# Infinity and not-a-number
x=Inf   # positive infinity
x=NaN   # not-a-number (e.g., indeterminacy)
isinf(-Inf)     # check for infinity
isnan(Inf-Inf)  # check for NaN

# Constants
const a=10  # "const" tells Julia that the value of "a" will not change; this is mainly useful if you decide to use global variables (which is not recommended) 

# Mathematical constants
π   # the number π; the Greek letter is produced by typing "\pi" and clicking "Tab"
ℯ   # the base of natural log: "\euler" + "Tab"
MathConstants.pi    # π
MathConstants.e     # ℯ

# Boolean
y=true
y=false

# Characters
z='J'
Int(z)      # character -> Unicode code point
Char(74)    # Unicode code point -> character

# Strings
z="Julia"
z="Юлія"    # Unicode is fully supported
z="朱莉娅"
z="Ιουλία"
z="जूलिया"
z="Iúile"
z="줄리아"
z="جولیا"

# Type conversion
convert(Float64, 10)        # convert integer to float
Float64(10)                 # equivalent
float(10)                   # equivalent here but also applies to arrays
Bool(10)                    # does not work; x must be convertable to 1.0 (true) or 0.0 (false)
convert(ComplexF64, true)   # works since true corresponds to 1.0



## ---------------------------
#  Basic operations on scalars
#  ---------------------------

# Elementary operations
((20+12-5)/9*5)^2   # "/" is real division that evaluates to Float (integers are converted to floats)

# Integer arithmetic
23÷5        # integer division: "\div" + "Tab"
div(23,5)   # equivalent
23 % 5      # remainder from integer division
mod(23,5)   # equivalent
rem(23,5)   # equivalent

# Comparison (logical output)
3>2
3<=2
2+2==5  # equality
2+2!=5  # inequality
2<3<4<5 # chaining comparison

# Subtleties to be aware of
NaN==NaN            # gives false
isequal(NaN,NaN)    # gives true (think of being the same "objects")
NaN===NaN           # gives true (think of being identical from machine's perspective)
-0.0==0.0           # mathematically equivalent
isequal(-0.0,0.0)   # but different "objects"

# Rounding
round(2.5)  # ties are rounded to nearest even integer by default
round(2.5, RoundNearestTiesAway)    # this may or may not be the method you learnt at school
round(2.567, digits=2)              # round to nearest 2 digits
ceil(2.5)   # round up
floor(2.5)  # round down
trunc(2.5)  # round towards zero

# Sign
sign(-10)
sign(-10.0) # output type corresponds to input type

# Some elementary functions
atan(sin(log(exp(sqrt(abs(-10))))))

# Updating
x=10
x=x+1
x+=1    # other appropriate operators can be used this way

# Boolean arithmetic
x=true
y=false
!x      # negation
x && y  # and, short circuit (if x is false, y is not evaluated, since result is false) 
x || y  # or, short circuit
x == y  # equivalence
x != y  # inequivalence

# Bitwise operators
~x      # negate each bit (for logical values, the same result as !)
x & y   # and (for logical values, the same result as &&)
x | y   # or (for logical values, the same result as ||)



## -------
#  Strings
#  -------

# String consists of Char
s="Julia"
s[begin]        # single index -> Char
s[1]==s[begin]  # equivalent
s[end]

# Substring
s[1:4]  # index range -> String (substring)
s[1:1]  # different from s[1]

# Conversion and concatenation
string("Today is February ", 23, ", ", 2022, ".")

# Concatenation of strings with "*" operator
"falling sick on a journey" * " / " * "my dream goes wandering" * " / " * "over a field of dried grass" # (Matsuo Bashō, 1694)

# New line character
s="falling sick on a journey\nmy dream goes wandering\nover a field of dried grass" # "\n" character indicates a new line
println(s)

# Multiple-line strings
s="Мы ўсе і так жывём цішэй травы,
напятыя на страха-людных кроснах.
Скрадзі ж мяне адсюль: сярод жывых
больш непрытульна мне, балюча, млосна.
Ты бачыш, я згараю заранёў,
дык адпусці ў зямлю маю – дахаты.
Я толькі між імхоў і каранёў
напраўду пачувалася багатай.
Маўчыш? Ну што ж, давай, маўчы, маўчы…
Заплюшчвай вочы, адмаўляйся, грэбуй,
пакуль мой дом шматаюць крумкачы
сабе на ўцеху, монстру на патрэбу." # (Nasta Kudasava, 2022)
println(s)

# Double quotes inside strings using escape character "\"
s="\"We're not dead yet,\" said Julia prosaically." # (George Orwell, "Nineteen Eighty-Four")
println(s)

# Long single-line strings can be input on multiple lines using "\"
"I dream of it often: \
a younger version of myself, \
standing at the bottom of the ocean; \
arms aloft, \
mouth agape, \
eyes glaring, \
not seeing, \
not breathing, \
still as stone in a watery fane."   # (Joshua Eustis, 2019)

# Interpolation into strings
"Approximately, $(4.6*1e3/230) galactic years have passed since the birth of the Solar System."  # note "$()"

# Some useful functions
s="hippopotamus"
length(s)   # number of characters
'u' in s    # presence of character in string
occursin("hippo", s)    # presence of substring in string
occursin("hippie", s)   # not present
findall('p', s)         # indices of character matches
findfirst('p', s)       # only first
findlast('p', s)        # only last
findall("po", s)        # index ranges of substring matches



## ---------
#  Functions
#  ---------

# Compact definition
f(x,y)=sin(x^2+y^2) # defines function "f" of two variables
f(sqrt(π/2),0)      # evaluates f at a point (sqrt(π/2),0)

# More general definition
function f(x,y)
    return sin(x^2+y^2) # "return" causes function to return the following value immediately; the last evaluated expression is returned by default
end
f(sqrt(π/2),0)

# Fixing an argument
g(x)=f(x,2) # a typical application is providing "g" as an argument to some other function

# Anonymous function
(x,y) -> x^2+y^2    # similar to above, useful when a function is an argument to other function and the former had not been defined

# Multiple outputs
function f(x,y)
    return (x+y,x-y)    # the output is a tuple
end
f(0,1)
x,y=f(0,1)  # the left-hand side is a tuple (brackets are optional)
x
y

# No inputs/outputs
function f()
    println("We have learnt something today, have we?") # Have we?
    return nothing  # in this case, both "return" and "nothing" are redundant; moreover, either of them can be used alone
end
f()

# Methods
function mydiv(x::Float64, y::Float64)
    x/y # real division
end
function mydiv(x::Int64, y::Int64)
    x÷y # integer division
end
function mydiv(x::String, y::String)
    length(x)/length(y) # "string division"
end
mydiv(5.0,2.0)
mydiv(5,2)
mydiv("Julia","C++")
mydiv(5,2.0)    # no relevant method defined

# Optional arguments
function f(x,y,z=5)
    x+y+z
end
f(0,0)
f(0,0,10)   # if the third argument is explicitly given, it is used instead of the default value of 5



## ------------
#  Control flow
#  ------------

# Conditionals
if isfile("functions.jl")
    include("functions.jl") # execute all code from the file "functions.jl" located in the working directory
else
    error("Hm. There is no \"functions.jl\" in the working directory.") # throw error if there is no such file
end
# nicetomeetyou()   # due to an unsolved issue (https://github.com/julia-vscode/julia-vscode/issues/785), we need to run this directly from the terminal
# Note: all conditions must evaluate to logical values!

# For loop: "in" set version
s="Julia"
for c in s
    println(c)
end

# For loop: "=" set version
s=0
for i=1:10
    s+=i
end
println(s)

# While loop
it=0
while it<5000
    it+=1
    println(bitstring(rand()))  # welcome to the Matrix!
end

# For and while loops introduce local scope
# j=0
for i in 1:10
    j=i
end
println(j)  # if j was not defined before the loop, there would be an error

# Exiting a loop immediately
x=rand(1:100)   # pseudorandom integer from [1,100] interval 
for i=1:100
    if i==x
        println("Found x in ", i, " iterations.")
        break   # immediately exit the loop
    end
end

# Going to next iteration immediately
s=0
for i=1:100
    if mod(i,10)!=0
        continue
    end
    s+=i    # sum over multiples of 10
end
println(s)

# Multidimensional iteration
for i=0:9, j=1:10
    println(i*10+j)
end

# Catching errors
s=0
for i=1:100
    x=2*rand()-1    # pseudorandom real number from [-1,1] interval
    try
        s+=log(x)
    catch
        println("Can't take log of negative real number.")
    end
end
println(s)



## ------
#  Arrays
#  ------

# Vectors
x=Vector{Float64}(undef,2)  # create 2-element uninitialized real vector (a binding to a memory address is created, and the values shown are those present at that address)
x=Array{Float64}(undef,2)   # equivalent (but note the difference in values: the memory address is different and has generally different content)
y=similar(x)                # array of the same type and dimension as x

# Matrices
x=Matrix{Float64}(undef,2,2)    # 2-by-2 uninitialized real matrix
x=Array{Float64}(undef,2,2)     # equivalent

# 3D+ arrays
x=Array{Float64}(undef,2,2,2)   # 2-by-2-by-2 uninitialized real array
length(x)   # number of elements
size(x)     # dimension (a tuple)

# Initialized arrays
zeros(2)
ones(2)
trues(2)
falses(2)
fill(NaN,2)  # 2-element vector of NaN values
rand(2)

# Manually filling an array
x=[1,2]     # vector: elements separated with ","
x=[1 2;3 4] # matrix: row elements separated with " ", columns with ";"

# In-place fill
x=float(x)  # need to change type to Float64 before running next line (why?)
fill!(x,π)  # by convention, "!" at the end of function name indicated that function modifies its argument, which is matrix "x"

# Matrix arithmetic
ones(2,2)+zeros(2,2)    # addition
ones(2,2)*ones(2,2)     # multiplication
5*ones(2,2)             # multiplication by a scalar
ones(2,2)*ones(2,1)     # matrix*vector
ones(2,2)*ones(2)       # mathematically equivalent but different types

# Indexing
x=rand(3,3)
x[1,1]
x[end,end]
x[1,:]      # row as 3-vector
x[1:1,:]    # row as 1x3 matrix
x[:,3]
x[:,3:3]
x[[1,3],[1,3]]  # submatrix
x[4]    # 4-th element of vectorized array

# Logical indexing
x[x.<0.5]           # gives vector (note "."---the broadcasting symbol)
x[x[:,2].<0.5,2]    # check only second column

# Reshaping
x=rand(2,2)
x[:]            # vectorization (stack columns)
reshape(x,1,4)  # reshape into 1x4 matrix (done by columns)

# Transpose
x'              # conjugate transpose
transpose(x)    # "simple" transpose (permute dimensions), equal to the above for real matrices

# Inverse
A=rand(2,2)
inv(A)
A^(-1)      # numerically equivalent
A\[1 0;0 1] # numerically equivalent
A*inv(A)    # numerically, identity matrix

# Concatenation
x=zeros(2,2)
y=ones(2,2)
[x;y]   # vertical concatenation
[x y]   # horizontal concatenation
[x,y]   # 2-vector of 2x2 matrices

# Copy bound to the same memory address
x=rand(2,2)
y=x
x===y   # x and y represent the same matrix located at a specific memory address
y[1]=10
x   # both x and y refer to the same matrix; changing an element in y does so for x too
y

# Copy bound to a different memory address
x=rand(2,2)
y=copy(x)
x==y    # same values
x===y   # but different matrices: y is located at a different memory address
y[1]=10
x   # now x remains unchanged
y

# Deep copy
x=[rand(2),rand(2)] # 2-vector of 2-vectors
y=copy(x)
y[1]=rand(2)
x   # remains unchanged
y
y=copy(x)
y[1][1]=10
x   # changed! "copy" affects only one level deep
y
y=deepcopy(x)   # deep copy, work recursively
y[1][1]=100
x   # remains unchanged
y



## -----------------
#  Ranges and tuples
#  -----------------

# Ranges
x=1:10  # integers from 1 to 10
x[1]
x[1]=0  # ranges are immutable (values cannot be changed)
collect(x)  # transform to vector
collect(range(1,10,length=50))  # equally spaced grid of 50 real numbers in [1,10] interval (transformed to vector)

# Tuples
x=(1,2) # 2-tuple
x[1]
x[1]=0  # tuples are immutable as well

# Combinining tuples
y=(3,4)
(x,y)       # 2-tuple of 2-tuples
(x...,y...) # 4-tuple

# Range -> Tuple <-> Vector
collect(1:10)   # range -> vector
(1:10...,)      # range -> tuple
y=collect(x)    # tuple -> vector
(y...,)         # vector -> tuple

# Splatting a tuple in function arguments
f(x,y)=x+y
z=(1,2)
f(z...) # splatting can be done with vectors and ranges as well



## ---------------------------------
#  Functions on arrays, broadcasting
#  ---------------------------------

# (Mutable) Arrays are passed to functions by sharing (not copied)
A=rand(2,2)
function fun!(A)
    A[1]=10
    return nothing
end
fun!(A)
A   # note that A[1] was updated in outer scope even though function creates local scope

# Broadcasting matrix operations
A=rand(2,2)
A+1 # dimensions do not match; we want to add 1 to each element of A; we must explain this to Julia
A.+1                # "." is the broadcasting operator
broadcast(+,A,1)    # equivalent; note that "+" is viewed as a function, that is, +(x,y)=x+y
b=rand(2,1)
A+b     # dimensions do not match; we want to add column vector b to each column of matrix A
A.+b    # the way to do it

# Broadcasting functions to each element of array
A=rand(2,2)
exp.(A) # exp of each element
exp(A)  # this a different operation: matrix exponential

# Broadcasting macro
A=rand(2)
B=rand(2)
A^2+B^2+1       # we want to use "^" and the last "+" element-wise 
A.^2+B.^2 .+1   # extra space is needed to avoid confusion between "2." and ".+"
A.^2 .+B.^2 .+1 # preferred way: the additional ".", while not required (vector addition is valid), allows to fuse operations in a single loop
@. A^2+B^2+1    # "@." macro automatically puts all the dots as in the previous line

# In-place broadcasting
A=rand(2,2)
B2=similar(A)
@time B1=A.+1    # "@time" macro measures execution time and memory allocations; generally, need to run at least twice to account for compilation
@time B2.=A.+1   # efficient way
B1==B2

# Element-wise boolean arithmetic
A=rand(Bool,2,2)
B=rand(Bool,2,2)
.~A     # .! is also available
A .& B  # .&& is also available
A .| B  # .|| is also available
A .== B
A .!= B



## ---------------
#  Multi-threading
#  ---------------

# Check number of active threads
Threads.nthreads()  # Threads

# Setting number of threads
# (1) In VS Code, click "Ctrl" + "," -> this should open settings -> search for "julia threads" -> Set "Julia: Num Threads" as desired -> restart REPL
# (2) From the Windows/Mac/Linux terminal, run Julia REPL executing "julia --threads n", where "n" is the number of threads;
#                                                                   "julia --threads auto" will set "n" to the number of logical CPUs on your machine

# Function with single-threaded loop 
function matmaxs(A)
    ind=eachindex(A)
    B=similar(A)
    for i in ind
        B[i]=maximum(A[setdiff(ind,i)]) # B[i] is the maximum over A excluding A[i]
    end
    return B
end

# Function with multi-threaded loop 
function matmaxm(A)
    ind=eachindex(A)
    B=similar(A)
    Threads.@threads for i in ind
        B[i]=maximum(A[setdiff(ind,i)])
    end
    return B
end

# Compare
A=rand(5000)
@time B1=matmaxs(A);
@time B2=matmaxm(A);    # a few more memory allocations but significantly faster even with 2 threads
B1==B2



## ---------------------
#  Distributed computing
#  ---------------------

Threads.nthreads()  # for a fair comparison, verify that there is one thread

# Adding Julia processes
using Distributed   # load standard Julia library for distributed computing
nprocs()            # current number of Julia processes
addprocs(2)         # add Julia processes; must be at least 2 (otherwise, no effect)
nworkers()          # nworkers() = max(1, nprocs() - 1)

# Shared objects
@everywhere begin   # make the following code available for all processes
    using SharedArrays  # load standard Julia library to work with shared arrays
    # Function with distributed loop
    function matmaxd(A)
        ind=eachindex(A)
        B=SharedArray{eltype(A)}(size(A))   # Shared array of the same size and element type as A
        @sync @distributed for i in ind
            B[i]=maximum(A[setdiff(ind,i)])
        end
        return B
    end
end

# Compare
A=rand(5000)
@time B1=matmaxs(A);
@time B2=matmaxd(A);    # both less memory allocations and significantly faster even with 2 processes
B1==B2



## ---------------------
#  Some performance tips
#  ---------------------

# (-) All performance-intensive code should be inside functions.
# (-) Except when practicing in REPL, do not use global variables. (Pass all variables to functions.)
# (-) Do not initialize arrays twice: use "undef" when creating an array or use "similar" function when appropriate.
# (-) Access arrays from the last to the first dimension: e.g., outer loop on matrix columns, inner loop on rows.
# (-) Use in-place array operations with "." to reduce memory allocations.
# (-) Predefine arrays used in functions, when appropriate, to reduce memory allocations.
# (-) Use "view" to operate on array slices when possible. (Does not create a copy.)
# (-) Broadcast with "@." (or put dots "everywhere") to create single fused loops.

# The same as "matmaxs" but using array "view" instead of direct access
function matmaxv(A)
    ind=eachindex(A)
    B=similar(A)
    for i in ind
        B[i]=maximum(view(A,setdiff(ind,i)))
    end
    return B
end

# Compare
A=rand(5000)
@time B1=matmaxs(A);
@time B2=matmaxv(A);    # less memory allocations and runs faster
B1==B2
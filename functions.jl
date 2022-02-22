# Nice to meet you
function nicetomeetyou()
    println("Hi! What is your name?")
    x=readline()    # read a single line to a string and assign to a variable "x"
    if x==""
        println("Interesting name! Nice to meet you!")
    elseif x=="Julia"
        println("What a coincidence! I am also Julia. Nice to meet you!")
    else
        println("Nice to meet you, "*x*"!")
    end
end
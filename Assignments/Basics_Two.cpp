/*

* This will be an introductory assignment but in C++ so we can officially start looking at some proper object orientation
* outside of the Lua language itself. While we will still be using Lua in our future because it's a nice and easy scripting
* langauge to code in - we will also start to explore MULTIPLE programming languages all the at the same time :D

* If you wince at that statement; don't worry. All software engineers primarily use only a few languages but it's good to
* expand those brain cells now while you can so we get you used to programming. But for now; let's focus on this assignment.


WHAT YOU WILL LEARN:
    In this assignment, basics_two.cpp, you will be learning expanding and converting your knowledge we have looked at thus far
    in Lua. The first portion of the assignment should hopefully be all concepts you are familiar with and the second part will
    be the brain melting portion (don't worry, or do, I'm not your mother).


INITIAL INSTRUCTIONS:
    Your homework in this is a bit different; you are not going to be able to paste all your answers in a copy of this
    assignment because you will create a directory to submit your homework because C++ uses at least a few files for
    implementation. This assignment is thought to be taken alongside Harvard's introductory programming course (which
    is currently free and has been for years online) so some modicum of understanding of C++ is likely to be expected.

    Step 1: Create a new directory (preferably called something like "basics_two_homework" or something. NO SPACES). 
    Step 2: -> Do the assignment


ASSIGNMENT:


Question 1: Below are some examples of C++ objects inside a main class; this question has two subparts.

//////////////////////////////////////////////////////////////////////////////
// @file main.cpp
#include <iostream>

int main(int argc, char** argv)
{
    // In linux/computers; a 0 is a GOOD return (meaning everything succeeded). Numbers that are not 0 (typically 1) mean
    // a failure has occured somehow. We will assume we have failed until succeeded; so initializing returnValue with bad
    // value first
    int returnValue = 1;
    std::string input = "";

    std::cout << "Hello world!" << std::endl;
    std::cout << "What's your name? >> ";
    std::cin >> input;

    return returnValue;
}
//////////////////////////////////////////////////////////////////////////////

Question 1a: You can see we have a simple program here that does some very simple things. What are those things?
----- 1a


----- 1ae

Question 1b: What is std? What does it mean to follow "std" up with "::cout" or "::cin" and not ".cout" or ".cin"
             as if they were object member variables? Like std.cout? or std.cin?
             (https://cplusplus.com/forum/beginner/61121/) -> what is std
             (https://stackoverflow.com/questions/11442293/when-to-use-and-when-to-use) -> :: vs . (first answer only)
----- 1b

----- 1be

Question 2: What is the importance of the physical function main()? Is it required?
            (https://learn.microsoft.com/en-us/cpp/c-language/main-function-and-program-execution?view=msvc-170)

----- 2

----- 2e

Question 3: Below is some Lua code, port it to a C++ main function class


/// LUA CODE BELOW

a = 5
b = "string"
c = tostring(5) .. b
print(a .. " " .. b .. " " .. c)
write("what's your name? >> ")
input = read()
print("Hello " .. input)

/// LUA CODE END


// Class structure; because I'm nice.
//////////////////////////////////////////////////////////////////////////////
// @file main.cpp

#include <iostream>

int main(int argc, char** argv)
{
    // Code here
}
//////////////////////////////////////////////////////////////////////////////


Question 4: What is a "data type" in C++? What are some different types of data types? (Do your own research and link article!)
----- 4

----- 4e

Question 5: How big are the following data types in bytes and why are there "sizes" to data types?
        (https://learn.microsoft.com/en-us/cpp/cpp/data-type-ranges?view=msvc-170)
    5a. int
    5b. unsigned int (also; what's the difference between this and int?)
    5c. long

----- 5

----- 5e

Question 6: What does it mean to be a signed data type versus unsigned data type?

Question 7: Convert the following decimals to binary
    7a. 744
    7b. 1024
    7c. 1
    7d. 0
    7e. 115
    Show your work (explain the equation)

----- 7

----- 7e

Question 8: Convert the following binary numbers to decimal
    8a. 0101
    8b. 1110
    8c. 0001
    8d. 0000
    8e. 1111
    8f. 11110000
    8g. 10101001

----- 8

----- 8e

Question 9: So far, I hope you have enjoyed the questions because they have been very easy; now let's start to get more
            interesting. Please read the following link as to how you ADD two numbers in BINARY and add the following
            binaries together :'D (this little process is gonna cost you 94 years). SHOW YOUR WORK!!! (max pain)
        (https://byjus.com/maths/binary-addition/)    <- shows a helpful table hack that makes adding stupid easy
vid alt (https://www.youtube.com/watch?v=C5EkxfNEMjE) <- Video alternative. Organic chemistry tutor is good for math too
    9a. 010010101 + 10101001
    9b. 111111111 + 00000000
    9c. 111111111 + 11111111
    9d. 100001010 + 00010101
    9e. 011111011 + 10101010
    9f. 101010101 + 10101010

Question 10: What are the four main concepts of objected oriented programming? You don't need to read the examples (unless
             you want to). Put it in your own words
             (https://www.codingninjas.com/studio/library/four-pillars-of-oops)

----- 9

----- 9e

Question 11: WITHOUT LOOKING IT UP AS MUCH AS YOU CAN, READ THE FOLLOWING:

In binary, we know in 64 bit systems we read right to left; with the right-most digit being called the "MSB" 
(most significant bit) and left is called "LSB" (least significant bit). To convert any binary number to decimal; you
simply applying the following math eqn: Given some binary number... from right to most apply the summation (greek
sigma symbol) of 2^n + 2^n+1 + 2^n+1+1 + 2^n+1+1+...m, where m is equal to the number of digits minus 1. 

really simple example: 1001 -> 2^0 + 2^3 for binary to decimal. You DO NOT add 2^1 or 2^2 because the digit is 0 which is false
which means no data is in that spot. The reason we do m = size-1 is because we start at 0 in binary. So if you have the following
objects:

O O O O O O O O O O (10 objects, 'o')
0 1 2 3 4 5 6 7 8 9 -> 9 is the last object but we have 10 in size (but 10 is invalid because we only go until 9).

THE STATEMENT: In ANY binary number; the MSB will *ALWAYS* determine if a binary number is EVEN or ODD.
THE QUESTION:  Prove this statement. 

*/
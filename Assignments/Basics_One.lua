--[[

Basics_One.lua

Covering: Functional Programming; core programming concepts in Computer Science
Requirements: IDE (Visual Studio Code recommended)

Assignment:

    -- PRE-REQUISITES --
    Pre-Requisites: None

    -- MOTIVATION --
    In this assignment, we will be focusing on the basics of programming in general while using the Lua programming language to execute these concepts
    so that you may become a stronger programmer and understand the fundamentals more and more. The only way to learn code is to really just code more
    and more. This assignment will include a a mix of active coding questions plus questions

    -- CORE ASSIGNMENT --

    Question 1:
        What is Lua? Along with this, is Lua a strongly or weakly typed programming language?
        A:
        -- Answer in between lines

        -- Q1E

    Question 2 (https://press.rebus.community/programmingfundamentals/chapter/encapsulation/):
        2A: What is Encapsulation broadly? Make sure to reword your answer and don't copy-paste
            -- Q2A

            -- Q2E

        2B: What are the benefits of encapsulation? Why would you want to use this?
            -- Q2B

            -- Q2BE

        2C: What are all the key-terms in encapsulation? Reword from the article above
            -- Q2C

            -- Q2CE

        2D: Read the following two links and answer the sub questions, this will help you with questions 2E and 2F:
            (https://www.lua.org/pil/16.4.html) (https://www.upgrad.com/blog/what-is-data-hiding-in-c/)
        
        2E: Does Lua offer encapsulation? Why or why not? 
            -- Q2E

            -- Q2EE
            
        2F: What are the nuanced differences between data hding and data encapsulation? Do they involve each other typically?
            -- Q2F

            -- Q2FE

        2G: In the C++ code below, please explain what data members are being encapsulated inside what object
            -- Q2G

            -- Q2GE

        main.cpp ---------------------------------------------------------------------------
        #ifndef CPP_EXAMPLE
        #define CPP_EXAMPLE

        #include <iostream>

        // Main function - bonus points for looking up what a main() function does in programming languages
        int main(int argc, char ** argv)
        {
            int a = 4;
            int b = 5;

            { // What is a {}? This will help you answer your question
                int c = a + b;
                int d = c / (c * c)
            }

            // Printing
            std::cout << "Value of a: " << a << std::endl; // Will this run?
            std::cout << "Value of b: " << b << std::endl;
            std::cout << "Value of c: " << c << std::endl; // Will this run?
            std::cout << "Value of d: " << d << std::endl; // Will this run?

            return 0;
        }

        #endif
        ------------------------------------------------------------------------------------


    Question 3:
        Enough reading! Now to typing. Fix the following syntax issues in this code. Only fix the obvious errors, only add what is required to make
        the following code run.


        main.lua ---------------------------------------------------------------------------
        function SumOfTwo(a, b)
            return a +
        end

        function divide(a, b)

            if b == 0 then
                return nil

            return a / b
        end

        function return(a, b)
            return a + b
        end

        function main()
            print("Hello user! Welcome to a main function example!)
            write("please enter your name: ")
            if read() == "jared"
                print("from subway???")
            else
                print("you aren't jared")
            endd

            print("running other functions")
            print(SumOfTwo(1, 2))
            print(divide(4,5))
            print(divide(5,0))
            print(return(1,1))

            return 0
        end

        main()
        ------------------------------------------------------------------------------------

    Question 4: 
        We know Lua uses tables to sort of "fake" object oriented programming. In the answer box below, code the following:

        * 4 functions of your choice that do something (Complex functions not recommended, but will not be slandered either if they work)
        * These functions should be apart of a global table value; that is then returned at the end of the file
        * Reminder: The intention of this file is to be a complete HELPER file. There should be no code that runs in this file. Only functions
                    and variables outside functions if you require them. All global variables should be put at the TOP of the file (along with the
                    global return variable) and functions BENEATH these. 

        -- Q4




        -- Q4E

    Question 5 (https://www.lua.org/manual/5.4/manual.html#3.4.2):
        Read the above section of Lua documentation. In the answer box below, put small one-liners (simple) runnable lua lines that demonstrate
        how these bitwise operators work. Logic gates are exciting!

        -- Q5



        -- Q5E

    Question 6 (https://www.lua.org/manual/5.4/):
        This question exists not to give you pain; but to teach you that documentation is important (still involves pain lol). So in this case,
        in the Lua 5.4 manual, scroll to the bottom to the "Lua functions" part. Ignoring the C-API and Auxiliary library portions of this bit,
        choose any three (3) functions and in the below answer boxes; answer/do the following:
            1. What library is the function apart of?
            2. What does this function aim to do?
            3. Write runnable lua code that demonstrates this function


                -- EXAMPLE ----------
                1A: math.min is apart of the math library
                2A: This function aims to return the minimum value among a series of input; thus the variadic argument (...) in its constructor. 
                    math.min will use the bitwise '<' operator for this assignment internally

                3A:
                    { -- ignore these; just to define where code starts and stops. Not apart of Lua call

                        local a = 3
                        local b = 4
                        local c = 10

                        lowestValue = math.min(a,b,c)
                        print("lowest value: " .. lowestValue)

                        -- YOU DO NOT NEED TO DO THE FOLLOWING. IT IS PURELY FOR SHOW TO DEMONSTRATE HOW THIS FUNCTION IS USING THE '<' BITWISE
                        -- OPERATOR

                        function custom_min(x, ...) -- Google 'lua variadic arguments' for more content on the '...'
                            local curMin = x -- There 
                            for i=1,#args do -- args is a lua keyword which in this case will refer to all arguments under '...'
                                local val = args[i]
                                if val < curMin then
                                    curMin = val
                                end
                            end
                            return curMin
                        end
                    }

                -- EXAMPLEE

                -- func1 ----------



                -- func1E --

                
                
                -- func2 ----------




                -- func2E --



                -- func3 ----------




                -- func3E --

    Question 7:
        Why is it a good idea to "re-use" code? How would you go about re-using code? Have you already done this?
        
    Question 8:
        Extra question! I want you to Google best introductory computer science projects (or software projects) and list out a
        a few that take your interest and there may be something on this in the future. It is always a good idea to be actively
        working on a project as you do actual work for these assignments. Remmeber to include why you are listing the project idea
        and why it's interesting to you to do.

]]--


### **1. What is a Task?**

-   A **task** is a block of code that performs a specific operation in your design or testbench.
    
-   You can **call a task** multiple times from different places to avoid writing the same code again.
    
-   Think of it like a **function**, but with more flexibility.
    

**Key differences from functions:**

|               Feature               |  Function  |              Task             |
|:-----------------------------------:|:----------:|:-----------------------------:|
| Returns a value?                    | Yes        | No (but can use output ports) |
| Can have delays (#, wait)           | No         | Yes                           |
| Can have time-consuming operations  | No         | Yes                           |
| Can have input, output, inout ports | Only input | Input, output, inout          |


### **2. Syntax of a Task**

```
task task_name;
    // variable declarations (optional)
    input [7:0] a;      // input port
    output [7:0] b;     // output port
    inout [7:0] c;      // inout port
begin
    // your code here
end
endtask
``` 

----------

### **3. Example 1: Simple Task Without Ports**

```
module tb;
    task say_hello;
        begin
            $display("Hello SystemVerilog!");
        end
    endtask

    initial begin
        say_hello();   // calling the task
    end
endmodule
``` 

**Output:**

`Hello SystemVerilog!` 

----------

### **4. Example 2: Task With Ports**

```
module tb;
    task add_two_numbers;
        input [7:0] a, b;
        output [7:0] sum;
        begin
            sum = a + b;
        end
    endtask

    reg [7:0] result;
    initial begin
        add_two_numbers(10, 20, result);
        $display("Result = %d", result);  // Result = 30
    end
endmodule
``` 

✅ Here, `input` is for values you pass in, `output` is for values the task gives back.

----------

### **5. Example 3: Task With Delay**

```
module tb;
    task wait_and_print;
        input integer delay_time;
        input [7:0] data;
        begin
            #delay_time;
            $display("Data after delay: %d", data);
        end
    endtask

    initial begin
        wait_and_print(5, 100);  // waits 5 time units and prints 100
    end
endmodule
``` 

-   Tasks **can include delays**, unlike functions.
    

----------

### **6. Calling Tasks**

-   Tasks can be called in **initial** or **always** blocks.
    
-   Example:
```
initial begin
    my_task();
end

always @(posedge clk) begin
    my_task();
end
```


----------

### ✅ **Quick Summary**

-   Tasks are **reusable code blocks**.
    
-   Can have **input, output, inout ports**.
    
-   Can include **delays** and **time-consuming operations**.
    
-   Functions cannot have delays; tasks can.
    
-   Call them from **initial**, **always**, or **other tasks**.

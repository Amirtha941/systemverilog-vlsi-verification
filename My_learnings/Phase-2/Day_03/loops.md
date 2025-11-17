
## 🧠 What are loops?

Loops in **SystemVerilog** are used to **repeat a set of statements multiple times** — like doing the same thing for every array element, every clock cycle, etc.

They’re similar to loops in C, C++, or Python.

----------

## 🌀 Types of Loops in SystemVerilog

There are **five** main types of loops:

|        Type        |               When to Use              |              Example             |
|:------------------:|:--------------------------------------:|:--------------------------------:|
| 1. for loop        | When you know how many times to repeat | for (int i = 0; i < 10; i++) ... |
| 2. foreach loop    | To loop over arrays                    | foreach (arr[i]) ...             |
| 3. while loop      | Repeat while a condition is true       | while (a < 5) ...                |
| 4. do...while loop | Execute first, then check condition    | do ... while (a < 5);            |
| 5. forever loop    | Infinite loop (used in testbenches)    | forever #10 clk = ~clk;          |



## 💡 Let’s understand each with **simple examples**

----------

### 1️⃣ `for` loop

Used when you **know the number of iterations**.

```
module for_loop_example;
  initial begin
    int i;
    for (i = 0; i < 5; i++) begin
      $display("Value of i = %0d", i);
    end
  end
endmodule
``` 

🗒️ Output:

```
Value of  i  =  0 
Value of  i  =  1 
Value of  i  =  2 
Value of  i  =  3 
Value of  i  =  4
```

----------

### 2️⃣ `foreach` loop (⭐ SystemVerilog special)

Used **only with arrays** — automatically loops through all indexes.

```
module foreach_example;
  int arr[5] = '{10, 20, 30, 40, 50};
  initial begin
    foreach (arr[i]) begin
      $display("arr[%0d] = %0d", i, arr[i]);
    end
  end
endmodule
``` 

🟩 No need to specify index bounds manually — SystemVerilog does it!

----------

### 3️⃣ `while` loop

Used when you **don’t know** how many times it’ll repeat.

```
module while_example;
  initial begin
    int a = 0;
    while (a < 3) begin
      $display("a = %0d", a);
      a++;
    end
  end
endmodule
``` 

----------

### 4️⃣ `do...while` loop

Runs **at least once**, then checks the condition.

```
module do_while_example;
  initial begin
    int b = 0;
    do begin
      $display("b = %0d", b);
      b++;
    end while (b < 3);
  end
endmodule
``` 

----------

### 5️⃣ `forever` loop

Runs infinitely — mainly used for **clock generation** in testbenches.

```
module forever_example;
  bit clk = 0;
  initial begin
    forever #5 clk = ~clk; // toggle clk every 5 time units
  end
endmodule
``` 

----------

### ✅ **What is a Format Specifier?**

A **format specifier** tells the simulator **how to display a value** (binary, decimal, hex, string, etc.).

Example:

`$display("Value = %d", my_var);` 

Here:

-   `%d` → tells to print the value in **decimal** format.
    
-   `my_var` → the variable whose value is printed.
    

----------

## **📝 SystemVerilog Format Specifiers Cheat Sheet**

### 1️⃣ **Integer/Bit Values**

| Specifier |            Description            | Example |
|:---------:|:---------------------------------:|:-------:|
| %b        | Binary                            | 1010    |
| %0b       | Binary, no leading spaces/padding | 1010    |
| %d        | Decimal (signed)                  | 10      |
| %0d       | Decimal, no padding               | 10      |
| %u        | Unsigned decimal                  | 10      |
| %h        | Hexadecimal                       | A       |
| %0h       | Hex, no padding                   | A       |
| %o        | Octal                             | 12      |


2️⃣ **Characters & Strings**

| Specifier |       Description       | Example |
|:---------:|:-----------------------:|:-------:|
| %c        | Single character        | A       |
| %s        | String (array of chars) | "Hello" |

3️⃣  **Floating Point / Real Numbers**

| Specifier |               Description               |  Example |
|:---------:|:---------------------------------------:|:--------:|
| %f        | Decimal real/float                      | 3.1415   |
| %e        | Scientific notation                     | 3.14e+00 |
| %g        | Shortest representation (like %f or %e) | 3.14     |

4️⃣ **Time & Simulation Info**

| Specifier |        Description       |   Example  |
|:---------:|:------------------------:|:----------:|
| %t        | Simulation time          | 50         |
| %m        | Module hierarchical path | top.module |


### 5️⃣ **Width & Padding**

-   `%5d` → Minimum 5 characters wide, padded with spaces
    
-   `%05d` → Minimum 5 characters, padded with zeros
    
-   `%0d` → No padding
    

Example:

```
$display("%5d", 12);  // Output: "   12"
$display("%05d", 12); // Output: "00012"
``` 

----------

### 6️⃣ **Practical Example**

```
module test;
  int x = 10;
  real pi = 3.1415;
  string name = "Amirtha";

  initial begin
    $display("Binary: %b", x);
    $display("Hex: %h", x);
    $display("Decimal: %d", x);
    $display("Real: %f", pi);
    $display("String: %s", name);
    $display("Time: %t, Module: %m", $time);
  end
endmodule` 
```
**Output:**

```
Binary: 1010
Hex: A
Decimal: 10
Real: 3.141500
String: Amirtha
Time: 0, Module: test

```



## **What is `%p`?**

-   `%p` stands for **print entire data structure**.
    
-   It prints the **full contents of arrays, queues, structs, classes, or associative arrays** in a human-readable way.
    
-   Very handy for **debugging complex variables**.
    

----------

## **Examples**

### 1️⃣ **Dynamic Array**

```
module test;
  int da[] = '{1, 2, 3, 4};
  initial begin
    $display("Dynamic Array = %p", da);
  end
endmodule
``` 

**Output:**

`Dynamic  Array  = '{1, 2, 3, 4}` 

----------

### 2️⃣ **Queue**

```
module test;
  int q[$] = '{10, 20, 30};
  initial begin
    $display("Queue = %p", q);
  end
endmodule
``` 

**Output:**

`Queue = '{10, 20, 30}` 

----------

### 3️⃣ **Struct**

```
typedef struct {
  int id;
  string name;
} person_t;

module test;
  person_t p = '{id: 101, name: "Amirtha"};
  initial begin
    $display("Person = %p", p);
  end
endmodule
```

**Output:**

`Person = '{id:101, name:"Amirtha"}` 

----------

### 4️⃣ **Associative Array**

`module test;
  int aa[string]; // key = string, value = int
  initial begin
    aa["one"] = 1;
    aa["two"] = 2;
    $display("Assoc Array = %p", aa);
  end
endmodule` 

**Output:**

`Assoc  Array  =  '{"one":1,  "two":2}` 

----------

## **Key Points**

-   `%p` automatically **formats nested data**.
    
-   Works for:
    
    -   Dynamic arrays
        
    -   Queues
        
    -   Associative arrays
        
    -   Structs
        
    -   Classes (prints fields)
        
-   Saves you from writing loops to print contents manually.
    

----------

💡 Think of `%p` as **“pretty-print” for complex data structures** in SystemVerilog.



## **1️⃣ `%d` vs `%0d`**

### ➤ `%d`

-   Prints the **value in decimal**.
    
-   Adds **padding spaces** in some tools (depends on width formatting).
    
-   It’s the **normal print**.
    

### ➤ `%0d`

-   The **`0`** tells SystemVerilog to **suppress padding and leading spaces**.
    
-   It prints the **value only**, cleanly, with **no extra spaces**.
    

### 🧩 Example:

```
module test;
  int a = 10;
  initial begin
    $display("Value with %%d  = '%d'", a);
    $display("Value with %%0d = '%0d'", a);
  end
endmodule
``` 

**Possible Output:**

`Value  with %d  = '        10' // padded with spaces (depends  on width) Value  with %0d = '10' // no padding` 

✅ `%0d` ensures **compact output** (good for logging multiple numbers in one line).

----------

## **2️⃣ `%b` vs `%0b`**

### ➤ `%b`

-   Prints **binary representation**.
    
-   May **pad with spaces** if width is not fixed.
    

### ➤ `%0b`

-   Removes any **extra padding**.
    
-   Prints only the **exact bits**.
    

### 🧩 Example:

```
module test;
  bit [7:0] x = 8'b00001010;
  initial begin
    $display("%%b  : '%b'", x);
    $display("%%0b : '%0b'", x);
  end
endmodule
``` 

**Output:**

`%b  : '00001010'  // sometimes same, but with larger fields may include spaces %0b : '00001010'  // guaranteed no spaces` 

👉 The difference is **mostly visible** when used in **formatted field widths**.


## **3️⃣ `%h` vs `%0h`**

Same logic applies:

| Format |              Description              |
|:------:|:-------------------------------------:|
| %h     | Hexadecimal with possible padding     |
| %0h    | Hexadecimal without spaces or padding |


### 🧩 Example:

`module test;
  logic [15:0] val = 16'h0A1B;
  initial begin
    $display("%%h  : '%h'", val);
    $display("%%0h : '%0h'", val);
  end
endmodule` 

**Output:**

`%h  : ' a1b'  // possible space before number %0h : 'a1b'  // clean, no space` 

----------

## ✅ **Summary Table**


| Format |   Base  | Pads with spaces? |   Typical Use   |
|:------:|:-------:|:-----------------:|:---------------:|
| %d     | Decimal | Yes (sometimes)   | Normal printing |
| %0d    | Decimal | No                | Compact output  |
| %b     | Binary  | Yes (may pad)     | Bit display     |
| %0b    | Binary  | No                | Clean binary    |
| %h     | Hex     | Yes (may pad)     | Hex output      |
| %0h    | Hex     | No                | Compact hex     |


💡 **In practice:**  
Always use `%0d`, `%0b`, `%0h` when you want **clean, space-free output** — especially in logs or concatenated print lines.

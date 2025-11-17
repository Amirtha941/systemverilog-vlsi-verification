
### 1. What is a String in SystemVerilog?

-   A **string** is basically a collection (array) of characters.
    
-   In SystemVerilog, a string is treated as a **dynamic array of bytes**.
    
-   Each character in the string is stored as **8-bit ASCII value**.
    

Example:

`string s = "Hello";` 

Here:

-   `"Hello"` is stored as characters: H (72), e (101), l (108), l (108), o (111).
    

----------

### 2. Declaring Strings

You can declare in two ways:

`string s1;          // Empty string
string s2 = "Hi";   // Initialize with value` 

----------

### 3. String Operations

You can **join, compare, or manipulate** strings.

#### a) Concatenation

`string s1 = "Hello";
string s2 = " World";
string s3;

s3 = s1 + s2;  // "Hello World"` 

#### b) Comparison

`if ("abc" == "abc")  // true
  $display("Equal");

if ("abc" != "xyz")  // true
  $display("Not Equal");` 

#### c) Length

```
string s = "SystemVerilog";
$display("Length = %0d", s.len());  // 13
```


### 4. Indexing in Strings

Strings work like arrays (index starts at 0).

`string s = "Test";
$display("%s", s.getc(0)); // T
$display("%s", s.getc(3)); // t` 

----------

### 5. Empty / Null Strings

```
string s = "";
if (s.len() == 0)
  $display("Empty string");
```

### 🧠 SystemVerilog String Methods — Complete Reference (with Examples

|            Category            |            Method / Function            |                             Description                             |                 Example Code                | Output / Result |
|:------------------------------:|:---------------------------------------:|:-------------------------------------------------------------------:|:-------------------------------------------:|:---------------:|
| 🔹 Length & Access              | len()                                   | Returns number of characters in the string                          | string s="Hello"; $display("%0d", s.len()); | 5               |
|                                | getc(index)                             | Returns character at given index (0-based)                          | s="SV"; $display("%s", s.getc(0));          | S               |
|                                | putc(index, ch)                         | Replaces character at index with new one                            | s="hello"; s.putc(0,"H");                   | "Hello"         |
|                                | substr(start, end)                      | Returns substring from start→end (inclusive)                        | "SystemVerilog".substr(0,5)                 | "System"        |
| 🔹 Case Conversion              | toupper()                               | Converts to uppercase                                               | "sv".toupper()                              | "SV"            |
|                                | tolower()                               | Converts to lowercase                                               | "SV".tolower()                              | "sv"            |
| 🔹 Comparison                   | compare(s2)                             | Case-sensitive compare → returns 0 (equal), <0 (less), >0 (greater) | "abc".compare("abd")                        | -1              |
|                                | icompare(s2)                            | Case-insensitive compare                                            | "ABC".icompare("abc")                       | 0               |
| 🔹 Searching                    | find(substr)                            | Returns index of first occurrence (or -1 if not found)              | "SystemVerilog".find("Ver")                 | 6               |
|                                | rfind(substr)                           | Returns index of last occurrence                                    | "abcabc".rfind("a")                         | 3               |
| 🔹 Insertion & Deletion         | insert(index, str2)                     | Inserts str2 starting at index                                      | string s="abc"; s.insert(1,"ZZ");           | "aZZbc"         |
|                                | erase(index, num)                       | Deletes num characters from index                                   | s="abcdef"; s.erase(2,3);                   | "abf"           |
| 🔹 Conversion (String ↔ Number) | atoi()                                  | Converts string → int                                               | string s="123"; int n=s.atoi();             | n=123           |
|                                | atohex()                                | Converts hex string → int                                           | string s="1A"; int n=s.atohex();            | n=26            |
|                                | atoreal()                               | Converts string → real                                              | string s="3.14"; real r=s.atoreal();        | r=3.14          |
|                                | itoa(value)                             | Converts int → string                                               | string s; s.itoa(55);                       | "55"            |
|                                | hextoa(value)                           | Converts int → hex string                                           | string s; s.hextoa(255);                    | "ff"            |
|                                | bintoa(value)                           | Converts int → binary string                                        | string s; s.bintoa(5);                      | "101"           |
|                                | octtoa(value)                           | Converts int → octal string                                         | string s; s.octtoa(64);                     | "100"           |
| 🔹 Formatting & Copying         | putc()                                  | Replaces a character (already covered)                              | –                                           | –               |
|                                | get(i) (alias for getc)                 | Returns char at index                                               | s.get(2)                                    | same as .getc() |
|                                | copy(s2)                                | Copies contents of another string                                   | s1.copy("Hi");                              | "Hi"            |
| 🔹 Misc Utilities               | empty()                                 | Returns 1 if string is empty, else 0                                | string s=""; if(s.empty()) ...              | 1               |
|                                | trim() (not standard in all simulators) | Removes spaces (optional extension)                                 | "  hi  ".trim()                             | "hi"            |






### 📘 Example: String Operations in SystemVerilog

```
module string_demo;

  initial begin
    string s1, s2, s3;
    int num;
    
    // Initialization
    s1 = "Hello";
    s2 = " World";
    $display("s1 = %s", s1);
    $display("s2 = %s", s2);

    // Concatenation
    s3 = s1 + s2;
    $display("Concatenation: %s", s3);

    // Length
    $display("Length of s3 = %0d", s3.len());

    // Indexing
    $display("First character of s1 = %s", s1.getc(0));
    $display("Last character of s3 = %s", s3.getc(s3.len()-1));

    // Substring
    $display("Substring (0 to 4) of s3 = %s", s3.substr(0,4));

    // Upper / Lower
    $display("Uppercase: %s", s3.toupper());
    $display("Lowercase: %s", s3.tolower());

    // Replace character
    s3.putc(0,"h");
    $display("After putc(0,'h'): %s", s3);

    // Comparison
    if ("abc" == "abc")
      $display("Strings are equal");
    if ("abc".compare("xyz") != 0)
      $display("Strings are not equal");

    // atoi and itoa
    string num_str = "12345";
    num = num_str.atoi();
    $display("String to int (atoi): %0d", num);

    string new_str;
    new_str.itoa(6789);
    $display("Int to string (itoa): %s", new_str);
  end

endmodule
``` 

----------

### 🖥️ **Expected Output**

```
s1 = Hello  s2  = World
Concatenation: Hello World
Length of  s3  =  11 First character of  s1  = H
Last character of  s3  = d Substring  (0 to 4) of  s3  = Hello
Uppercase: HELLO WORLD
Lowercase: hello world
After putc(0,'h'): hello World
Strings are equal
Strings are not equal
String to int  (atoi): 12345 Int to string  (itoa): 6789
``` 

----------

👉 This program covers:

-   Declaration & initialization
    
-   Concatenation (`+`)
    
-   `.len()`, `.getc()`, `.substr()`
    
-   `.toupper()`, `.tolower()`, `.putc()`
    
-   Comparison (`==`, `.compare()`)
    
-   `.atoi()` and `.itoa()`

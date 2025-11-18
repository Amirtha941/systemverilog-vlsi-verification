
# ⚡ What are Packed and Unpacked Arrays?

SystemVerilog has **two** types of array dimensions:

|      Type      |             Meaning            |     Stored as     |       Behaves like      |
|:--------------:|:------------------------------:|:-----------------:|:-----------------------:|
| Packed array   | Placed inside the data-type    | Continuous bits   | Like a single vector    |
| Unpacked array | Placed after the variable name | Separate elements | Like a list of elements |

----------

# 🎯 RULE YOU MUST REMEMBER

## **PACKED = LEFT side of the variable**

(near the data type)

`bit [7:0] a;  // packed` 

## **UNPACKED = RIGHT side of the variable**

(near the variable name)

`bit a [7:0];  // unpacked` 

----------

# 🧠 Why two types?

Because:

### **Packed arrays = represent a single multi-bit word (hardware vector).**

These are synthesizable: buses, signals, registers, memories.

### **Unpacked arrays = represent multiple words (like memory).**

Used in TBs, memories, queues, FIFOs.

----------

# 🚀 1. PACKED ARRAYS (left side)

### ✔ A packed array is stored **as one contiguous vector**

Example:

`logic [7:0] byte_data;` 

This is **8 bits packed together**:

`bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0` 

### Packed arrays allow:

✔ slicing  
✔ bit-select `byte_data[3]`  
✔ part-select `byte_data[7:4]`

Packed arrays behave **exactly like a vector**.

----------

# 🚀 2. UNPACKED ARRAYS (right side)

### ✔ Unpacked arrays are **multiple separate elements**, each with the same type.

Example:

`logic data [0:7];   // 8 separate logic elements` 

Diagram:

```
data[0] → logic
data[1] → logic
...
data[7] → logic
``` 

Each element is its own object.

### Unpacked array uses:

✔ `foreach`  
✔ dynamic sizing  
✔ associative indexes  
✔ queues  
✔ memory-like behavior

----------

# 🔥 3. THE MOST CONFUSING EXAMPLE (very important)

Look at these two:

```
bit [7:0] a [3:0];   // packed + unpacked
bit a [3:0] [7:0];   // completely unpacked
``` 

Let’s break it.

----------

## Case 1: `bit [7:0] a [3:0];`

-   `[7:0]` = packed
    
-   `[3:0]` = unpacked
    

**Meaning:**

```
a[0] = 8-bit vector
a[1] = 8-bit vector
a[2] = 8-bit vector
a[3] = 8-bit vector
``` 

This is a **memory of 4 bytes**.

----------

## Case 2: `bit a [3:0] [7:0];`

Both dimensions are **unpacked**.

**Meaning:**

`a[x][y] = 1 bit` 

This is essentially:

-   4 rows
    
-   each row has 8 bits
    
-   but **not packed into a vector**
    

This is **NOT equivalent** to the first case.

## ⭐ Packed vs Unpacked Summary Table

|      Declaration     |                Meaning               |
|:--------------------:|:------------------------------------:|
| bit [7:0] data;      | 8-bit packed vector                  |
| bit data[7:0];       | 8 separate bits                      |
| bit [7:0] data[3:0]; | 4 bytes (memory)                     |
| bit data[3:0][7:0];  | 2D array of bits—not a packed vector |


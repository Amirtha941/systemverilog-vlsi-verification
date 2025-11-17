
## 1. Basic Data Types

### 2-State and 4-State Data Types

**2-State Types** (only 0 and 1 values):


```
bit         b;      // 2-state, single bit
bit [7:0]   byte_data;  // 2-state, 8-bit vector
int         i;      // 2-state, 32-bit signed integer
shortint    si;     // 2-state, 16-bit signed integer
longint     li;     // 2-state, 64-bit signed integer
byte        bt;     // 2-state, 8-bit signed integer
```
**4-State Types** (0, 1, X, Z values):


```
logic       l;      // 4-state, single bit
logic [7:0] bus;    // 4-state, 8-bit vector
reg         r;      // 4-state, single bit (legacy)
reg [15:0]  data;   // 4-state, 16-bit vector
integer     i;      // 4-state, 32-bit signed integer
time        t;      // 4-state, 64-bit unsigned
```
## 2. Integer Data Types


```
// Signed integers
byte        signed_byte = 8'shFF;     // -1
shortint    signed_short = 16'sh8000; // -32768
int         signed_int = -42;
longint     signed_long = 64'd1000;

// Unsigned integers
byte        unsigned_byte = 8'hFF;    // 255
bit [15:0]  unsigned_bit = 16'h1234;
logic [31:0] unsigned_logic = 32'hDEADBEEF;
```
## 3. Real and Shortreal

```
real        r1 = 3.14159;     // Double precision
shortreal   sr1 = 2.718;      // Single precision
```
## 4. String Type

```
string s1 = "Hello";
string s2 = "World";
string s3;

initial begin
    s3 = {s1, " ", s2};       // Concatenation: "Hello World"
    $display("Length: %0d", s3.len());  // Method call
    if (s3.substr(0,4) == "Hello") begin
        $display("Found Hello!");
    end
end
```
## 5. Enumerated Types

```
// Basic enum
typedef enum {RED, GREEN, BLUE} color_t;
color_t my_color = GREEN;

// Enum with specific values
typedef enum {IDLE=0, START=2, RUN=4, STOP=8} state_t;
state_t current_state = IDLE;

// Enum with base type
typedef enum bit [1:0] {READ=2'b01, WRITE=2'b10} cmd_t;
```
## 6. User-Defined Types


```
// Type definition
typedef bit [7:0] byte_t;
typedef logic [31:0] word_t;
typedef int fixed_array_t [0:15];

// Using typedefs
byte_t data_byte;
word_t memory_word;
fixed_array_t my_array;
```
## 7. Arrays

### Fixed-Size Arrays

```
// Packed arrays (contiguous memory)
bit [3:0] [7:0] packed_2d;    // 4 bytes packed together
logic [2:0] [1:0] [3:0] packed_3d; // 3x2x4 bits

// Unpacked arrays
int array1 [0:15];            // 16 integers
logic [7:0] memory [0:255];   // 256 bytes
```
### Dynamic Arrays


```
int dyn_arr[];                // Empty dynamic array

initial begin
    dyn_arr = new[10];        // Allocate 10 elements
    dyn_arr[0] = 100;
    dyn_arr = new[20](dyn_arr); // Resize to 20, copy old values
end
```
### Associative Arrays

```
// Integer index
int assoc_arr [int];
assoc_arr[100] = 42;
assoc_arr[200] = 84;

// String index
string phonebook [string];
phonebook["Alice"] = "123-4567";
phonebook["Bob"] = "987-6543";
```
### Queues


```
int q1[$];                    // Unbounded queue
int q2[$:15];                 // Bounded queue (max 16 elements)

initial begin
    q1.push_front(10);        // Insert at front
    q1.push_back(20);         // Insert at back
    value = q1.pop_front();   // Remove from front
    q1.insert(1, 15);         // Insert at index 1
end
```
## 8. Structures


```
// Basic struct
struct {
    bit [7:0] addr;
    bit [31:0] data;
    bit valid;
} packet_s;

// Typedef struct
typedef struct {
    bit [15:0] source;
    bit [15:0] destination;
    bit [31:0] payload;
    bit crc_error;
} ethernet_frame_t;

ethernet_frame_t frame;

// Packed struct (memory efficient)
typedef struct packed {
    bit [3:0] version;
    bit [3:0] ihl;
    bit [15:0] length;
} ip_header_t;
```
## 9. Unions


```
// Normal union
typedef union {
    int i;
    shortint s;
    byte b;
} data_union_t;

// Packed union
typedef union packed {
    bit [31:0] word;
    bit [7:0] bytes [4];
} word_union_t;
```
## 10. Type Casting


```
int i_val;
real r_val;
bit [15:0] bits;

initial begin
    // Static casting
    i_val = int'(r_val);          // Real to int
    bits = bit[15:0]'(i_val);     // Int to bit vector
    
    // Dynamic casting ($cast)
    byte small_val;
    int large_val = 300;
    if (!$cast(small_val, large_val)) begin
        $display("Cast failed - value too large");
    end
end
```
## 11. Constants and Parameters


```
parameter WIDTH = 32;
localparam DEPTH = 1024;

const int MAX_SIZE = 1000;
const string ERROR_MSG = "Fatal error";

// Typed parameters
parameter type data_t = logic [7:0];
```
## 12. Example: Complete Data Type Usage


```
module data_types_demo;
    // Basic types
    bit [7:0] data_byte;
    logic [31:0] address;
    
  // Enum
    typedef enum {READ, WRITE, IDLE} operation_t;
    operation_t current_op;
    
    // Struct
    typedef struct {
        bit [15:0] header;
        bit [7:0] payload [0:7];
        bit valid;
    } packet_t;
    
    packet_t rx_packet;
    
    // Dynamic array
    int scores[];
    
    initial begin
        // Initialize dynamic array
        scores = new[5];
        foreach(scores[i]) scores[i] = i * 10;
        
        // Use struct
        rx_packet.header = 16'h1234;
        rx_packet.valid = 1'b1;
        
        // Use enum
        current_op = WRITE;
        
        $display("Operation: %s", current_op.name());
    end
endmodule
```
## Key Points to Remember:

1.  **Use `logic` instead of `reg`** for modern SystemVerilog designs
    
2.  **2-state types** are more memory efficient but don't support X/Z
    
3.  **4-state types** are better for simulation and verification
    
4.  **Choose appropriate types** based on your needs (simulation vs synthesis)
    
5.  **Use strong typing** to catch errors early
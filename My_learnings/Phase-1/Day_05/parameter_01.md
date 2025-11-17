
## 1. Parameter

**`parameter`** is the most commonly used compile-time constant that can be **overridden** during instantiation or from higher-level modules.

### Characteristics:

-   Can be overridden
    
-   Public visibility within the module
    
-   Evaluated at compile time
    
-   Used for module configuration
    

```
module memory #(
    parameter WIDTH = 32,        // Default value
    parameter DEPTH = 1024,      // Default value
    parameter type data_t = logic [7:0]  // Type parameter
) (
    input logic clk,
    input logic [WIDTH-1:0] addr,
    output data_t data_out
);
    
    localparam ADDR_BITS = $clog2(DEPTH);
    // Module implementation...
endmodule

// Instantiation with parameter override
memory #(.WIDTH(16), .DEPTH(2048)) mem_inst (.*);
```
## 2. Localparam

**`localparam`** is a **local constant** that **cannot be overridden** from outside the module.

### Characteristics:

-   Cannot be overridden
    
-   Private to the module
    
-   Evaluated at compile time
    
-   Often derived from parameters
    

```
module calculator #(
    parameter DATA_WIDTH = 32
) (
    input logic [DATA_WIDTH-1:0] a, b,
    output logic [DATA_WIDTH-1:0] result
);
    
    // Localparam - cannot be overridden
    localparam MAX_VALUE = (1 << DATA_WIDTH) - 1;
    localparam SIGN_BIT = DATA_WIDTH - 1;
    
    // Derived from parameter
    localparam DOUBLE_WIDTH = 2 * DATA_WIDTH;
    
    logic [DOUBLE_WIDTH-1:0] temp_result;
    
    always_comb begin
        temp_result = a * b;
        result = temp_result[DATA_WIDTH-1:0];
    end
endmodule
```
## 3. Const Constants

**`const`** creates run-time constants that are **evaluated during simulation**.

### Characteristics:

-   Evaluated at runtime (not compile time)
    
-   Can be assigned in procedural code
    
-   True constants that cannot be modified after assignment
    

```
module const_example;
    // Const declarations (must specify type)
    const int MAX_ITERATIONS = 100;
    const string ERROR_MSG = "Simulation Error";
    const bit [7:0] START_BYTE = 8'hAA;
    
    // Const in classes
    class packet;
        const int PACKET_SIZE;
        const string PACKET_TYPE;
        
        function new();
            PACKET_SIZE = 64;    // Can assign in constructor
            PACKET_TYPE = "DATA";
        endfunction
    endclass
    
    initial begin
        // Const variables in procedural code
        const real PI = 3.14159;
        const int ARRAY_SIZE = 256;
        
        int data[ARRAY_SIZE];
        $display("PI = %f", PI);
    end
endmodule
```
## 4. `define Macro Constants

**`` `define``** creates global text macros that work across file boundaries.

### Characteristics:

-   Global scope (across files)
    
-   Text substitution (not typed)
    
-   No namespace protection
    
-   Preprocessor directive
    

```
// Global definitions (usually in package or header file)
`define DATA_WIDTH 32
`define MAX_DEPTH 1024
`define CLK_PERIOD 10

module macro_example;
    logic [`DATA_WIDTH-1:0] data_bus;
    
    initial begin
        #(`CLK_PERIOD) data_bus = `MAX_DEPTH;
    end
endmodule
```

| Feature    | parameter            | localparam         | const              | `define                   |
|------------|----------------------|--------------------|--------------------|---------------------------|
| Override   | Yes                  | No                 | No                 | No (but can be redefined) |
| Scope      | Module               | Module             | Declaration scope  | Global                    |
| Evaluation | Compile-time         | Compile-time       | Run-time           | Preprocessor              |
| Typing     | Strongly typed       | Strongly typed     | Strongly typed     | Text substitution         |
| Visibility | Public               | Private            | Local scope        | Global                    |
| Usage      | Module configuration | Internal constants | Run-time constants | Global definitions        |


## 5. Best Practices

### When to use each:

1.  **Use `parameter`** for module configuration that might need overriding
    
2.  **Use `localparam`** for internal constants derived from parameters
    
3.  **Use `const`** for run-time constants and in classes
    
4.  **Use `` `define``** for global constants that span multiple files
    

### Good Practice Example:

```
module good_design #(
    parameter DATA_WIDTH = 32,
    parameter FIFO_DEPTH = 16
) (
    input logic clk,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out
);
    
    // Localparam for derived values
    localparam ADDR_WIDTH = $clog2(FIFO_DEPTH);
    localparam FIFO_FULL = FIFO_DEPTH - 1;
    
    // Const for simulation constants
    const string MODULE_NAME = "FIFO";
    const int SIM_CYCLES = 10000;
    
    // Internal signals
    logic [ADDR_WIDTH-1:0] write_ptr, read_ptr;
    
    initial begin
        $display("%s: Data width = %0d", MODULE_NAME, DATA_WIDTH);
        $display("Address width = %0d", ADDR_WIDTH);
    end
    
    // Module implementation...
endmodule
```

## Key Takeaways:

-   **`parameter`** = Configurable constants (can be overridden)
    
-   **`localparam`** = Private module constants (cannot be overridden)
    
-   **`const`** = Run-time constants (evaluated during simulation)
    
-   **`` `define``** = Global text macros (use sparingly)
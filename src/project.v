module tt_um_SimpleCounter (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ena,
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    reg [7:0] value;
    wire [2:0] mode;

    assign mode = uio_in[2:0];

    always @(posedge clk) begin
        if (!rst_n) begin
            value <= 8'b00000001;
        end else begin
            case (mode)
                3'b000: value <= value + 8'b00000001;              // count up
                3'b001: value <= value - 8'b00000001;              // count down
                3'b010: value <= value << 1;                       // shift left
                3'b011: value <= value >> 1;                       // shift right
                3'b100: value <= {value[6:0], value[7]};           // rotate left
                3'b101: value <= {value[0], value[7:1]};           // rotate right
                3'b110: value <= ~(value + 8'b00000001);           // weird behavior
                3'b111: value <= value;                            // hold
                default: value <= value;
            endcase
        end
    end

    assign uo_out  = value;
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

endmodule

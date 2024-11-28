library verilog;
use verilog.vl_types.all;
entity controlgeneralversion3_4_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        p0              : in     vl_logic;
        p1              : in     vl_logic;
        p2              : in     vl_logic;
        p3              : in     vl_logic;
        reset           : in     vl_logic;
        vector_entrada  : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end controlgeneralversion3_4_vlg_sample_tst;

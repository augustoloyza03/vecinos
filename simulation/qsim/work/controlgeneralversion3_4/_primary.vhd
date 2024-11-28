library verilog;
use verilog.vl_types.all;
entity controlgeneralversion3_4 is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        vecino_arriba   : out    vl_logic_vector(3 downto 0);
        vecino_abajo    : out    vl_logic_vector(3 downto 0);
        vecino_der      : out    vl_logic_vector(3 downto 0);
        vecino_izq      : out    vl_logic_vector(3 downto 0);
        vector_entrada  : in     vl_logic_vector(3 downto 0);
        p0              : in     vl_logic;
        p1              : in     vl_logic;
        p2              : in     vl_logic;
        p3              : in     vl_logic
    );
end controlgeneralversion3_4;

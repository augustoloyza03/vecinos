library verilog;
use verilog.vl_types.all;
entity controlgeneralversion3_4_vlg_check_tst is
    port(
        vecino_abajo    : in     vl_logic_vector(3 downto 0);
        vecino_arriba   : in     vl_logic_vector(3 downto 0);
        vecino_der      : in     vl_logic_vector(3 downto 0);
        vecino_izq      : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end controlgeneralversion3_4_vlg_check_tst;

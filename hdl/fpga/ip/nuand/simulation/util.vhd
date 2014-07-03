library ieee ;
    use ieee.std_logic_1164.all ;

library std;
    use std.textio.all;


-- Utility package
package util is

    procedure nop( signal clock : in std_logic ; count : in natural ) ;

end package ;

package body util is

    procedure nop( signal clock : in std_logic ; count : in natural ) is
    begin
        for i in 1 to count loop
            wait until rising_edge( clock ) ;
        end loop ;
    end procedure ;

end package body ;

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all;
library std;
    use std.textio.all;


entity data_saver is
    generic(
        FILENAME : string := "file.dat";
        DATA_WIDTH : natural := 16
    );
    port(
        reset   : in std_logic;
        clock   : in std_logic;
        data    : std_logic_vector(DATA_WIDTH-1 downto 0);
        data_valid : std_logic
    );
end entity;


architecture arch of data_saver is
begin

    handler : process
        FILE fp : text;
        variable line_data : line;
    begin 
        --
        wait until falling_edge(reset);

            file_open(fp, FILENAME, WRITE_MODE);
            
            while (reset = '0') loop
                wait until rising_edge(data_valid);
                    write(line_data, data);
                    writeline(fp,line_data);
            end loop;
            file_close(fp);
    end process;
end architecture;


library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all;
library std;
    use std.textio.all;


entity signed_saver is
    generic(
        FILENAME : string := "file.dat";
        DATA_WIDTH : natural := 16
    );
    port(
        reset   : in std_logic;
        clock   : in std_logic;
        data    : signed(DATA_WIDTH-1 downto 0);
        data_valid : std_logic
    );
end entity;


architecture arch of signed_saver is
begin

    handler : process
        FILE fp : text;
        variable line_data : line;
    begin 
        --
        wait until falling_edge(reset);

            file_open(fp, FILENAME, WRITE_MODE);
            
            while (reset = '0') loop
                wait until rising_edge(clock);

                if data_valid = '1' then
                    write(line_data, (to_integer(data)));
                    writeline(fp,line_data);
                end if;
            end loop;
            file_close(fp);
    end process;
end architecture;
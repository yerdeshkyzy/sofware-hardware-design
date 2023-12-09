library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tb_dec is
end entity;

architecture tb_dec_arch of tb_dec is
	signal number :  std_logic_vector(3 downto 0);
	signal segments : std_logic_vector(6 downto 0);
	
begin
	dut: entity work.decoder port map (number => number, segments => segments);
	
	test: process
		constant period : time:= 64 ns;
		variable l_in : line;
		variable data_num: std_logic_vector(3 downto 0);
		variable data_seg: std_logic_vector(6 downto 0);
		file stim_in : text is in "C:\CSCI502\decoder\stim_in.txt";
	begin
		while not endfile(stim_in) loop
			readline(stim_in, l_in);
			read(l_in, data_num);
			read(l_in, data_seg);
		
			number <= data_num;
		
			wait for period;
		
			assert (segments = data_seg)
			report "failed for input number: " & std_logic'image(data_num(3))& std_logic'image(data_num(2))& std_logic'image(data_num(1))& std_logic'image(data_num(0)) severity error;
		
		end loop;
		wait;
	end process;
end architecture;
	

		
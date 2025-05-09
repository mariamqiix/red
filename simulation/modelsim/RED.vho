-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"

-- DATE "04/30/2025 10:34:18"

-- 
-- Device: Altera EP4CGX150DF31I7AD Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_NCEO~	=>  Location: PIN_AE7,	 I/O Standard: 2.5 V,	 Current Strength: 16mA
-- ~ALTERA_DATA0~	=>  Location: PIN_A3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_NCSO~	=>  Location: PIN_B4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_B3,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_NCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_NCSO~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	RED IS
    PORT (
	RED_INPUT : IN std_logic_vector(7 DOWNTO 0);
	RED_CLOCK : IN std_logic
	);
END RED;

-- Design Ports Information
-- RED_INPUT[0]	=>  Location: PIN_AF6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_INPUT[1]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_INPUT[2]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_INPUT[3]	=>  Location: PIN_AE23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_INPUT[4]	=>  Location: PIN_B21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_INPUT[5]	=>  Location: PIN_AA12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_INPUT[6]	=>  Location: PIN_Y25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_INPUT[7]	=>  Location: PIN_D22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RED_CLOCK	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF RED IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_RED_INPUT : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_RED_CLOCK : std_logic;
SIGNAL \RED_INPUT[0]~input_o\ : std_logic;
SIGNAL \RED_INPUT[1]~input_o\ : std_logic;
SIGNAL \RED_INPUT[2]~input_o\ : std_logic;
SIGNAL \RED_INPUT[3]~input_o\ : std_logic;
SIGNAL \RED_INPUT[4]~input_o\ : std_logic;
SIGNAL \RED_INPUT[5]~input_o\ : std_logic;
SIGNAL \RED_INPUT[6]~input_o\ : std_logic;
SIGNAL \RED_INPUT[7]~input_o\ : std_logic;
SIGNAL \RED_CLOCK~input_o\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_RED_INPUT <= RED_INPUT;
ww_RED_CLOCK <= RED_CLOCK;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOIBUF_X3_Y0_N15
\RED_INPUT[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(0),
	o => \RED_INPUT[0]~input_o\);

-- Location: IOIBUF_X19_Y91_N15
\RED_INPUT[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(1),
	o => \RED_INPUT[1]~input_o\);

-- Location: IOIBUF_X44_Y91_N8
\RED_INPUT[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(2),
	o => \RED_INPUT[2]~input_o\);

-- Location: IOIBUF_X113_Y0_N22
\RED_INPUT[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(3),
	o => \RED_INPUT[3]~input_o\);

-- Location: IOIBUF_X79_Y91_N8
\RED_INPUT[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(4),
	o => \RED_INPUT[4]~input_o\);

-- Location: IOIBUF_X34_Y0_N22
\RED_INPUT[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(5),
	o => \RED_INPUT[5]~input_o\);

-- Location: IOIBUF_X117_Y8_N8
\RED_INPUT[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(6),
	o => \RED_INPUT[6]~input_o\);

-- Location: IOIBUF_X95_Y91_N15
\RED_INPUT[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_INPUT(7),
	o => \RED_INPUT[7]~input_o\);

-- Location: IOIBUF_X50_Y91_N22
\RED_CLOCK~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RED_CLOCK,
	o => \RED_CLOCK~input_o\);
END structure;



:: Universidade Federal de Minas Gerais
:: Laboratório de Sistemas Digitais
:: Autor: Prof. Ricardo de Oliveira Duarte - DELT/EE/UFMG
:: Script TCL - versão 1.0
:: Objetivos:
:: (1) Analisar arquivos .vhd usando GHDL
:: (2) Simular arquivos .vhd usando GHDL
:: (3) Gerar arquivo .vcd com os resultados da simulação
:: (3) Visualizar arquivo .vcd com o GTKWAVE
:: Pré-requisitos:
:: (1) Plugin NppExec instalado
:: (2) Console do NppExec disponível
:: (3) Variável de ambiente Path editada e ativada, com os caminhos dos executáveis GHDL e GTKWAVE
:: Para executar esse script:
:: (1) Da janela Console digite no diretório onde se encontra o arquivo com extensão .do o comando "do script1.tcl"
::
:: Modifique a linha abaixo para o caminho do seu computador onde se encontra os seus arquivos fonte a serem compilados e simulados.
cd C:\Users\EMILIA\Downloads\UFMG\4 P\LAB SD\LSD02_codigos_exemplo
:: Modifique as linhas seguintes para incluir os arquivos .vhd que deseja analisar (compilar).
ghdl -a venda.vhd
ghdl -a testbench.vhd
:: Modifique a linha a seguir com o nome da entidade top level do arquivo testbench que você deseja simular.
ghdl -e testbench
:: Modifique a linha a seguir com o nome do arquivo testbench que você deseja simular e o nome do arquivo .vcd que deseja gerar.
ghdl -r vending_machine_TB --vcd=vending_machine_TB.vcd
:: Modifique a linha a seguir com o nome do arquivo .vcd que deseja visualizar com o GTKWAVE.
gtkwave -f ghdl -r vending_machine_TB --vcd=vending_machine_TB.vcd  --script=gtkwave_print.tcl
:Done

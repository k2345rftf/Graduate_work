clear all;
clc;
config;
try
    app = Controller_MainWindow();
catch e
    disp(e.message)
    disp(e.stack(1,:))
end

% plot the frequency response of a LTI system and the input, output signals after passing it


% --- Part a: the convolution function
%
% check out the file myconv.m

% --- end Part a ---


% the gloabl figure creator to handle the figure numbers
fig_creator = AutoNumberFigureCreator();


% --- Part b: create discrete signals ---
%
% x1, x2 are two discrete signals,
% x is the sum of them

Ns = -50:50;  % discrete signals have common sample times
x1 = sin(pi .* Ns / 4);
x2 = sin(pi .* Ns / 2);
x = x1 + x2;

% Since the signals share common properties
% I put them into arrays so can plot them in loop.
signals = [x1; x2; x];
titles  = ["$x_1[n] = sin( \pi n/4)$", ...
           "$x_2[n] = sin( \pi n/2)$", ...
           "$x[n]   = sin( \pi n/4) + sin( \pi n/2)$"];
ylabels = ["x_1[n]", "x_2[n]", "x[n]"];

for i = 1:size(signals, 1)  % size of the 1st dim. is the number of signals
    fig_creator.CreateFigure();
    stem(Ns, signals(i, :));

    tl = title(titles(i));
    tl.Interpreter = "latex";  % format with latex

    xlabel("n");
    ylabel(ylabels(i));
end

% --- end Part b ---


% --- Part c: convolution, the result of passing a LTI system ---
%
% h is the impulse response of the LTI system,
% x being the input signal and
% y being the output signal

% sin(pi * n / 3) / (pi * n) equals to sinc(n / 3) / 3
%
% NOTE: sym() is necessary to create a sinc function, but can convert it
%   back to double right after the creation to keep its type consistent
%   with all other signals.
h = double(sinc(sym(Ns ./ 3)) ./ 3);

[y, N, M] = myconv(x, -50, 50, h, -50, 50);
fig_creator.CreateFigure();
stem(N:M, y);
xlim([-50, 50]);
tl = title("$y[n] = x[n] * h[n]$");
tl.Interpreter = "latex";
xlabel("n");
ylabel("y[n]");

% --- end Part c ---


% --- part d: illustrate the frequency response of a LTI system ---
%
% transform the time domain impulse response h into frequency domain
% response H

% I observe these 200 sample frequencies
Fs = linspace(-pi, 0.99 * pi, 200);
H = zeros(length(Fs));

for w = 1:length(Fs)
    for n = 1:length(Ns)
        % NOTE: take care of conversion between index and true values
        H(w) = H(w) + ...
            h(n) * exp(-1i * Fs(w) * Ns(n));
    end
end

fig_creator.CreateFigure();
plot(f, abs(H));
xlim([-pi, pi]);
title("Frequency Response");
xlabel("\omega");
ylabel("|H(e^{j \omega})|")

% --- end Part d ---

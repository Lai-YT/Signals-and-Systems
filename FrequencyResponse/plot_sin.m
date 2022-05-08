Ns = -50:50;  % common sample time

x1 = sin(pi .* Ns / 4);
figure(1);
stem(Ns, x1);
tl = title('$ x_1[n] = sin( \pi n/4)$');
tl.Interpreter = 'latex';
xlabel('n');
ylabel('x_1[n]');

x2 = sin(pi .* Ns / 2);
figure(2);
stem(Ns, x2);
tl = title('$x_2[n] = sin( \pi n/2)$');
tl.Interpreter = 'latex';
xlabel('n');
ylabel('x_2[n]');

x = x1 + x2;
figure(3);
stem(Ns, x);
tl = title('$x[n] = sin( \pi n/4) + sin( \pi n/2)$');
tl.Interpreter = 'latex';
xlabel('n');
ylabel('x[n]');


% sin(pi * n / 3) / (pi * n) equals to sinc(n / 3) / 3
h = double(sinc(sym(Ns ./ 3)) ./ 3);
figure(4);
stem(Ns, h);
tl = title('$h[n] = \frac{1}{3} sinc(n/3)$');
tl.Interpreter = 'latex';
xlabel('n');
ylabel('h[n]');


[y, N, M] = myconv(x, -50, 50, h, -50, 50);
figure(5);
stem(N:M, y);
xlim([-50, 50]);
tl = title('$y[n] = x[n] * h[n]$');
tl.Interpreter = 'latex';
xlabel('n');
ylabel('y[n]');


Fs = linspace(-pi, 0.99*pi, 200);
H = zeros(length(Fs);

for idx_of_H = 1:length(Fs)
    for idx_of_h = 1:length(Ns)
        H(idx_of_H) = H(idx_of_H) + ...
            h(idx_of_h) * exp(-1i * Fs(idx_of_H) * Ns(idx_of_h));
    end
end

figure(6);
plot(f, abs(H));
xlim([-pi pi]);
title('Frequency Response');
xlabel('\omega');
ylabel('|H(e^{j\omega})|')

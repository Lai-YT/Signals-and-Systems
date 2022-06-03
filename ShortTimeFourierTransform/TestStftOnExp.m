% Performs mySTFT on a exponential function.

dt = 0.02;
df = 0.02;
t = -10:dt:10;
f = -1:df:20;
a = 0.2 * 6 + 2;
x = exp(1j * (0.06 * (a + 1) * t .^ 3 - 0.3 * (a + 2) * t .^ 2 + 1 * (a + 3) * t));
B = 1;
y = mySTFT(x, t, f, B, dt, df);
figure(2);
image(t, f, abs(y) / max(max(abs(y))) * 256);
colormap(gray(256));
colorbar;
set(gca, 'Ydir', 'normal');

% Performs mySTFT on a cosine function.

dt = 0.02;
df = 0.02;
a = 6 + 1;
t1 = 0:dt:10-dt;
t2 = 10:dt:20-dt;
t3 = 20:dt:30;
t = [t1, t2, t3];
f = -20:df:20;
x = [cos(2 * a * pi * t1), cos(2 * (a + 6) * pi * t2), cos(2 * (a + 3) * pi * t3)];
B = 1;
y = mySTFT(x, t, f, B, dt, df);
figure(2);
image(t, f, abs(y) / max(max(abs(y))) * 256);
colormap(gray(256));
colorbar;
set(gca, 'Ydir', 'normal');

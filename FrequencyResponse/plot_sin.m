% common sampling time
n = -50:50;

x1 = sin(pi .* n / 4);
figure(1);
stem(n, x1);
title('x_1[n] = sin(\pin/4)');
xlabel('n');
ylabel('x_1[n]');

x2 = sin(pi .* n / 2);
figure(2);
stem(n, x2);
title('x_2[n] = sin(\pin/2)');
xlabel('n');
ylabel('x_2[n]');

x3 = x1 + x2;
figure(3);
stem(n, x3);
title('x_3[n] = sin(\pin/4) + sin(\pin/2)');
xlabel('n');
ylabel('x_3[n]');

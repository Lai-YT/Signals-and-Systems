% test the myconv function with simple input signals

s1 = [1, 0, 1, 1];
N1 = 1;
M1 = 4;
figure(1);
stem(N1:M1, s1);
xlim([0, 10]);
ylim([0, 2]);

s2 = [1, 0, 1, 1];
N2 = 0;
M2 = 3;
figure(2);
stem(N2:M2, s2);
xlim([0, 10]);
ylim([0, 2]);

[s, N, M] = myconv(s1, N1, M1, s2, N2, M2);
figure(3);
stem(N:M, s);
xlim([0, 10]);
ylim([0, 2]);

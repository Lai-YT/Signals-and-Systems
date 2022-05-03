function [s, N, M] = ...
        myconv(s1, N1, M1, s2, N2, M2)
    % Performs convolution on s1 and s2.
    %
    % Arguments:
    %   s1, N1, M1:
    %       s1 is the 1st signal with its first value defined on time = N1,
    %       last value defined on M1. All values out of [N1, M1] are zero.
    %   s2, N2, M2:
    %       s2 is the 2nd signal with its first value defined on time = N2,
    %       last value defined on M2. All values out of [N2, M2] are zero.
    % Returns:
    %   s, N, M:
    %       s is the result signal with its first value defined on time = N,
    %       last value defined on M. All values out of [N, M] are zero.
    N = N1 + N2;
    M = M1 + M2;
    s = zeros(1, (M1+M2)-(N1+N2));
    for i = 1:M1-N1
        for j = 1:M2-N2
            s(i+j) = s1(i) .* s2(j);
        end
    end
end

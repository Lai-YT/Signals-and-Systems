% self-implemented convolution function

function [s, N, M] = myconv(s1, N1, M1, s2, N2, M2)
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

    % Non-zero bound and length of the result signal.
    N = N1 + N2;
    M = M1 + M2;
    s = zeros(1, M-N+1);

    % Step 1:
    %   Fix the 1st signal and flip the 2nd signal, since we're going to
    %   roll the 2nd signal.
    s2 = flip(s2);
    % Non-zero bound of the flipped signal.
    n = -M2;
    m = -N2;

    % Step 2:
    %   Roll the 2nd signal from the smallest possible non-zero point to
    %   the biggest. The result of each point is the total sum of the
    %   element-wise multiplication on the overlapped area, since the
    %   non-overlappings are all zeros.
    for i = N:M
        [a, b] = Overlap(n+i, m+i, N1, M1);  % must overlap when m > n and M1 > N1
        % The N, M values are about time but the index in MATLAB starts
        % from 1, so perform a conversion between them.
        % NOTE: look at the left parameter if you only care about how
        % convolution works in time.
        s(WithOffset(i, N)) = sum( ...
            s1(WithOffset(a, N1):WithOffset(b, N1)) .* s2(WithOffset(a, n+i):WithOffset(b, n+i)), ...
            "all" ...
        );
    end
end


function [a, b] = Overlap(N1, M1, N2, M2)
    % Returns the begin and end of the values that overlapped in 2 vectors
    % defined by [N1:M1] and [N2:M2].
    %
    % Example:
    %   [2, 4] = Overlap(1, 5, 2, 4)
    %
    % Arguments:
    %   N1, M1: Start and end value of the 1st vector.
    %   N2, M2: Start and end value of the 2nd vector.

    if M1 < N2 || M2 < N1
        % doesn't overlap
        a = NaN;
        b = NaN;
        return
    end

    a = max(N1, N2);
    b = min(M1, M2);
end


function i = WithOffset(t, offset)
    % Time t doesn't have to start from 1 but the index in MATLAB starts
    % from 1, so this function is to transform the time t into acceptable
    % index format.
    %
    % Example:
    %   Let there be a time series that start from 50, then
    %       1 = WithOffset(50, 50)
    %       5 = WithOffset(54, 50)
    %
    % Arguments:
    %   t: The time to transform.
    %   offset: The starting time of this time series, which return 1 if
    %           passed as t.
    i = t + (1 - offset);
end

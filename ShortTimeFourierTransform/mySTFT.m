% The sampled short-time Fourier transform.
% Divides a longer time signal into shorter segments of equal length and
% then computes the Fourier transform separately on each shorter segment.
% The input signal has to be sampled with respect to time and frequency.
function y = mySTFT(x, t, f, B, dt, df)
    Q = B / dt;  % half-size of the window

    % y-axis is the frequency, x-axis is the time;
    % the array is with dimension y * x
    y = zeros(length(f), length(t));

    for n = 1:length(t)
        for m = 1:length(f)
            % `p` covers the entire window, from (n - Q) to (n + Q).
            % When any of the two boundaries are reached, the window size
            % shrinks, half-size at most.
            for p = max(n - Q, 1):min(length(t), n + Q)
                y(m, n) = y(m, n) + ...
                    x(p) * exp(-1 * 1j * 2 * pi * t(p) * f(m)) * dt;
            end
        end
    end
end

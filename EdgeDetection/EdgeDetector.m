classdef EdgeDetector
    % Detects edges of the image on various directions.
    %
    % NOTE: Edges are grayscale image binarized with 0 and 1.

    properties (Constant)
        VER_KERNEL = [-1, 0, 1; -2, 0, 2; -1, 0, 1]  % emphasize vertical edges
        HOR_KERNEL = [-1, -2, -1; 0, 0, 0; 1, 2, 1]  % emphasize horizontal edges

        % The best fitting threshold varies with respect to images.
        THRESHOLD = 0.4
    end

    properties (SetAccess=private)
        image  % the image to perform detections on
    end

    properties (Access=private)
        pad_image  % padded so can apply convolution on the boundaries
    end

    methods
        function obj = EdgeDetector(image)
            % Constructor of the EdgeDetector.
            %
            % Arguments:
            %   image (uint8): The target to perform detections on.

            obj.image = image;

            % Since we're doing convolution with 3x3 kernels,
            % padding 0s enables us to go through the boundaries without
            % taking extra care.
            % Also the values are normalized for grayscale calculations.
            obj.pad_image = im2double(padarray(image, [1, 1], "both"));
        end

        function hor_edge = HorizontalEdge(obj)
            % Detects horizontal edges of the image.
            %
            % Returns:
            %   hor_edge (logical):
            %       The horizontal edges of image.
            %       Edges are white(1), others are black(0).
            
            % take magnitude since we only care about the difference
            % between both sides
            hor_edge = abs(obj.ConvolveWith(obj.HOR_KERNEL));
            hor_edge = obj.Binarize(hor_edge);
        end

        function ver_edge = VerticalEdge(obj)
            % Detects vertical edges of the image.
            %
            % Returns:
            %   ver_edge (logical):
            %       The vertical edges of image.
            %       Edges are white(1), others are black(0).

            ver_edge = abs(obj.ConvolveWith(obj.VER_KERNEL));
            ver_edge = obj.Binarize(ver_edge);
        end

        function edge = Edge(obj)
            % Detects all edges of the image.
            %
            % Returns:
            %   edge (logical):
            %       The edges of image.
            %       Edges are white(1), others are black(0).
    
            % Binarized images are logical, do "or" instead of "+".
            edge = obj.HorizontalEdge() | obj.VerticalEdge();
        end
    end

    methods (Access=private)        
        function con = ConvolveWith(obj, kernel)
            % Performs convolution of the image with kernel.
            %
            % Arguments:
            %   kernel: 3x3 matrix
            %
            % Returns:
            %   con (double):
            %       The values can be negative due to convolution,
            %       abs() if you care only the magnitude.

            [row, col] = size(obj.image);
            con = zeros([row, col]);
            % The (r, c) pair tracks the element which is currently
            % computing on.
            for r = 1:row
                for c = 1:col
                    con(r, c) = EdgeDetector.WeightedSum( ...
                        obj.pad_image(r:r+2, c:c+2), kernel);
                end
            end

        end

        function b = Binarize(obj, image)
            % Clamps the values above threshold to 1, below to 0.
            %
            % Arguments:
            %   image (double)
            %
            % Returns:
            %   b (logical)

            b = imbinarize(image, obj.THRESHOLD);
        end
    end

    methods (Static)
        function s = WeightedSum(a, b)
            % Returns the weighted sum of a and b.
            %
            % Arguments:
            %   a, b:
            %       The 2 operands should have the same size.
            %       No constraint on types.

            % total sum of element-wise multiplication
            s = sum(double(a) .* double(b), "all");
        end
    end
end

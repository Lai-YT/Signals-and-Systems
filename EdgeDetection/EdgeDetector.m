classdef EdgeDetector
    % Detects edges of the image on various directions.
    %
    % Note that edges are binarizes with 0 and 255 instead of 0 and 1.
    
    properties (Constant)
        VER_KERNEL = [-1, 0, 1; -2, 0, 2; -1, 0, 1]  % convolve to emphasize vertical edges                      
        HOR_KERNEL = [-1, -2, -1; 0, 0, 0; 1, 2, 1]  % convolve to emphasize horizontal edges
        
        % The best fitting threshold varies with respect to different images.
        THRESHOLD = 64
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
            % having to take extra care.
            obj.pad_image = padarray(image, [1, 1], "both");
        end
        
        function hor_edge = HorizontalEdge(obj)
            % Detects horizontal edges of the image.
            %
            % Returns:
            %   hor_edge (uint8):
            %       The horizontal edges of image.
            %       Edges are white(0), others are black(255).

            hor_edge = obj.ConvolveWith(obj.HOR_KERNEL);
            hor_edge = obj.Binarize(hor_edge);
        end
        
        function ver_edge = VerticalEdge(obj)
            % Detects vertical edges of the image.
            %
            % Returns:
            %   ver_edge (uint8):
            %       The vertical edges of image.
            %       Edges are white(0), others are black(255).

            ver_edge = obj.ConvolveWith(obj.VER_KERNEL);
            ver_edge = obj.Binarize(ver_edge);
        end
        
        function edge = Edge(obj)
            % Detects all edges of the image.
            %
            % Returns:
            %   edge (uint8):
            %       The edges of image.
            %       Edges are white(0), others are black(255).
            
            % MATLAB clamps the overflow value to MAX (255 for uint8).
            edge = obj.HorizontalEdge() + obj.VerticalEdge();
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
            %   con (uint8):
            %       The values are bound since they represent an image.
            
            [row, col] = size(obj.image);
            con = zeros([row, col]);
            % The [r, c] pair tracks the element which is currently
            % computing on.
            for r = 1:row
                for c = 1:col
                    con(r, c) = uint8( ...
                        EdgeDetector.WeightedSum(obj.pad_image(r:r+2, c:c+2), kernel));
                end
            end
            
        end
        
        function b = Binarize(obj, image)
            % Clamps the values above threshold to 255, below to 0.
            %
            % Arguments:
            %   image (uint8)
            %
            % Returns:
            %   b (uint8)
            
            b = imbinarize(double(image) ./ 255 , double(obj.THRESHOLD) ./ 255);
            b = b .* 255;
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

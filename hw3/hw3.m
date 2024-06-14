%% Problem 2
% load points
pts = load("data_f_LSLF.mat").pts;
x = pts(1,:);
y = pts(2,:);

% Visualize the data distribution
f = figure;
f.Position = [100 100 400 400];
scatter(x, y, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', [0.7,0.7,0.7])
xlabel("$x$", 'FontSize', 20, 'Interpreter', 'latex')
ylabel("$y$", 'FontSize', 20, 'Interpreter', 'latex')
hold on

% Calculate the covariance matrix of data
C = cov(x, y);

% Find eigenvectors and eigenvalues of the covariance matrix
[V, D] = eig(C);

% Draw eigenvectors
drawArrow = @(x,y) quiver(x(1), y(1), x(2)-x(1), y(2)-y(1), 0, 'Color', 'blue', 'LineWidth', 3);
drawArrow([mean(x), mean(x) + V(1,1)*sqrt(D(1,1))], [mean(y), mean(y) + V(2,1)*sqrt(D(1,1))]);
drawArrow([mean(x), mean(x) + V(1,2)*sqrt(D(2,2))], [mean(y), mean(y) + V(2,2)*sqrt(D(2,2))]);

% Find the optimal line ax+by  = d that fits the data in the total least squares sense.
% This requires finding the eigenvector corresponding to the smallest eigenvalue of C'*C.
[U, S, ~] = eig(C'*C);
[d,ind] = sort(diag(S));
S = S(ind,ind);
U = U(:,ind);
normal_vector_opt = U(:,1)'; % eigenvector corresponding to the smallest singular value
d_opt = normal_vector_opt(1)*mean(x) + normal_vector_opt(2)*mean(y);
x_range = linspace(min(x), max(x), 100);
f = @(x) (d_opt- normal_vector_opt(1)*x) / normal_vector_opt(2);
plot(x_range, f(x_range), 'Color', 'r', 'LineWidth', 1,'LineStyle','--')

% Setting aspect ratio of the plot to be equal
axis equal
























function model = leOptimise(model, display, iters)

% LEOPTIMISE Optimise an LE model.
% FORMAT
% DESC optimises a Laplacian eigenmaps model.
% ARG model : the model to be optimised.
% RETURN model : the optimised model.
%
% SEEALSO : leCreate, modelOptimise
%
% COPYRIGHT : Neil D. Lawrence, 2009

% MLTOOLS

[model.indices, D2] = findNeighbours(model.Y, model.k);
model.L = spalloc(model.N, model.N, model.N*model.k);
switch model.weightType
 case 'constant'
  model.kappa = repmat(1, model.N, model.k);
 case 'rbf'
  model.kappa = exp(-D2/(2*model.weightScale*model.weightScale));
 otherwise
  error('Unknown weight type in leOptimise');
end
model = spectralUpdateLaplacian(model);
model = spectralUpdateX(model);

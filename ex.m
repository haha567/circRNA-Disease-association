clear all; close all; clc;
addpath('../data');
addpath('../util');
load mnist_uint8;

train_x = double(reshape(train_x(1:10000,:)',28,28,10000))/255;
test_x = double(reshape(test_x',28,28,10000))/255;
train_y = double(train_y(1:10000,:)');
test_y = double(test_y');

%% ex1 
%will run 1 epoch in about 200 second and get around 11% error. 
%With 100 epochs you'll get around 1.2% error

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};

% ???cnn????cnnsetup????????????CNN??????
cnn = cnnsetup(cnn, train_x, train_y);

% ???
opts.alpha = 1;
% ??????batchsize?batch?????????batchsize??????????????
% ???????????????????????????
opts.batchsize = 50; 
% ????????????????????
% 1??? 11.41% error
% 5??? 4.2% error
% 10??? 2.73% error
opts.numepochs = 10;

% ??????????????????CNN??
cnn = cnntrain(cnn, train_x, train_y, opts);

% ???????????
[er, bad] = cnntest(cnn, test_x, test_y);

%plot mean squared error
plot(cnn.rL);
%show test error
disp([num2str(er*100) '% error']);
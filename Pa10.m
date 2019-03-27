clear;
clc;

Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7,200);
I = Is*(exp(1.2/.025*V)-1) + Gp*V - Ib*(exp(-1.2/0.025*(V+Vb))-1);
I2 = I;

for i=1:length(I)
    I2(i) = normrnd(I(i),abs(I(i))*.2);
end
figure(1)
plot(V,I)
hold on
plot(V,I2)

p3 = polyfit(V,I,4);
p4 = polyfit(V,I,8);
I3 = polyval(p3,V);
I4 = polyval(p4,V);

plot(V,I3)

plot(V,I4)


%practice curve fit as well as a 4 parameter fit
fo = fittype('A.*(exp(1.2*x/25e-3)-1)+B.*x-C*(exp(1.2*(-(x+D))/25e-3)-1)');
ff = fit(V',I',fo);
If = ff(V);


plot(V,If)


fa = fittype('A.*(exp(1.2*x/25e-3)-1)+0.1.*x-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ffa = fit(V',I',fa);
Ifa = ffa(V);
plot(V,Ifa)

fb = fittype('A.*(exp(1.2*x/25e-3)-1)+B.*x-C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ffb = fit(V',I',fb);
Ifb = ffb(V);
plot(V,Ifb)

inputs = V;
targets = I;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net);
Inn = outputs;
figure(2)
plot(V,Inn)
hold on
plot(V,I)












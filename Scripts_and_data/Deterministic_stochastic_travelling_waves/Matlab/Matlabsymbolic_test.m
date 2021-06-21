ccc
syms y(t) z(t)

eqns = [diff(y,t) == z, diff(z,t) == -y];
cond = [y(0) == 5, z(0)==1] ;
S = dsolve(eqns,cond);

ezplot(S.y,S.z)


%%
ccc
syms y(t) z(t)

[1,-1]*[y;z]
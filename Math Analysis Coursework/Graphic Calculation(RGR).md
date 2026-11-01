# Variant 1 :---------------------------------------------------







We have : x(t)=λ∫ab​K(t,s)x(s)ds+y(t), so  :   x(t)=λ∫0.31.2​t2s2x(s)ds+tsint​



and : -K(t,s) is the kernel  :  K(t,s)=t2s2

&#x20;     -y(t) is a known function : y(t)=sint/t

&#x20;     -a=0.3

&#x20;     -b=1.2

&#x20;     -n=9

&#x20;     -λ is a parameter   :  λ=0.6







###### ***Part 1. Investigate when the contraction mapping principle applies :*** 



&#x20;       (Ax)(t)=λ∫ab​K(t,s)x(s)ds+y(t), in the metric space : (C\[a,b],ρ)



&#x20;       where :  ρ(x,z)=a≤t≤bmax​∣x(t)−z(t)∣





&#x20;      For two functions x,z : ∣Ax(t)−Az(t)∣ ; equals :  |​λ∫ab​t2s2(x(s)−z(s))ds|,  using : ∣x(s)−z(s)∣≤ρ(x,z) ,  we obtain : ∣Ax−Az∣≤∣λ∣t2ρ(x,z)∫ab​s2ds



&#x20;      then ∫0.31.2​s2ds=31.23−0.33​



&#x20;      since : -1.23=1.728

&#x20;              -0.33=0.027

&#x20;              => ∫s2ds=31.701​=0.567



&#x20;      The maximum of t2 on \[0.3,1.2] is : 1.22=1.44 ==> :  θ=∣λ∣⋅1.44⋅0.567



&#x20;      For λ :  θ=0.6⋅1.44⋅0.567=0.489888



&#x20;      after that : θ≈0.4899<1, so the operator is a contraction





###### ***Part 2. Exact solution :*** 



&#x20;     let us assume that :  I=∫0.31.2​s2x(s)ds



&#x20;     then : x(t)=0.6t2I+sint/t

&#x20;

&#x20;     so : ∫s4ds=5s5 ; 1.25=2.48832, 0.35=0.00243



&#x20;          =∫s4ds=52.48589​=0.497178

&#x20;       

&#x20;          =0.6⋅0.497178=0.2983068



&#x20;          =∫ssinsds=−scoss+sins



&#x20;     evaluation at 1.2 :  −1.2cos1.2+sin1.2=0.497827



&#x20;     evaluation at 0.3 :  −0.3cos0.3+sin0.3=0.008919



&#x20;     the difference is :  0.488908



&#x20;         => I=0.2983068I+0.488908 ;  = I=0.488908​/0.7016932​=0.69673; => 0.6I=0.41804

​





the exact solution then :  x(t)=0.41804t2+sint/t







###### ***Part 3. Compute L :*** 





&#x20;        The first approximation is : x1​(t)=sint/t



&#x20;        The second approximation is : x2​(t)=0.6t2∫0.31.2​s2ssins/s.​ds+sint/t



&#x20;            but : ∫ssinsds=0.488908; and : x2​=0.293345t2+sint/t



&#x20;            then : ρ(x1​,x2​)=max0.293345t2



&#x20;     Maximum occurs at : t=1.2;  =>   ρ(x1​,x2​)=0.293345⋅1.44=0.4224



&#x20;    let us solve :  θL−1/1-θρ(x1​,x2​)<0.01 :



&#x20;           Using : θ=0.489888, 1−θ=0.510112



&#x20;           then we have :  0.8278θL−1<0.01; =>  θL−1<0.01208



&#x20;                  => L−1>ln0.01208/ln0.489888=6.27



&#x20;                  ==> L=8





###### ***Part 4. Coding program (Python) :***





&#x20;      import numpy as np



&#x20;        # Parameters

&#x20;            a = 0.3

&#x20;            b = 1.2

&#x20;            lam = 0.6

&#x20;            n = 9



&#x20;           N = 2 \* n

&#x20;           h = (b - a) / N



&#x20;           t = np.linspace(a, b, N + 1)



&#x20;       # Right-hand side

&#x20;           y = np.sin(t) / t



&#x20;       # Initial approximation

&#x20;           x = y.copy()



&#x20;      # Simpson weights

&#x20;          w = np.ones(N + 1)

&#x20;          w\[1:N:2] = 4

&#x20;          w\[2:N-1:2] = 2



&#x20;     # Number of iterations

&#x20;          L = 8



&#x20;     for k in range(L):

&#x20;        x\_new = np.zeros\_like(x)



&#x20;     for i in range(N + 1):

&#x20;       kernel = (t\[i] \*\* 2) \* (t \*\* 2)

&#x20;       integral = (h / 3.0) \* np.sum(w \* kernel \* x)

&#x20;       x\_new\[i] = lam \* integral + y\[i]



&#x20;       x = x\_new

&#x20;

&#x20;    # Exact solution

&#x20;        exact = 0.41804 \* t\*\*2 + np.sin(t)/t



&#x20;        R = np.max(np.abs(exact - x))



&#x20;        print("L =", L)

&#x20;        print("R =", R)





&#x20;           

​



&#x09;​



&#x09;​











&#x20;      

​


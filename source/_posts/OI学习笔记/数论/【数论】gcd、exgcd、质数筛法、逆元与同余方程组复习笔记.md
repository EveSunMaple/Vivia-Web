---
title: 【数论】gcd、exgcd、质数筛法、逆元与同余方程组复习
date: 2023-07-04
tags:
  - gcd
  - exgcd
  - 逆元
  - 同余方程组
  - 中国剩余定理
---
## 前言

这是我面对自己稀烂不堪的数论后奋笔疾书写出来的一篇复习笔记。算是对我前几个月学习**过**的初等数论的一次总结整理，一个下午的时间可能不够全面，往各位大佬海涵。

## 最大公约数

这里我们使用`欧几里得算法`（也称为辗转相除法）来计算最大公约数——简称“gcd”。因为是复习笔记，这里就不详细讲解原理了，记住公式即可。

算法流程： $gcd( m , n ) = gcd( n , m \% n)$

那么直到最后变成$gcd(m , 0)=m$,m最后的取值也就是m和n的最大公约数。

>用于计算gcd(m,n)的过程：
>1. 如果n=0，返回值m则作为结果。通过计算过程结束，否则进入第二步。
>2. 第二步：m除以n，将余数赋值给r；
>3. 第三步：将n的值赋给m，将r的值赋值给n。返回第一步

我们通过三元运算符`?:`很容易写出函数gcd：

```C++
int gcd(int m, int n)
{
	return n == 0 ? m : gcd(n, m % n);
	// 翻译如下
	// if(n == 0) return b;
	// return gcd(n, m % n);
}
```

### 例题P2441

非常水的一道绿题。

>题目链接：[P2441 角色属性树 - 洛谷](https://www.luogu.com.cn/problem/P2441)

```C++
#include <iostream>
#include <cstring>
#include <cstdio>
#include <cmath>
#define N 200005

using namespace std;

int fa[N]; // father
int val[N];
int n, k;

int gcd(int m, int n)
{
    return n == 0 ? m : gcd(n, m % n);
}

int dfs(int crd, int w)
{
    int d = -1;
    int v = fa[crd];
    if(!v) return -1;
    if(gcd(w, val[v]) > 1) d = v;
    else d = dfs(v, w);
    return d;
}

int main()
{
    scanf("%d%d", &n, &k);
    for(int i = 1; i <= n; i++) scanf("%d", &val[i]);
    for(int i = 1; i < n; i++)
    {
        int u, v;
        scanf("%d%d", &u, &v);
        fa[v] = u;
    }
    for(int i = 1; i <= k; i++)
    {
        int u, crd;
        scanf("%d%d", &u, &crd);
        if(u == 1) printf("%d\n", dfs(crd, val[crd]));
        else 
        {
            int a;
            scanf("%d", &a);
            val[crd] = a;
        }
    }
    return 0;
}
```

## 扩展欧几里得算法

假设我们现在有一个方程am + bn = gcd(m, n)，求a，b的解。

### 计算特解

扩展欧几里得算法可以解决这个问题——“简称exgcd”。我们在gcd函数中添加另外两个参数a和b，代表方程中的a和b。

>算法流程是这样的：
>1. 先按正常方法算出gcd(m, n)
>2. 回溯时遵从以下公式
>	从回溯时开始，初始化a = 1; b= 0;
>	1. a = b;
>	2. b = a - b * (m / n);
>3. 最后返回gcd(m, n)

因为我们计算时a与b相互引用，加上最后回溯时返回最大公约数，我们定义两个局部变量c与x当工具人协助我们完成算法。同时为了获取此方程的一个特解，我们把a与b引用(&)。

代码如下：

```C++
int exgcd(int m, int n, int& a, int& b) // 回溯时改变a与b的原值
{
	if(n == 0) { a = 1; b = 0; return m; } // n = 0计算结束，回溯开始
	int d = exgcd(n , m % n, a, b); // 工具人d存值
	int c = a; a = b; b = c - b * (m / n); // 工具人c
	return d;
}
```

### 计算通解

这时候我们得到的a和b只不过是一组特解，我们可以通过d写出通解：

$$ \left(a\:+\:\frac{b}{d}k,\:b\:+\:\frac{a}{d}k\right)\:k\epsilon\mathbb{Z} $$

### 扩展情况

假设要求方程am + bn = g，求a，b的解。

我们可以先按原来的方法，求出am + bn = gcd(m, n)的解。

然后把a，b，gcd(m, n)同时乘上g / gcd(m, n)就可以了。注意gcd(m, n) | g。

## 质数筛法

很蠢的埃式筛我们就不扯了，它浪费时间的地方就是重复筛——比如15被3和5筛了两次。

我们直接拿出欧拉筛，规定每个数字只被它最小的质因数筛去，复杂度降为$O(N)$。

直接上代码：

```C++
#define N 100005
bool not_prime[N];
int prime[N], tot;
for(int i = 2; i <= N; i++)
{
	if(!not_prime[i]) primt[++tot] = i;
	for(int j = 1; j <= n && i * prime[j] <= N; j++)
	{
		not_prime[i * prime[j]] = true;
		if(i % prime[j] == 0) break;
	}
}
```

### 逆元

逆元是一个很神奇的东西，你可以理解成广义上的倒数。

给你测试一下，ob自动部署
# This code demonstrates the vast increase in numbers of molecular formulas along integer nominal masses due to combinatorial explosion.

We use a ‘brute force’ method to create all possible combinations based on the elements (ranges) 
* __C__ (1-2500), 
* __H__ (0-12000), 
* __O__ (0-1364). 
 
C has a valence of 4, O of 2, and H of 1. We exclude formulas with odd valences, `O/C` ratios above 2, and a total mass above 30T Da. With these rules, the Double Bond Equivalent (DBE) cannot reach values below zero. The maximum `H/C` ratio is inherently limited by the valences and ranges between 4 (in the case of methane) and approaches 2 for high-molecular mass compounds. The nominal masses 12 and 14 (C, CH2) are not excluded but can be manually deleted on wish in the final list.

In between calculations create dataframes of molecular formulas with columns of the exact mass, the sum of valences, number of C, H and O atoms, the written formula as well as `O/C` and `H/C` ratios. These data frames could be manually saved and for example used as a masterlist for molecular formula attribution in mass spectrometry. Possible combinations between elements are created by the base R `expand.grid` function.

Further elements beyond C,H,O could easily be added manually into the code. For adding N e.g. write 

```
chemlist = expand.grid(C = 1:2500, H=0:12000, O=j:j, N=1:10)
```

but consider the combinatorial explosion. This code is mainly designed to run on a high performance cluster. We recommed to reduce maximum numbers of C and H compared to default when adding more elements.     

Due to the combinatorial explosion the generation of the final list is split into 15 subparts. Please ensure you have enough computational power!

Have fun creating molecular formulas and explore the combinatorial explosion.  

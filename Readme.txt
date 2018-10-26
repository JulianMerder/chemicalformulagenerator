
## This code demonstrates the vast increase in numbers of molecular formulas along integer nominal masses due to combinatorial explosion.
We use a brute force method to create all possible combinations based on the elements (ranges) C (1-2500), H (0-12000), and O (0-1364). We exclude formulas with odd valences, a Double Bond Equivalent below zero, O/C ratios above 2, H/C ratios above 8 and a total mass above 30T Da. In between calculations create dataframes of molecular formulas with columns of the exact mass, 
the sum of valences, number of C, H and O atoms, the written formula as well as O/C and H/C ratios. These data frames could be manually saved and for example used as a masterlist for molecular formula attribution in mass spectrometry. Possible combinations between elements are created by the base R expand.grid function. 
Further elements beyond C,H,O could easily be added manually into the code. For adding N e.g. write "chemlist = expand.grid(C = 1:2500, H=0:12000, O=j:j, N=1:10)" but consider the combinatorial explosion. This code is mainly designed to run on a high performance cluster. We recommed to reduce maximum numbers of C and H compared to default when adding more elements.     

Due to the combinatorial explosion the generation of the final list is split into 15 subparts. Please ensure you have enough computational power!
Have fun creating molecular formulas and explore the combinatorial explosion. 

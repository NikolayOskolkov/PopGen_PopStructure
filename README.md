![](images/logo.png)

# Population Genomics and Structure Analysis

## Instructor

- Dr. Nikolay Oskolkov, Group Leader (PI) at NIRI, Riga, Latvia

## Course overview
The study of genetic variation within and between populations using next-generation sequencing (NGS) data has become a cornerstone of modern population genomics, with wide-ranging applications in evolutionary biology, human genetics, conservation, and medical research. However, the analysis of low-coverage NGS data poses significant computational and statistical challenges, particularly when moving from raw sequencing reads to biologically meaningful inferences about population structure and demographic history. In this course, we will explore the key challenges and analytical methods in population genomics, focusing on a comprehensive understanding and practical implementation of the variant calling and population structure workflow spanning alignment, genotype likelihood-based inference with GATK and ANGSD, dimensionality reduction with PCA, tSNE and UMAP, admixture analysis, and population differentiation through Fst, F2, F3, and D-statistics of introgression.

## Target audience and assumed background
We assume some basic awareness of UNIX environment, as well as at least beginner level of R and / or Python programming.

## Learning outcomes
By completing this course, you will:

- Understand the fundamentals of next-generation sequencing data and genetic variation in natural populations
- Have an overview of bioinformatic tools and best practices for variant calling from low-coverage NGS data
- Be able to perform alignment, genotype likelihood estimation, and variant calling with GATK and ANGSD on your own samples
- Know the key challenges, approaches, and solutions in population structure and demographic inference
- Be able to carry out PCA, admixture analysis, and Fst, F2, F3, and D-statistic computations to answer your specific research question
- Be able to interpret population structure results and choose the right statistical framework for your study system 

---

# Schedule

## Before the course

| Time   | Activity                                                                                           |Link                                                                                                            |
|--------|----------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| ~ 1 h  | Recorded talk: AaRCademy workshop: aDNA data processing with Nikolay Oskolkov                      | [Video](https://www.youtube.com/watch?v=-nWoq6NTBd0&t=2121s)                                                                                           |
| ~ 2 h  | Pipeline for analysis of highly degraded DNA from low-covarege samples                             | [PDF](https://github.com/NikolayOskolkov/PopGen_PopStructure/blob/main/articles/2026.04.20.719564v2.full.pdf)                                                                                 |
| ~ 1 h  | Useful reading: how the curse of dimensionality complicates genomics analysis                      | [Blog](https://medium.com/data-science/genomics-new-clothes-6301ab9798a7?sk=db5db53c7f968add8a4b9a82579bf56d)                                                                          |
| ~ 1 h  | In case needed: Recap on basic Unix commands                                                       | [Lab](https://github.com/NikolayOskolkov/PopGen_PopStructure/blob/main/practicals/command-line-basics.md)                                                                                                    |


## Day 1: 3 pm - 9 pm Swedish time

| Time           | Activity                                                                                   |Link                                                                                                            |
|----------------|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| 15.00 - 15.30  | Course outline and practical information                                                   | [Slides](https://github.com/NikolayOskolkov/PopGen_PopStructure/blob/main/slides/Day1/course_outline.pdf)                                                                                           |
| 15.30 - 16.30  | Introduction to NGS analysis and GATK workflow                                             | [Slides](https://github.com/NikolayOskolkov/PopGen_PopStructure/blob/main/slides/Day1/NGS_workflow_GATK.pdf)                                                                         |
| 17.30 - 18.30  | Break                                                                                      |                                                                                                                |
| 18.30 - 19.00  | Introduction to NGS analysis and GATK workflow                                             | [Slides](https://github.com/NikolayOskolkov/Physalia_AncientMetagenomics_2025/raw/master/slides/Lecture_IntroAncientMetagenomics.pdf)                                                                         |
| 19.00 - 21.00  | Practical: quality control, adapter removal, alignment, variant calling                    | [Lab](exercises.md#getting-the-raw-data)                                                                                                         |


## Day 2: 3 pm - 9 pm Swedish time

| Time           | Activity                                                                                   | Link                                                                                                                                     |
|----------------|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| 14.00 - 15.00  | Authentication analysis: genomic hit confirmation and ancient status                       | [Slides](https://github.com/NikolayOskolkov/Physalia_AncientMetagenomics_2025/raw/master/slides/Lecture_Authentication.pdf)              |
| 15.00 - 15.15  | Break                                                                                      |                                                                                                                                          |
| 15.15 - 16.45  | Practical: genomic hit confirmation by evenness of coverage and damage pattern             | [Lab](exercises.md#genomic-hit-confirmation)                                                                                             |
| 16.45 - 17.00  | Break                                                                                      |                                                                                                                                          |
| 17.00 - 18.00  | Decontamination analysis of metegenomic data and eukaryotic reference genomes              | [Slides](https://github.com/NikolayOskolkov/Physalia_AncientMetagenomics_2025/raw/master/slides/Lecture_Decontamination.pdf)             |
| 18.00 - 18.15  | Break                                                                                      |                                                                                                                                          |
| 18.15 - 20.00  | Practical: microbial contamination correction and source tracking                          | [Lab](exercises.md#microbiome-contamination-correction)                                                                                  |


## Day 3: 3 pm - 9 pm Swedish time

| Time           | Activity                                                                                   | Link                                                                                                                                     |
|----------------|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| 14.00 - 14.15  | Bonus lecture: UMAP vs. PCA for population genomics and ancient metagenomics               | [Slides](https://github.com/NikolayOskolkov/Physalia_AncientMetagenomics_2025/raw/master/slides/UMAP_NBIS_AI_IO_2025_Oskolkov.pdf)       |
| 14.15 - 15.00  | aMeta: an accurate and memory-efficient ancient metagenomic profiling workflow             | [Slides](https://github.com/NikolayOskolkov/Physalia_AncientMetagenomics_2025/raw/master/slides/Lecture_aMeta.pdf)                       |
| 15.00 - 15.15  | Break                                                                                      |                                                                                                                                          |
| 15.15 - 16.45  | Practical: aMeta ancient metagenomic workflow                                              | [Lab](exercises.md#ameta-introduction-and-installation)                                                                                  |
| 16.45 - 17.00  | Break                                                                                      |                                                                                                                                          |
| 17.00 - 18.00  | Metagenome de-novo assembly, quality control, authentication of assembled contigs          | [Slides](https://github.com/NikolayOskolkov/Physalia_AncientMetagenomics_2025/raw/master/slides/Lecture_Assembly.pdf)                    |
| 18.00 - 18.15  | Break                                                                                      |                                                                                                                                          |
| 18.15 - 19.30  | Practical: de-novo assembly, quality control, authentication                               | [Lab](exercises.md#metagenome-assembly)                                                                                                  |
| 19.30 - 20.00  | Questions an discussion                                                                    |                                                                                                                                          |



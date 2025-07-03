#!/bin/bash

echo " Processing book.txt..."

# 1. Convert all text to lowercase
echo -e "\n All Text Lowercased:"
tr '[:upper:]' '[:lower:]' < book.txt > tmp_lower.txt
cat tmp_lower.txt

# 2. Remove punctuation
echo -e "\n Text Without Punctuation:"
tr -d '[:punct:]' < tmp_lower.txt > tmp_clean.txt
cat tmp_clean.txt

# 3. Count frequency of each unique word
echo -e "\n Word Frequencies:"
tr ' ' '\n' < tmp_clean.txt | sort | grep -v '^$' | uniq -c | sort -nr > tmp_freq.txt
cat tmp_freq.txt

# 4. Top 10 most frequently used words
echo -e "\n Top 10 Most Frequent Words:"
head -n 10 tmp_freq.txt

# 5. Count how many words are in each sentence
echo -e "\n Word Count Per Sentence:"
awk 'BEGIN{RS="\\."}{gsub(/\n/, " "); gsub(/[[:punct:]]/, "", $0); gsub(/[ ]+/, " "); print NF " words - " $0}' book.txt > tmp_sentences.txt
cat tmp_sentences.txt

# 6. Sentences with more than 10 words
echo -e "\n Sentences with More Than 10 Words:"
awk '{if ($1+0 > 10) print}' tmp_sentences.txt

# 7. Average number of words per sentence
echo -e "\n Average Words Per Sentence:"
awk '{ total += $1; count++ } END { if(count>0) print total/count " words per sentence" }' tmp_sentences.txt

# Cleanup temporary files
rm tmp_lower.txt tmp_clean.txt tmp_freq.txt tmp_sentences.txt

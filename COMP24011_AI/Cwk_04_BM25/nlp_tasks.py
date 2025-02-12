#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Sample code for Comp24011 BM25 lab solution

NB: The default code in non-functional; it simply avoids type errors
"""

__author__ = "s61110ab"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# we recommend you consider these Python modules while developing your code
import math
import re
import string
import sys

from nlp_tasks_base import NLPTasksBase

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class NLPTasks(NLPTasksBase):
    def __init__(self, *params):
        """Initialise instance by passing arguments to super class"""
        super().__init__(*params)

    def preprocess(self, texts):
        """Implements text preprocessing

        :param texts: text lines
        :type texts:  list

        :return: preprocessed lines
        :rtype:  list[str]
        """

        # for stemming, just call self.stemmer.stemWord(word) or
        # self.stemmer.stemWord([list])
 
        # 1. remove any trailing whitespace
        # 2. lowercase all letters
        # 3. remove punctuations
        strip_low_text = []
        regex_punc = f"[{re.escape(string.punctuation)}]"

        for text in texts :
            strip_low_text.append(re.sub(regex_punc, " ", text.strip().lower()))

        # 4. remove stop words
        # 5. stemming
        stop_ret_text = []
        for text in strip_low_text :
            temp_sentence = text.split()
            temp_text = [word for word in temp_sentence if word not in self.stopwords_list]

            if (self.stemmer != None) :
                temp_text = self.stemmer.stemWords(temp_text)
            
            temp_text = " ".join(temp_text)
            stop_ret_text.append(temp_text)

        return stop_ret_text

    def calc_IDF(self, term):
        """Calculates Inverse Document Frequency (IDF)
        of given term in preprocessed corpus

        :param term: given term
        :type term:  string

        :return: IDF
        :rtype:  float
        """
        # calculate df_value
        df_count = 0
        for docs in self.preprocessed_corpus :
            word_count = docs.split().count(term)
            if word_count > 0 :
                df_count += 1
        
        # calculate n value
        n_value = len(self.preprocessed_corpus)
        
        # calculate idf value
        idf_value = 0
        try :
            idf_value = math.log10((n_value - df_count + 0.5) / (df_count + 0.5))
        except ValueError as e:
            return e

        return idf_value

    def calc_BM25_score(self, index):
        """Calculates BM25 score
        for preprocessed question in preprocessed document

        :param index: index of document in preprocessed corpus
        :type index:  int

        :return: BM25
        :rtype:  float
        """
        # catch error for index larger than corpus
        if index >= len(self.preprocessed_corpus) :
            return IndexError
        
        # setup parameters
        document_check = self.preprocessed_corpus[index]
        dj = len(document_check.split())
        k = 2.0
        b = 0.75
        
        # count average document length
        total_length = 0
        for doc in self.preprocessed_corpus :
            total_length += len(doc.split())
        L_value = (total_length) / len(self.preprocessed_corpus)

        # calculate BM25 for each word in the question
        BM25_value = 0
        for word in self.preprocessed_question.split() :
            
            # calculate the IDF
            temp_idf = self.calc_IDF(word)

            # calculate the TF
            temp_tf = document_check.split().count(word)

            # calculate BM25 for a particular word
            top_val = temp_tf * (k + 1)
            bottom_val = temp_tf + (k * (1 - b + (b * (dj / L_value))))
            BM25_value += (temp_idf * (top_val / bottom_val))
            
        return BM25_value

    def find_top_matches(self, n):
        """Finds the top scoring documents
        for preprocessed question in corpus

        :param n: number of documents to find
        :type n:  int

        :return: top scoring original documents
        :rtype:  list[str]
        """
        corpus_value_match = {}

        for i in range(len(self.preprocessed_corpus)) :
            corpus_value_match[self.original_corpus[i]] = self.calc_BM25_score(i)

        # print(corpus_value_match)
        sorted_corpus = list(dict(sorted(corpus_value_match.items(), key = lambda item: item[1], reverse = True)).keys())

        if n > len(self.original_corpus) :
            return sorted_corpus

        return sorted_corpus[:n]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et sw=4 ts=4:

#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Python code for Comp24011 BM25 lab"""

__author__    = "mbaxjrb2, a21674fl"
__copyright__ = "Copyright 2023; please do not distribute!"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

import Stemmer
import sys

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class NLPTasksBase:
    def preprocess(self, texts):
        raise NotImplementedError

    def calc_IDF(self, term):
        raise NotImplementedError

    def calc_BM25_score(self, index):
        raise NotImplementedError

    def find_top_matches(self, n):
        raise NotImplementedError

    def __init__(self, corpus=None, stopwords=None, stemming=False):
        self.preprocessed_question = None
        self.preprocessed_corpus = None
        #
        self.original_corpus = []
        if corpus:
            self.original_corpus = corpus.readlines()
        #
        self.stopwords_list = []
        if stopwords:
            self.stopwords_list = [
                    line.strip()
                    for line in stopwords.readlines() ]
        #
        self.stemmer = None
        if stemming:
            self.stemmer = Stemmer.Stemmer('english')

    def get_preprocessed_question(self, question):
        lines = self.preprocess([question])
        self.preprocessed_question = lines[0]
        return self.preprocessed_question

    def get_preprocessed_corpus(self):
        self.preprocessed_corpus = self.preprocess(self.original_corpus)
        return self.preprocessed_corpus

    def get_IDF(self, term):
        if self.preprocessed_corpus is None:
            self.get_preprocessed_corpus()
        return self.calc_IDF(term)

    def get_BM25_score(self, question, index):
        if self.preprocessed_corpus is None:
            self.get_preprocessed_corpus()
        self.get_preprocessed_question(question)
        return self.calc_BM25_score(index)

    def get_top_matches(self, question, n):
        if self.preprocessed_corpus is None:
            self.get_preprocessed_corpus()
        self.get_preprocessed_question(question)
        return self.find_top_matches(n)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et sw=4 ts=4:

#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Python code for Comp24011 BM25 lab"""

__author__    = "mbaxjrb2, a21674fl"
__copyright__ = "Copyright 2023; please do not distribute!"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

import argparse
import io
import os.path
import sys

from nlp_tasks import NLPTasks

STOPWORDS_PATH = os.path.join(
        os.path.relpath(os.path.dirname(__file__)), 'stopwords_en.txt')

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class RunNLP:
    def __init__(self, corpus=None, stopwords=None, stemming=False):
        self.nlp = NLPTasks(corpus, stopwords, stemming)

    def preprocess_question(self, question):
        return self.nlp.get_preprocessed_question(question)

    def preprocess_corpus(self):
        return self.nlp.get_preprocessed_corpus()

    def IDF(self, term):
        return self.nlp.get_IDF(term.strip())

    def BM25_score(self, question, index):
        return self.nlp.get_BM25_score(question, index)

    def top_matches(self, question, n):
        return self.nlp.get_top_matches(question, n)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def main(*argv):
    p0 = argparse.ArgumentParser()
    p0.add_argument(
            '-c', '--corpus',
            type=argparse.FileType(), default=None,
            required=not 'preprocess_question' in sys.argv,
            help="path to corpus text file (option required " \
                    + "except for the preprocess_question command)")
    p0.add_argument(
            '-w', '--stopwords',
            type=argparse.FileType(), default=STOPWORDS_PATH,
            required=not os.path.exists(STOPWORDS_PATH),
            help='\n'.join([
                "path to stopwords text file",
                f"(option required unless stopwords are located at %(default)s)",
                f"the use of stopwords can be disabled with -w {os.devnull}",
                ]))
    p0.add_argument(
            '-s', '--stemming', action='store_true', default=False,
            help="enable stemming")
    sp = p0.add_subparsers(
            dest='command', required=True,
            description="select which NLP command to run")
    #
    p1 = sp.add_parser(
            'preprocess_question',
            help="get preprocessed question")
    p1.add_argument(
            'question', type=str,
            help="question string")
    #
    p2 = sp.add_parser(
            'preprocess_corpus',
            help="get preprocessed corpus")
    #
    p3 = sp.add_parser(
            'IDF',
            help="calculate IDF for term in corpus")
    p3.add_argument(
            'term', type=str,
            help="token word")
    #
    p4 = sp.add_parser(
            'BM25_score',
            help="calculate BM25 score for question in corpus document")
    p4.add_argument(
            'question', type=str,
            help="question string")
    p4.add_argument(
            'index', type=int,
            help="index of document in corpus")
    #
    p5 = sp.add_parser(
            'top_matches',
            help="find top scoring documents in corpus for question")
    p5.add_argument(
            'question', type=str,
            help="question string")
    p5.add_argument(
            'n', type=int,
            help="number of documents to find")
    #
    config = p0.parse_args(*argv)
    params = []
    for attr in "corpus stopwords stemming".split():
        params.append(getattr(config, attr, None))
    args = []
    for attr in "question term index n".split():
        if hasattr(config, attr):
            args.append(getattr(config, attr))
    print("nlp params: {}".format( tuple([
        p.name if isinstance(p, io.TextIOWrapper) else p
        for p in params ]) ))
    print("debug run: {}{}".format(config.command, (*args,)))
    run = RunNLP(*params)
    app = getattr(run, config.command)
    ret = app(*args)
    print("ret value:", ret)
    try:
      cnt = len(ret)
      print("ret count:", cnt)
    except TypeError:
      pass

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if __name__ == '__main__':
    main(sys.argv[1:])

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et sw=4 ts=4:

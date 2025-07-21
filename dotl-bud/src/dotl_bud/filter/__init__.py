import os
import importlib.resources as impresources


BAD_WORD_LIST = os.environ.get(
    "BAD_WORD_LIST", str(impresources.files(__name__) / "bad_word_list"))
BAD_WORD_REPLACE = os.environ.get(
    "BAD_WORD_REPLACE", str(impresources.files(__name__) / "bad_word_replace"))

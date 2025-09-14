import string
import random
import sys
import os


def generate_dictionary(dict, out_file, sorting=None):
    print(":: Generating dictionary")
    if os.path.exists(out_file):
        print(f" WARN: Overwriting existing '{out_file}'")
    
    if sorting == "sorted":
        print(" -> Sorting dictionary")
        with open(out_file, "w") as f:
            f.write("\n".join(sorted(dict)) + "\n")
        # dict.append(word)
    elif sorting == "reverse":
        print(" -> Reverse sorting dictionary")
        with open(out_file, "w") as f:
            f.write("\n".join(sorted(dict, reverse=True)) + "\n")
    else:
        print(" -> No sorting performed")
        with open(out_file, "w") as f:
            f.write("\n".join(dict) + "\n")
    print(f" -> Generated dictionary written to '{out_file}'")
    return dict


def random_word(length=40):
    return ''.join(random.choices(string.ascii_lowercase, k=length))


def generate_queries(dict_words, missing_words, hits, misses, out_file):
    print(f":: Generating {hits + misses} queries")
    if os.path.exists(out_file):
        print(f" WARN: Overwriting existing '{out_file}'")

    print(f" -> Computing {hits} query hits")
    choices = [*dict_words]
    random.shuffle(choices)
    with open(out_file, "w") as f:
        for i in range(hits):
            f.write(random.choice(choices) + "\n")

    print(f" -> Computing {misses} query misses")
    with open(out_file, "a") as f:
        for i in range(misses):
            f.write(missing_words[i] + "\n")

    print(f" -> Generated queries written to '{out_file}'")


def parse_dict(dict_in):
    print(":: Exploding dictionary")
    words = []
    with open(dict_in, "r") as d:
        for line in d:
            for i in filter(bool, line.split()):
                words.append(i)
    print(f" -> {len(words)} words in dictionary")
    return words


def print_usage():
    print(f"Usage: {sys.argv[0]} <dict_in> <dict_out> <query_out> <dict_len> <query_len> <dict_sorting> <query_hit_percent>")
    print("")
    print("  dict_in            Path to original file to generate dictionary from")
    print("  dict_out           Path to output dictionary (i.e. 'dict')")
    print("  query_out          Path to output query file (i.e. 'infile')")
    print("  dict_len           Number of items in dict_out. Use '-' for all items.")
    print("  query_len          Number of items in query_out")
    print("  dict_sorting       One of random, sorted, reverse, none")
    print("  query_hit_percent  Percentage of queries that should be hits")
    print("")
    print("WARNING: dict_out and query_out will both be overwritten if they exist!")


def parse_args():
    if len(sys.argv) != 8:
        print(len(sys.argv))
        print_usage()
        quit()

    dict_out, query_out, dict_len, query_len, dict_sorting, query_hit_percent = sys.argv[2:]
    if dict_len != "-" and not dict_len.isdigit():
        print("Invalid dict_len")
        quit()
    if not query_len.isdigit():
        print("Invalid query_len")
        quit()
    query_len = int(query_len)
    if not query_hit_percent.rstrip("%").isdigit():
        print("Invalid query_len")
        quit()
    query_hit_percent = int(query_hit_percent.rstrip("%"))
    if query_hit_percent < 0 or query_hit_percent > 100:
        print("query hit percent must be between 0 and 100")
        quit()

    return dict_out, query_out, dict_len, query_len, dict_sorting, query_hit_percent


def main():
    dict_out, query_out, dict_len, query_len, dict_sorting, query_hit_percent = parse_args()

    if dict_sorting not in ("sorted", "reverse", "random", "none"):
        print("WARN: Invalid dict_sorting. Defaulting to no sorting")

    dict_len = int(dict_len)
    
    query_hit = round(query_len * (query_hit_percent / 100))
    query_miss = query_len - query_hit
    
    # This is the total number of random words we need to generate
    word_len = dict_len + query_miss + 1
    all_words = []
    
    for i in range(0, word_len):
        all_words.append(random_word())
        
    dict_words = all_words[:dict_len]
    missing_words = all_words[dict_len:]

    dict = generate_dictionary(dict_words, dict_out, dict_sorting)

    generate_queries(dict_words, missing_words, query_hit, query_miss, query_out)

    print(":: All files generated!")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3

"""
this script extracts rego policies from ConstraintTemplates and writes them to .rego files
"""

import yaml
import os
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Extract rego policies from kubernetes manifests and write them to .rego files')
    parser.add_argument('manifests', metavar='manifest', type=str, nargs='+',
                        help='a kubernetes manifest')
    args = parser.parse_args()

    for manifest in args.manifests:
        i = 0

        docs = yaml.load_all(
            open(manifest), Loader=yaml.Loader
        )

        for doc in docs:
            if doc["kind"] == "ConstraintTemplate":
                targets = doc["spec"]["targets"]

                for target in targets:
                    rego = target["rego"]

                    with open(os.path.basename(manifest) + "." + str(i) + ".rego", mode='w') as f:
                        f.write(rego)

                    i += 1

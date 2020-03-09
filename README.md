# addonfactory_test_matrix_splunk
This repository is used to control the specific versions of Splunk Docker used in add-on test matrix

The format of this repository list a single conf file in the root 'splunk_matrix.conf' with a stanza in the pattern of MAJOR.MINOR and a attribute VERSION=semver 

```
[8.0]
VERSION=8.0.2
```
# Additional notes

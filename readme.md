\# A packer configuration to create a K3S agent on an ubuntu base. It reads the node key from the server at http://controlplane.bryan.dobc:8765

This requires access to the server on ports 8765 and 6443

To use this file, please set the environtment variables OWNER, AWS_ACCESS_KEY_ID, and AWS_SECRET_ACCESS_KEY

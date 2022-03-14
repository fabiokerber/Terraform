terraform {
    required_providers {
        random = {
            source = "hashicorp/random"
            version = "3.1.0"
        }
    }
}

resource "random_string" "random" {
    length = 8
}
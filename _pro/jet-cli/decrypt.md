---
title: jet decrypt
menus:
  pro/jet:
    title: jet decrypt
    weight: 4
categories:
  - CLI
tags:
  - jet
  - decrypt
  - cli
  - pro
---

## Description
Decrypt a file using an AES key

## Usage

```
jet decrypt /path/to/input_encrypted_file /path/to/output_file [flags]
```

## Flags
{% include jet_flag_table.html flags=site.data.jet.flags.decrypt %}

## Extended Description
The `jet decrypt` function will take any encrypted file as input, and output a decrypted file using the key found in your _Project Settings_.

If you encounter the error `No AES key provided`, and you have already downloaded the key, verify that the file is named `codeship.aes` and in the same directory where you are executing `jet decrypt`, or you are passing in the correct `key-path` value.

## Data Signing
As of `jet` version **2.6.0** all newly encrypted files are also signed with a checksum during encryption. This allows Codeship to verify that both the key used to decrypt the file is the same as was used to encrypt it, as well as that the encrypted data itself has not been tampered with. Signed encrypted files all contain the value `codeship:v2` at the head of the file.

During decryption, the checksum encoded in the file will be compared with a new checksum generated against the decoded data. In case of a checksum mismatch you will see the following error:

`checksum for decrypted data is invalid, corrupt AES key or data`

If you see this error this means that either the wrong key is being used to try and decrypt the data, or the encrypted data itself has been corrupted or tampered with.

This version of `jet decrypt` is backwards compatible with the previous version of encrypted file data so no action is required if you do not wish to take advantage of this new version of `jet encrypt`.

See the section on [encryption]({{ site.baseurl }}{% link _pro/jet-cli/encrypt.md %}) for more information.

## Examples

### Default Usage
```shell
$ jet decrypt env.encrypted env
```

This will create `env` from the `env.encrypted` file using the key in the `codeship.aes` file.

### decrypt with key-path

```shell
$ jet decrypt env.encrypted env --key-path PATH_TO_AES_KEY
```

This will create `env` from the `env.encrypted` file using the key located at `PATH_TO_AES_KEY`.

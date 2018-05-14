---
title: jet encrypt
menus:
  pro/jet:
    title: jet encrypt
    weight: 5
categories:
  - CLI
tags:
  - jet
  - encrypt
  - cli
  - pro
---

## Description
Encrypt a file using an AES Key.

## Usage

```
jet encrypt INPUT_PATH OUTPUT_PATH [flags]
```

## Flags
{% include jet_flag_table.html flags=site.data.jet.flags.encrypt %}

## Extended Description
The `jet encrypt` function will take any file as input, and output an encrypted file using the key found in your _Project Settings_.

If you encounter the error `No AES key provided`, and you have already downloaded the key, verify that the file is named `codeship.aes` and in the same directory where you are executing `jet encrypt`, or you are passing in the correct `key-path` value.

## Data Signing
As of `jet` version **2.6.0** all newly encrypted files are also signed with a checksum during encryption. This allows Codeship to verify that both the key used to decrypt the file is the same as was used to encrypt it, as well as that the encrypted data itself has not been tampered with. Signed encrypted files all contain the value `codeship:v2` at the head of the file.

See the section on [decryption]({{ site.baseurl }}{% link _pro/jet-cli/decrypt.md %}) for more information.

## Common Encrypted Files

 + [Environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %})
 + [Build arguments]({{ site.baseurl }}{% link _pro/builds-and-configuration/build-arguments.md %})
 + [Registry credentials]({{ site.baseurl }}{% link _pro/builds-and-configuration/image-registries.md %}).

## Examples

### Default Usage
```shell
$ jet encrypt env env.encrypted
```

This will create `env.encrypted` from the `env` file using the key in the `codeship.aes` file.

### encrypt with key-path

```shell
$ jet encrypt env env.encrypted --key-path PATH_TO_AES_KEY
```

This will create `env.encrypted` from the `env` file using the key located at `PATH_TO_AES_KEY`.

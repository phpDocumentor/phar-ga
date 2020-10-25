# Phar github action

This image can be used to create gpg signed phar. 

## Usage

The example below will build the phar. You might want to add extra steps 
to prepare the environment of your project before executing box.

```
on:
  release:
    types: [published]
name: Release workflow
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
    - name: build phar
      uses: docker://phpdoc/phar-ga:master
      with:
        args: box compile
```

### Sign a artifact

This image supports gpg signatures. The example below shows how to
use a passphase protected key. 

Please be aware you are publishing your
secret key on a public website. So we highly recommend you to create a sub key
and do never use your primary keys in a ci like environment. 

The image will automatically import the provided `SECRET_KEY`. The `--command-fd 0` flag will
fetch the `PASSPHRASE` STDIN, which will be provided by the image when needed. 

```
on:
  release:
    types: [published]
name: Release workflow
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
    - name: build phar
      uses: docker://phpdoc/phar-ga:latest
      with:
        args: box compile
    - name: sign phar
      uses: docker://phpdoc/phar-ga:latest
      env:
        PASSPHRASE: ${{ secrets.PASSPHRASE }}
        SECRET_KEY: ${{ secrets.SECRET_KEY }}
      with:
        args: gpg --command-fd 0 --pinentry-mode loopback -u info@phpdoc.org --batch
          --detach-sign --output build/phpDocumentor.phar.asc build/phpDocumentor.phar
```

# CI Image Organization

## Where Dockerfiles live

### CI images used in a single repository

Dockerfiles for images specific to CI takes for a given repository live in a `.ci-dockerfiles` directory in that repository. As an example, you can check out the [.ci-dockerfiles for the ponyc repo](https://github.com/ponylang/ponyc/tree/main/.ci-dockerfiles).

By living in the same repo where the generated images are used, we can version the changes to the Dockerfiles along with corresponding changes to CI configuration.

### CI images used around repositories

Dockerfiles that are shared across different repositories live in a repo called [shared-docker](https://github.com/ponylang/shared-docker).

## Image naming

Most CI images are named according to the following pattern

`ponylang/REPO-ci-INFORMATIONAL:YYYYMMDD`

for example, a ponyc x86-64-pc-windows-msvc-builder image created on July 2nd, 2020 would have the name:

- `ponylang/ponyc-ci-x86-64-pc-windows-msvc-builder:20200702`

and a shellcheck image that is shared across repos and was generated on January 1, 2018 would have the name:

- `ponylang/shared-docker-ci-shellcheck:20180101`

### Using the date as a tag

By using a date as a tag, we can avoid breakage when we do an update. The creation of a new image is divorced from the usage of that image to do testing.It's extra work when updating but removes the "spooky action at a distance" that we previously had.

Having the contents of a testing environment change out from under you without any indication that it has happened is the primary driver for our selecting a date based naming scheme.

### Image naming for dependent build Docker images

We have some docker images that we want to keep up to date with the latest comings and going of other packages. That is, we have images that we always want to be use most recent `ponyc` or the most recently released `ponyc`. The same applies to ponyup, corral, and other programs that might be included in the image.

Our nightly builders are an example of this, we want to use the most recent `ponyc` for latest and most recently released `ponyc`. For these, our tags are `latest` and `release`.

For example, the x86-64-unknown-linux-builder nightly builder with the latest and greatest of everything Pony is:

- `ponylang/shared-docker-ci-x86-64-unknown-linux-builder:latest`

And x86-64-unknown-linux-builder nightly builder that relies on released versions of the Pony tools is:

- `ponylang/shared-docker-ci-x86-64-unknown-linux-builder:release`

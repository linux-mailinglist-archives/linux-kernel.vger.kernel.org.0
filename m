Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C744EDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFURiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:38:51 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657D22083B;
        Fri, 21 Jun 2019 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138728;
        bh=NYHkmbDZTRaqqmxN2VJWnpSKDeGOUjyBNKoDYtvR/H4=;
        h=From:To:Cc:Subject:Date:From;
        b=rzwKNlIFe2K3J6yvQrtB3nxkTbnl/h504FhJRvgMKvzs6Ib6nq3ouGctYf2wFWRfY
         cq6YD//FTIe8WaWghuyQgctGtdN3I2sUUtUd0qX1t0K2k/YjeTTGgZtCvF1HsnZBZM
         U8eIWgMj0SCHM2I80wJlIqBWMogbWFR9rTUrrbY8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Laura Abbott <labbott@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Fri, 21 Jun 2019 14:38:06 -0300
Message-Id: <20190621173831.13780-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 3ce5aceb5dee298b082adfa2baa0df5a447c1b0b:

  Merge tag 'perf-core-for-mingo-5.3-20190611' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-06-17 20:48:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190621

for you to fetch changes up to 3469fa84c1631face938efc42b3f488a2c2504e0:

  tools build: Fix the zstd test in the test-all.c common case feature test (2019-06-18 18:44:24 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf trace:

  Arnaldo Carvalho de Melo:

  - Fix exclusion of not available syscall names from selector list.

  - Fixup pointer arithmetic when consuming augmented syscall args.

Intel PT:

  Adrian Hunter:

  - Add support for decoding PEBS via PT packets. See:

      https://software.intel.com/en-us/articles/intel-sdm
      May 2019 version: Vol. 3B 18.5.5.2 PEBS output to Intel® Processor Trace

  for more details about it.

ARM64:

  John Garry:

  - Fix uncore PMU alias list for ARM64

  Raphael Gault:

  - Compile tests unconditionally.

cs-etm:

  Mathieu Poirier:

  - Optimize option setup for CPU-wide sessions.

build:

  Florian Fainelli:

  - Don't hardcode host include path for libslang, fixing up building with it
    in cross build environments.

  Arnaldo Carvalho de Melo:

  - Check if gettid() is available before providing helper, fixing the build
    when using the latest glibc version, where a helper for gettid() is finally
    present.

  - Fix building with libslang in systems where it is located in slang/slang.h.

  - Fix fast path test for zstd library.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (11):
      perf intel-pt: Add new packets for PEBS via PT
      perf intel-pt: Add Intel PT packet decoder test
      perf intel-pt: Add decoder support for PEBS via PT
      perf intel-pt: Prepare to synthesize PEBS samples
      perf intel-pt: Factor out common sample preparation for re-use
      perf intel-pt: Synthesize PEBS sample basic information
      perf intel-pt: Add gp registers to synthesized PEBS sample
      perf intel-pt: Add XMM registers to synthesized PEBS sample
      perf intel-pt: Add LBR information to synthesized PEBS sample
      perf intel-pt: Add memory information to synthesized PEBS sample
      perf intel-pt: Add callchain to synthesized PEBS sample

Arnaldo Carvalho de Melo (10):
      tools build: Check if gettid() is available before providing helper
      perf trace: Fix exclusion of not available syscall names from selector list
      perf trace: Streamline validation of select syscall names list
      tools build feature tests: Add missing SPDX headers
      perf tests: Add missing SPDX headers
      perf trace: Fixup pointer arithmetic when consuming augmented syscall args
      perf evsel: Make perf_evsel__name() accept a NULL argument
      tools build: Add test to check if slang.h is in /usr/include/slang/
      perf build: Handle slang being in /usr/include and in /usr/include/slang/
      tools build: Fix the zstd test in the test-all.c common case feature test

Florian Fainelli (1):
      perf tools: Don't hardcode host include path for libslang

John Garry (1):
      perf pmu: Fix uncore PMU alias list for ARM64

Mathieu Poirier (1):
      perf: cs-etm: Optimize option setup for CPU-wide sessions

Raphael Gault (1):
      perf tests arm64: Compile tests unconditionally

 tools/build/Makefile.feature                       |   3 +-
 tools/build/feature/Makefile                       |  10 +-
 tools/build/feature/test-all.c                     |   7 +-
 tools/build/feature/test-fortify-source.c          |   1 +
 tools/build/feature/test-gettid.c                  |  11 +
 tools/build/feature/test-hello.c                   |   1 +
 tools/build/feature/test-libslang-include-subdir.c |   7 +
 tools/build/feature/test-setns.c                   |   1 +
 tools/perf/Makefile.config                         |  16 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  20 +-
 tools/perf/arch/arm64/Build                        |   2 +-
 tools/perf/arch/arm64/tests/Build                  |   2 +-
 tools/perf/arch/x86/include/arch-tests.h           |   1 +
 tools/perf/arch/x86/tests/Build                    |   2 +-
 tools/perf/arch/x86/tests/arch-tests.c             |   4 +
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     | 304 +++++++++++++++++++++
 tools/perf/builtin-trace.c                         |  20 +-
 tools/perf/jvmti/jvmti_agent.c                     |   2 +
 tools/perf/tests/Build                             |   2 +
 tools/perf/tests/bp_account.c                      |   1 +
 tools/perf/tests/bpf-script-example.c              |   1 +
 tools/perf/tests/bpf-script-test-kbuild.c          |   1 +
 tools/perf/tests/bpf-script-test-prologue.c        |   1 +
 tools/perf/tests/bpf-script-test-relocation.c      |   1 +
 tools/perf/tests/bpf.c                             |   1 +
 tools/perf/tests/map_groups.c                      |   1 +
 tools/perf/tests/mem.c                             |   1 +
 tools/perf/tests/mem2node.c                        |   1 +
 tools/perf/tests/shell/lib/probe.sh                |   1 +
 tools/perf/tests/shell/probe_vfs_getname.sh        |   3 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   1 +
 .../tests/shell/record+script_probe_vfs_getname.sh |   1 +
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |   2 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   1 +
 tools/perf/ui/libslang.h                           |   5 +
 tools/perf/util/evsel.c                            |   8 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 114 +++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  | 137 ++++++++++
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   | 140 +++++++++-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |  21 +-
 tools/perf/util/intel-pt.c                         | 296 +++++++++++++++++++-
 tools/perf/util/pmu.c                              |  28 +-
 42 files changed, 1115 insertions(+), 68 deletions(-)
 create mode 100644 tools/build/feature/test-gettid.c
 create mode 100644 tools/build/feature/test-libslang-include-subdir.c
 create mode 100644 tools/perf/arch/x86/tests/intel-pt-pkt-decoder-test.c

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.2.0-rc4.tar.xz
  $ dm
     1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
     2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
     3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
     4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
     5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
     6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     8 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 7.0.1 (tags/RELEASE_701/final) (based on LLVM 7.0.1)
     9 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
    10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
    11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
    14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
    15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
    16 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.1.1 20190611 gcc-9-branch@272162
    17 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
    18 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
    19 debian:experimental           : Ok   gcc (Debian 8.3.0-7) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
    20 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
    21 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
    22 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
    23 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
    24 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
    25 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
    26 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
    27 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
    28 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
    29 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
    30 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
    31 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
    32 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
    33 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    34 fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
    35 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
    36 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
    37 fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
    38 fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
    39 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
    40 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
    41 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
    42 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
    43 manjaro:latest                : Ok   gcc (GCC) 8.3.0, clang version 8.0.0 (tags/RELEASE_800/final)
    44 openmandriva:cooker           : Ok   gcc (GCC) 9.1.0 20190503 (OpenMandriva)
    45 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
    46 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
    47 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
    48 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190520 [gcc-9-branch revision 271396], clang version 7.0.1 (tags/RELEASE_701/final 349238)
    49 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
    50 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
    51 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
    52 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
    53 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    54 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    55 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    56 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    57 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    58 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    59 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    60 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    61 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
    62 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
    63 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    64 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    65 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    66 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    67 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    68 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    69 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    70 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    71 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
    72 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
    73 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
    74 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
    75 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  $

  # uname -a
  Linux quaco 5.2.0-rc4+ #1 SMP Tue Jun 11 11:21:27 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  3469fa84c163 tools build: Fix the zstd test in the test-all.c common case feature test
  # perf version --build-options
  perf version 5.2.rc4.gd1d5628fa057
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: time utils                                            : Ok
  60: map_groups__merge_in                                  : Ok
  61: x86 rdpmc                                             : Ok
  62: Convert perf time to TSC                              : Ok
  63: DWARF unwind                                          : Ok
  64: x86 instruction decoder - new instructions            : Ok
  65: Intel PT packet decoder                               : Ok
  66: x86 bp modify                                         : Ok
  67: probe libc's inet_pton & backtrace it with ping       : Ok
  68: Use vfs_getname probe to get syscall args filenames   : Ok
  69: Add vfs_getname probe to get syscall args filenames   : Ok
  70: Check open filename arg using perf trace + vfs_getname: Ok
  71: Zstd perf.data compression/decompression              : Ok
  #
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
         make_install_prefix_O: make install prefix=/tmp/krava
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
  - /home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC: make FEATURE_DUMP_COPY=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC  LDFLAGS='-static' feature-dump
                 make_static_O: make LDFLAGS=-static
         make_with_clangllvm_O: make LIBCLANGLLVM=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                   make_help_O: make help
           make_no_backtrace_O: make NO_BACKTRACE=1
            make_install_bin_O: make install-bin
           make_no_libpython_O: make NO_LIBPYTHON=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
              make_clean_all_O: make clean all
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
                  make_debug_O: make DEBUG=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_gtk2_O: make NO_GTK2=1
               make_no_slang_O: make NO_SLANG=1
              make_no_libbpf_O: make NO_LIBBPF=1
              make_no_libelf_O: make NO_LIBELF=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_util_map_o_O: make util/map.o
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                 make_cscope_O: make cscope
             make_no_libnuma_O: make NO_LIBNUMA=1
                 make_perf_o_O: make perf.o
                make_no_newt_O: make NO_NEWT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_install_O: make install
                   make_tags_O: make tags
                    make_doc_O: make doc
            make_no_demangle_O: make NO_DEMANGLE=1
                   make_pure_O: make
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $

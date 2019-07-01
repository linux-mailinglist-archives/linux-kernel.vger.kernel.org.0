Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE581256C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 02:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfECAZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 20:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfECAZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:25:46 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF64A2085A;
        Fri,  3 May 2019 00:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843144;
        bh=Y71OZiAjAepBEOHmMHXFHKqb/XFvIb6V0gbL7WaHLl4=;
        h=From:To:Cc:Subject:Date:From;
        b=GacWK3nKw12DrZUkbJ6ckBKB1KbGKLW/1H+80Ez6tsq/tmWMcKE89S9CQYDOaEnCo
         y8qy4Udgz5Jz4R909V/z3WMKlchAPCiwmxt2zH+9Y6Q4t76O/8f8x8v+lIZ26eK/iB
         0/5wwydW1Wtg4GAT43+mbKInKErJVxtupQuNP6z8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Bo YU <tsu.yubo@gmail.com>, Leo Yan <leo.yan@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Thomas Backlund <tmb@mageia.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [GIT PULL 00/11] perf/urgent fixes
Date:   Thu,  2 May 2019 20:25:22 -0400
Message-Id: <20190503002533.29359-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	This took a bit more time than I expected as I'm traveling,
LSF/MM + BPF, and also some of the fixes I worked on and off while on my
way here needed tweaks,

Thanks,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 1804569d87de903b4d746ba71512c3ed0a890d65:

  MAINTAINERS: Include vendor specific files under arch/*/events/* (2019-05-02 18:28:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190502

for you to fetch changes up to 7e221b811f1472d0c58c7d4e0fe84fcacd22580a:

  perf tools: Remove needless asm/unistd.h include fixing build in some places (2019-05-02 16:00:20 -0400)

----------------------------------------------------------------
perf/urgent fixes:

tools UAPI:

  Arnaldo Carvalho de Melo:

  - Sync x86's vmx.h with the kernel.

  - Copy missing unistd.h headers for arc, hexagon and riscv, fixing
    a reported build regression on the ARC 32-bit architecture.

perf bench numa:

  Arnaldo Carvalho de Melo:

  - Add define for RUSAGE_THREAD if not present, fixing the build on the
    ARC architecture when only zlib and libnuma are present.

perf BPF:

  Arnaldo Carvalho de Melo:

  - The disassembler-four-args feature test needs -ldl on distros such as
    Mageia 7.

  Bo YU:

  - Fix unlocking on success in perf_env__find_btf(), detected with
    the coverity tool.

libtraceevent:

  Leo Yan:

  - Change misleading hard coded 'trace-cmd' string in error messages.

ARM hardware tracing:

  Leo Yan:

  - Always allocate memory for cs_etm_queue::prev_packet, fixing a segfault
    when processing CoreSight perf data.

perf annotate:

  Thadeu Lima de Souza Cascardo:

  - Fix build on 32 bit for BPF.

perf report:

  Thomas Richter:

  - Report OOM in status line in the GTK UI.

core libs:

  - Remove needless asm/unistd.h that, used with sys/syscall.h ended
    up redefining the syscalls defines in environments such as the
    ARC arch when using uClibc.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (5):
      tools uapi x86: Sync vmx.h with the kernel
      perf bench numa: Add define for RUSAGE_THREAD if not present
      tools build: Add -ldl to the disassembler-four-args feature test
      tools arch uapi: Copy missing unistd.h headers for arc, hexagon and riscv
      perf tools: Remove needless asm/unistd.h include fixing build in some places

Bo YU (1):
      perf bpf: Return value with unlocking in perf_env__find_btf()

Leo Yan (3):
      tools lib traceevent: Change tag string for error
      perf cs-etm: Don't check cs_etm_queue::prev_packet validity
      perf cs-etm: Always allocate memory for cs_etm_queue::prev_packet

Thadeu Lima de Souza Cascardo (1):
      perf annotate: Fix build on 32 bit for BPF annotation

Thomas Richter (1):
      perf report: Report OOM in status line in the GTK UI

 tools/arch/arc/include/uapi/asm/unistd.h     | 51 ++++++++++++++++++++++++++++
 tools/arch/hexagon/include/uapi/asm/unistd.h | 40 ++++++++++++++++++++++
 tools/arch/riscv/include/uapi/asm/unistd.h   | 42 +++++++++++++++++++++++
 tools/arch/x86/include/uapi/asm/vmx.h        |  1 +
 tools/lib/traceevent/parse-utils.c           |  2 +-
 tools/perf/Makefile.config                   |  2 +-
 tools/perf/bench/numa.c                      |  4 +++
 tools/perf/util/annotate.c                   |  8 ++---
 tools/perf/util/cloexec.c                    |  1 -
 tools/perf/util/cs-etm.c                     | 14 +++-----
 tools/perf/util/env.c                        |  2 +-
 tools/perf/util/session.c                    |  8 +++--
 12 files changed, 154 insertions(+), 21 deletions(-)
 create mode 100644 tools/arch/arc/include/uapi/asm/unistd.h
 create mode 100644 tools/arch/hexagon/include/uapi/asm/unistd.h
 create mode 100644 tools/arch/riscv/include/uapi/asm/unistd.h

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

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.1.0-rc7.tar.xz
  $ dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0
   7 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0
   8 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
  10 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
  15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.0.1 20190501 (prerelease) gcc-8-branch@270761
  16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18 debian:experimental           : Ok   gcc (Debian 8.3.0-6) 8.3.0
  19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-4) 8.3.0
  20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-4) 8.3.0
  21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-2) 8.3.0
  22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-4) 8.3.0
  23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  26 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  27 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  28 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  29 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  30 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  31 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  32 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  33 fedora:30                     : Ok   gcc (GCC) 9.0.1 20190312 (Red Hat 9.0.1-0.10)
  34 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  35 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  36 fedora:rawhide                : Ok   gcc (GCC) 9.0.1 20190418 (Red Hat 9.0.1-0.14)
  37 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.2.0-r6 p1.7) 8.2.0
  38 mageia:5                      : Ok   gcc (GCC) 4.9.2
  39 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
  40 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.3.1 20180323 [gcc-7-branch revision 258812]
  41 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
  42 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  43 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.3.1 20190226 [gcc-8-branch revision 269204]
  44 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  45 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
  46 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  47 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  48 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
  49 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  50 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  51 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  56 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  57 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  58 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
  59 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  60 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  61 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  62 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  63 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  64 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  65 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0
  66 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  67 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  68 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  69 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  70 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  71 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  $ 

  # uname -a
  Linux quaco 5.1.0-rc7+ #1 SMP Thu May 2 09:47:59 EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  7e221b811f14 perf tools: Remove needless asm/unistd.h include fixing build in some places
  # perf version --build-options
  perf version 5.1.rc7.g7e221b8
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
  59: x86 rdpmc                                             : Ok
  60: Convert perf time to TSC                              : Ok
  61: DWARF unwind                                          : Ok
  62: x86 instruction decoder - new instructions            : Ok
  63: x86 bp modify                                         : Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_debug_O: make DEBUG=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_tags_O: make tags
           make_no_backtrace_O: make NO_BACKTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
              make_no_libbpf_O: make NO_LIBBPF=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                   make_pure_O: make
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                 make_perf_o_O: make perf.o
               make_no_slang_O: make NO_SLANG=1
             make_no_libperl_O: make NO_LIBPERL=1
                    make_doc_O: make doc
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_help_O: make help
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_clean_all_O: make clean all
         make_with_clangllvm_O: make LIBCLANGLLVM=1
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_install_O: make install
                make_no_gtk2_O: make NO_GTK2=1
             make_util_map_o_O: make util/map.o
                 make_static_O: make LDFLAGS=-static
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_install_bin_O: make install-bin
        make_with_babeltrace_O: make LIBBABELTRACE=1
                 make_cscope_O: make cscope
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 

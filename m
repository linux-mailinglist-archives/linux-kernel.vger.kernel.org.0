Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640BD10E62D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 07:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLBGv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 01:51:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:63064 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfLBGv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:51:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 22:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="212933732"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2019 22:51:28 -0800
Received: from [10.252.19.98] (abudanko-mobl.ccr.corp.intel.com [10.252.19.98])
        by linux.intel.com (Postfix) with ESMTP id CD658580127;
        Sun,  1 Dec 2019 22:51:25 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v4 0/3] perf record: adapt NUMA awareness to machines with
 #CPUs > 1K
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <f1e6e809-9e41-e410-57eb-1740512285a1@linux.intel.com>
Date:   Mon, 2 Dec 2019 09:51:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Current implementation of cpu_set_t type by glibc has internal cpu
mask size limitation of no more than 1024 CPUs. This limitation confines
NUMA awareness of Perf tool in record mode, thru --affinity option,
to the first 1024 CPUs on machines with larger amount of CPUs.

This patch set enables Perf tool to overcome 1024 CPUs limitation by
using a dedicated struct mmap_cpu_mask type and applying tool's bitmap
API operations to manipulate affinity masks of the tool's thread and
the mmaped data buffers.

tools bitmap API has been extended with bitmap_free() function and
bitmap_equal() operation whose implementation is derived from the
kernel one.

---
Changes in v4:
- renamed perf_mmap__print_cpu_mask() to mmap_cpu_mask__scnprintf()
- avoided checking mask bits for NULL prior calling bitmask_free()
- avoided thread affinity mask allocation for case of 
  rec->opts.affinity == PERF_AFFINITY_SYS
Changes in v3:
- implemented perf_mmap__print_cpu_mask() function
- use perf_mmap__print_cpu_mask() to log thread and mmap cpus masks
  when verbose level is equal to 2
Changes in v2:
- implemented bitmap_free() for symmetry with bitmap_alloc()
- capitalized MMAP_CPU_MASK_BYTES() macro
- returned -1 from perf_mmap__setup_affinity_mask()
- implemented releasing of masks using bitmap_free()
- moved debug printing under -vv option

---
Alexey Budankov (3):
  tools bitmap: implement bitmap_equal() operation at bitmap API
  perf mmap: declare type for cpu mask of arbitrary length
  perf record: adapt affinity to machines with #CPUs > 1K

 tools/include/linux/bitmap.h | 30 +++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 15 ++++++++++++++
 tools/perf/builtin-record.c  | 28 ++++++++++++++++++++------
 tools/perf/util/mmap.c       | 39 ++++++++++++++++++++++++++++++------
 tools/perf/util/mmap.h       | 13 +++++++++++-
 5 files changed, 112 insertions(+), 13 deletions(-)

---
Validation:

# tools/perf/perf record -vv -- ls
Using CPUID GenuineIntel-6-5E-3
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
------------------------------------------------------------
perf_event_attr:
  size                             120
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 23718  cpu 0  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid 23718  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 23718  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 23718  cpu 3  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 23718  cpu 4  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 23718  cpu 5  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 23718  cpu 6  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 23718  cpu 7  group_fd -1  flags 0x8 = 13
mmap size 528384B
0x7f3e06e060b8: mmap mask[8]: 
0x7f3e06e16180: mmap mask[8]: 
0x7f3e06e26248: mmap mask[8]: 
0x7f3e06e36310: mmap mask[8]: 
0x7f3e06e463d8: mmap mask[8]: 
0x7f3e06e564a0: mmap mask[8]: 
0x7f3e06e66568: mmap mask[8]: 
0x7f3e06e76630: mmap mask[8]: 
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  config                           0x9
  watermark                        1
  sample_id_all                    1
  bpf_event                        1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 21
mmap size 528384B
0x7f3e0697d0b8: mmap mask[8]: 
0x7f3e0698d180: mmap mask[8]: 
0x7f3e0699d248: mmap mask[8]: 
0x7f3e069ad310: mmap mask[8]: 
0x7f3e069bd3d8: mmap mask[8]: 
0x7f3e069cd4a0: mmap mask[8]: 
0x7f3e069dd568: mmap mask[8]: 
0x7f3e069ed630: mmap mask[8]: 
Synthesizing TSC conversion information
arch			      copy     Documentation  init     kernel	 MAINTAINERS	  modules.builtin.modinfo  perf.data	  scripts   System.map	vmlinux
block			      COPYING  drivers	      ipc      lbuild	 Makefile	  modules.order		   perf.data.old  security  tools	vmlinux.o
certs			      CREDITS  fs	      Kbuild   lib	 mm		  Module.symvers	   README	  sound     usr
config-5.2.7-100.fc29.x86_64  crypto   include	      Kconfig  LICENSES  modules.builtin  net			   samples	  stdio     virt
[ perf record: Woken up 1 times to write data ]
Looking at the vmlinux_path (8 entries long)
Using vmlinux for symbols
[ perf record: Captured and wrote 0.013 MB perf.data (8 samples) ]

tools/perf/perf record -vv --affinity=cpu -- ls
thread mask[8]: empty
Using CPUID GenuineIntel-6-5E-3
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
nr_cblocks: 0
affinity: CPU
mmap flush: 1
comp level: 0
------------------------------------------------------------
perf_event_attr:
  size                             120
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  enable_on_exec                   1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 23713  cpu 0  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid 23713  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 23713  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 23713  cpu 3  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 23713  cpu 4  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 23713  cpu 5  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 23713  cpu 6  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 23713  cpu 7  group_fd -1  flags 0x8 = 13
mmap size 528384B
0x7f3e005bc0b8: mmap mask[8]: 0
0x7f3e005cc180: mmap mask[8]: 1
0x7f3e005dc248: mmap mask[8]: 2
0x7f3e005ec310: mmap mask[8]: 3
0x7f3e005fc3d8: mmap mask[8]: 4
0x7f3e0060c4a0: mmap mask[8]: 5
0x7f3e0061c568: mmap mask[8]: 6
0x7f3e0062c630: mmap mask[8]: 7
------------------------------------------------------------
perf_event_attr:
  type                             1
  size                             120
  config                           0x9
  watermark                        1
  sample_id_all                    1
  bpf_event                        1
  { wakeup_events, wakeup_watermark } 1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 21
mmap size 528384B
0x7f3e001330b8: mmap mask[8]: 
0x7f3e00143180: mmap mask[8]: 
0x7f3e00153248: mmap mask[8]: 
0x7f3e00163310: mmap mask[8]: 
0x7f3e001733d8: mmap mask[8]: 
0x7f3e001834a0: mmap mask[8]: 
0x7f3e00193568: mmap mask[8]: 
0x7f3e001a3630: mmap mask[8]: 
Synthesizing TSC conversion information
0x9c9ff0: thread mask[8]: 0
0x9c9ff0: thread mask[8]: 1
0x9c9ff0: thread mask[8]: 2
0x9c9ff0: thread mask[8]: 3
0x9c9ff0: thread mask[8]: 4
arch			      copy     Documentation  init     kernel	 MAINTAINERS	  modules.builtin.modinfo  perf.data	  scripts   System.map	vmlinux
block			      COPYING  drivers	      ipc      lbuild	 Makefile	  modules.order		   perf.data.old  security  tools	vmlinux.o
certs			      CREDITS  fs	      Kbuild   lib	 mm		  Module.symvers	   README	  sound     usr
config-5.2.7-100.fc29.x86_64  crypto   include	      Kconfig  LICENSES  modules.builtin  net			   samples	  stdio     virt
0x9c9ff0: thread mask[8]: 5
0x9c9ff0: thread mask[8]: 6
0x9c9ff0: thread mask[8]: 7
0x9c9ff0: thread mask[8]: 0
0x9c9ff0: thread mask[8]: 1
0x9c9ff0: thread mask[8]: 2
0x9c9ff0: thread mask[8]: 3
0x9c9ff0: thread mask[8]: 4
0x9c9ff0: thread mask[8]: 5
0x9c9ff0: thread mask[8]: 6
0x9c9ff0: thread mask[8]: 7
[ perf record: Woken up 0 times to write data ]
0x9c9ff0: thread mask[8]: 0
0x9c9ff0: thread mask[8]: 1
0x9c9ff0: thread mask[8]: 2
0x9c9ff0: thread mask[8]: 3
0x9c9ff0: thread mask[8]: 4
0x9c9ff0: thread mask[8]: 5
0x9c9ff0: thread mask[8]: 6
0x9c9ff0: thread mask[8]: 7
Looking at the vmlinux_path (8 entries long)
Using vmlinux for symbols
...
[ perf record: Captured and wrote 0.013 MB perf.data (10 samples) ]

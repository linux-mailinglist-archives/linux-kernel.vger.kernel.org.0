Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9344A18C158
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 21:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgCSU2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 16:28:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:60493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSU2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:47 -0400
IronPort-SDR: PloJ7W8rPQ0a/AHyrnEfs/Iw5uLHprWL2TlZOcBSOUj6+cSpiijkjM/oALFUg8R/mrOtqbZgEY
 z65vjLsEKVOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:45 -0700
IronPort-SDR: 3HNCz5QuYma+ZrtborNdeH8jbCPkvlqWWohmrREsN6Y/7ftpxM2MCDXOssAp1IVs0fPlzzThTG
 BuWPmFRO9qDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031195"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:45 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 00/17] Stitch LBR call stack (Perf Tools)
Date:   Thu, 19 Mar 2020 13:25:00 -0700
Message-Id: <20200319202517.23423-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- There is no dependency among the 'capabilities'. If perf fails to read
  one, it should not impact others. Continue to parse the rest of caps.
  (Patch 1)
- Use list_for_each_entry() to replace perf_pmu__scan_caps() (Patch 1 &
  2)
- Combine the declaration plus assignment when possible (Patch 1 & 2)
- Add check for script/report/c2c.. (Patch 13, 14 & 16)

Changes since V2:
- Check strdup() in Patch 1
- Split several patches into smaller patches

Changes since V1:
- Rebase on top of commit 5100c2b77049 ("perf header: Add check for
  unexpected use of reserved membrs in event attr")
- Fix compling error with GCC9 in patch 1.


The kernel patches have been merged into linux-next.
  commit bbfd5e4fab63 ("perf/core: Add new branch sample type for HW
index of raw branch records")
  commit db278b90c326 ("perf/x86/intel: Output LBR TOS information
correctly")

Start from Haswell, Linux perf can utilize the existing Last Branch
Record (LBR) facility to record call stack. However, the depth of the
reconstructed LBR call stack limits to the number of LBR registers.
E.g. on skylake, the depth of reconstructed LBR call stack is <= 32
That's because HW will overwrite the oldest LBR registers when it's
full.

However, the overwritten LBRs may still be retrieved from previous
sample. At that moment, HW hasn't overwritten the LBR registers yet.
Perf tools can stitch those overwritten LBRs on current call stacks to
get a more complete call stack.

To determine if LBRs can be stitched, the maximum number of LBRs is
required. Patch 1 - 4 retrieve the capabilities information from sysfs
and save them in perf header.

Patch 5 - 12 implements the LBR stitching approach.

Users can use the options introduced in patch 13-16 to enable the LBR
stitching approach for perf report, script, top and c2c.

Patch 17 adds a fast path for duplicate entries check. It benefits all
call stack parsing, not just for stitch LBR call stack. It can be
merged independently.

The stitching approach base on LBR call stack technology. The known
limitations of LBR call stack technology still apply to the approach,
e.g. Exception handing such as setjmp/longjmp will have calls/returns
not match.
This approach is not full proof. There can be cases where it creates
incorrect call stacks from incorrect matches. There is no attempt
to validate any matches in another way. So it is not enabled by default.
However in many common cases with call stack overflows it can recreate
better call stacks than the default lbr call stack output. So if there
are problems with LBR overflows this is a possible workaround.

Regression:
Users may collect LBR call stack on a machine with new perf tool and
new kernel (support LBR TOS). However, they may parse the perf.data with
old perf tool (not support LBR TOS). The old tool doesn't check
attr.branch_sample_type. Users probably get incorrect information
without any warning.

Performance impact:
The processing time may increase with the LBR stitching approach
enabled. The impact depends on the increased depth of call stacks.

For a simple test case tchain_edit with 43 depth of call stacks.
perf record --call-graph lbr -- ./tchain_edit
perf report --stitch-lbr

Without --stitch-lbr, perf report only display 32 depth of call stacks.
With --stitch-lbr, perf report can display all 43 depth of call stacks.
The depth of call stacks increase 34.3%.

Correspondingly, the processing time of perf report increases 39%,
Without --stitch-lbr:                           11.0 sec
With --stitch-lbr:                              15.3 sec

The source code of tchain_edit.c is something similar as below.
noinline void f43(void)
{
        int i;
        for (i = 0; i < 10000;) {

                if(i%2)
                        i++;
                else
                        i++;
        }
}

noinline void f42(void)
{
        int i;
        for (i = 0; i < 100; i++) {
                f43();
                f43();
                f43();
        }
}

noinline void f41(void)
{
        int i;
        for (i = 0; i < 100; i++) {
                f42();
                f42();
                f42();
        }
}
noinline void f40(void)
{
        f41();
}

... ...

noinline void f32(void)
{
        f33();
}

noinline void f31(void)
{
        int i;

        for (i = 0; i < 10000; i++) {
                if(i%2)
                        i++;
                else
                        i++;
        }

        f32();
}

noinline void f30(void)
{
        f31();
}

... ...

noinline void f1(void)
{
        f2();
}

int main()
{
        f1();
}

Kan Liang (17):
  perf pmu: Add support for PMU capabilities
  perf header: Support CPU PMU capabilities
  perf record: Clear HEADER_CPU_PMU_CAPS for non LBR call stack mode
  perf stat: Clear HEADER_CPU_PMU_CAPS
  perf machine: Remove the indent in resolve_lbr_callchain_sample
  perf machine: Refine the function for LBR call stack reconstruction
  perf machine: Factor out lbr_callchain_add_kernel_ip()
  perf machine: Factor out lbr_callchain_add_lbr_ip()
  perf thread: Add a knob for LBR stitch approach
  perf tools: Save previous sample for LBR stitching approach
  perf tools: Save previous cursor nodes for LBR stitching approach
  perf tools: Stitch LBR call stack
  perf report: Add option to enable the LBR stitching approach
  perf script: Add option to enable the LBR stitching approach
  perf top: Add option to enable the LBR stitching approach
  perf c2c: Add option to enable the LBR stitching approach
  perf hist: Add fast path for duplicate entries check

 tools/perf/Documentation/perf-c2c.txt         |  11 +
 tools/perf/Documentation/perf-report.txt      |  11 +
 tools/perf/Documentation/perf-script.txt      |  11 +
 tools/perf/Documentation/perf-top.txt         |   9 +
 .../Documentation/perf.data-file-format.txt   |  16 +
 tools/perf/builtin-c2c.c                      |  12 +
 tools/perf/builtin-record.c                   |   3 +
 tools/perf/builtin-report.c                   |  12 +
 tools/perf/builtin-script.c                   |  12 +
 tools/perf/builtin-stat.c                     |   1 +
 tools/perf/builtin-top.c                      |  11 +
 tools/perf/util/branch.h                      |  19 +-
 tools/perf/util/callchain.h                   |   8 +
 tools/perf/util/env.h                         |   3 +
 tools/perf/util/header.c                      | 108 +++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/hist.c                        |  23 +
 tools/perf/util/machine.c                     | 423 +++++++++++++++---
 tools/perf/util/pmu.c                         |  82 ++++
 tools/perf/util/pmu.h                         |   9 +
 tools/perf/util/sort.c                        |   2 +-
 tools/perf/util/sort.h                        |   2 +
 tools/perf/util/thread.c                      |   2 +
 tools/perf/util/thread.h                      |  35 ++
 tools/perf/util/top.h                         |   1 +
 25 files changed, 757 insertions(+), 70 deletions(-)

-- 
2.17.1


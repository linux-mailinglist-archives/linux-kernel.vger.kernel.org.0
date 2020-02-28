Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A50173CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgB1QcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 11:32:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:35576 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1QcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:32:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 08:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="227592981"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2020 08:32:13 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/12] Stitch LBR call stack (Perf Tools)
Date:   Fri, 28 Feb 2020 08:29:59 -0800
Message-Id: <20200228163011.19358-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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

To determine if LBRs can be stitched, the physical index of LBR
registers is required. A new branch sample type is introduced to dump
the physical index of the most recent LBR aka Top-of-Stack (TOS)
information for perf tools.
Patch 1 & 2 extend struct branch_stack to support the new branch sample
type, PERF_SAMPLE_BRANCH_HW_INDEX.

Since the output format of PERF_SAMPLE_BRANCH_STACK will be changed
when the new branch sample type is set, an older version of perf tool
may parse the perf.data incorrectly. Furthermore, there is no warning
if this case happens. Because current perf header never check for
unknown input bits in attr. Patch 3 adds check for event attr. (Can be
merged independently.)

Besides the physical index, the maximum number of LBRs is required as
well. Patch 4 & 5 retrieve the capabilities information from sysfs
and save them in perf header.

Patch 6 & 7 implements the LBR stitching approach.

Users can use the options introduced in patch 8-11 to enable the LBR
stitching approach for perf report, script, top and c2c.

Patch 12 adds a fast path for duplicate entries check. It benefits all
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

Kan Liang (12):
  perf tools: Add hw_idx in struct branch_stack
  perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
  perf header: Add check for event attr
  perf pmu: Add support for PMU capabilities
  perf header: Support CPU PMU capabilities
  perf machine: Refine the function for LBR call stack reconstruction
  perf tools: Stitch LBR call stack
  perf report: Add option to enable the LBR stitching approach
  perf script: Add option to enable the LBR stitching approach
  perf top: Add option to enable the LBR stitching approach
  perf c2c: Add option to enable the LBR stitching approach
  perf hist: Add fast path for duplicate entries check approach

 tools/include/uapi/linux/perf_event.h         |   8 +-
 tools/perf/Documentation/perf-c2c.txt         |  11 +
 tools/perf/Documentation/perf-report.txt      |  11 +
 tools/perf/Documentation/perf-script.txt      |  11 +
 tools/perf/Documentation/perf-top.txt         |   9 +
 .../Documentation/perf.data-file-format.txt   |  16 +
 tools/perf/builtin-c2c.c                      |   6 +
 tools/perf/builtin-record.c                   |   3 +
 tools/perf/builtin-report.c                   |   6 +
 tools/perf/builtin-script.c                   |  76 ++--
 tools/perf/builtin-stat.c                     |   1 +
 tools/perf/builtin-top.c                      |  11 +
 tools/perf/tests/sample-parsing.c             |   7 +-
 tools/perf/util/branch.h                      |  27 +-
 tools/perf/util/callchain.h                   |  12 +-
 tools/perf/util/cs-etm.c                      |   1 +
 tools/perf/util/env.h                         |   3 +
 tools/perf/util/event.h                       |   1 +
 tools/perf/util/evsel.c                       |  20 +-
 tools/perf/util/evsel.h                       |   6 +
 tools/perf/util/header.c                      | 147 ++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/hist.c                        |  26 +-
 tools/perf/util/intel-pt.c                    |   2 +
 tools/perf/util/machine.c                     | 424 +++++++++++++++---
 tools/perf/util/perf_event_attr_fprintf.c     |   1 +
 tools/perf/util/pmu.c                         |  87 ++++
 tools/perf/util/pmu.h                         |  12 +
 .../scripting-engines/trace-event-python.c    |  30 +-
 tools/perf/util/session.c                     |   8 +-
 tools/perf/util/sort.c                        |   2 +-
 tools/perf/util/sort.h                        |   2 +
 tools/perf/util/synthetic-events.c            |   6 +-
 tools/perf/util/thread.c                      |   2 +
 tools/perf/util/thread.h                      |  34 ++
 tools/perf/util/top.h                         |   1 +
 36 files changed, 900 insertions(+), 131 deletions(-)

-- 
2.17.1


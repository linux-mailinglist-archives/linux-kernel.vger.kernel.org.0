Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA414A8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 18:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgA0RJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 12:09:29 -0500
Received: from mga07.intel.com ([134.134.136.100]:48043 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0RJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:09:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 08:54:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,370,1574150400"; 
   d="scan'208";a="308813152"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2020 08:54:55 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, eranian@google.com, acme@redhat.com,
        mingo@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 0/2] Stitch LBR call stack (kernel)
Date:   Mon, 27 Jan 2020 08:53:53 -0800
Message-Id: <20200127165355.27495-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V5
- Modify the changelog and comments
- To match the struct perf_branch_stack order, output hw_idx before
  entries[nr].

Changes since V4
- Only include the kernel patches
- Abstract TOS to HW index, which can be used across hw platforms.
  If we don't know the order of raw branch records, the hw_idx should be
  -1ULL. Set hw_idx to -1ULL for IBM Power for now.
- Move the new branch sample type back to bit 17

Changes since V3
- Add the new branch sample type at the end of enum
  perf_branch_sample_type.
- Rebase the user space patch on top of acme's perf/core branch

Changes since V2
- Move tos into struct perf_branch_stack

Changes since V1
- Add a new branch sample type for LBR TOS. Drop the sample type in V1.
- Add check in perf header to detect unknown input bits in event attr
- Save and use the LBR cursor nodes from previous sample to avoid
  duplicate calculation of cursor nodes.
- Add fast path for duplicate entries check. It benefits all call stack
  parsing, not just for stitch LBR call stack. It can be merged
  independetely.

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
registers is required. A new branch sample type is introduced to
dump the LBR Top-of-Stack (TOS) information for perf tools.

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

Kan Liang (2):
  perf/core: Add new branch sample type for HW index of raw branch
    records
  perf/x86/intel: Output LBR TOS information

 arch/powerpc/perf/core-book3s.c |  1 +
 arch/x86/events/intel/lbr.c     |  9 +++++++++
 include/linux/perf_event.h      | 12 ++++++++++++
 include/uapi/linux/perf_event.h |  8 +++++++-
 kernel/events/core.c            | 10 ++++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.17.1


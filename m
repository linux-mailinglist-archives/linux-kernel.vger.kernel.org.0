Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D843185853
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCOCDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:03:24 -0400
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:53960 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727574AbgCOCDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584161102; bh=Ad/jV22UrFn9MG+I0ugctWUa+s7Ehpb6o+vs6cAUP3c=;
        h=From:To:Subject:Date:Message-Id;
        b=qLnaUNvRbNKqu3jp62hvkCBY3En4qL8GJOZ272YTfg3Zw2eQL4gAGuMUvhWj304eN
         1LsMhNosp7dINz1JRcVXi9Fo96yagBw6VCHv57ERHosCyqAOfrDKdqEwQTPRIIzBsT
         F1yjGtalExm6sgYs3Xs2VYOgeCRZyzv/FXe/eO1HkuZi9ZKunjaF++ayC7FuqDiHke
         4pratGs2JwJbZHDcL0TXqhth1Zg7ceY0Mogdj1ROWhAuspWZIIXv9slZ2us4HMOs9i
         Riha9A8kfYSQi+BQksPQEbBCawRLk7drGkGBllW2ai4RdDRD2Q4OQtXnZlYYCBFQ1+
         x4WmkDOhWr5VQ==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 35B035405ED;
        Sat, 14 Mar 2020 04:45:01 +0000 (UTC)
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v4 2/3] perf vendor events amd: add Zen2 events
Date:   Sat, 14 Mar 2020 00:44:52 -0400
Message-Id: <20200314044453.82554-3-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200314044453.82554-1-vijaythakkar@me.com>
References: <20200314044453.82554-1-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003140024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds PMU events for AMD Zen2 core based processors, namely,
Matisse (model 71h), Castle Peak (model 31h) and Rome (model 2xh), as
documented in the AMD Processor Programming Reference for Matisse [1].
The model number regex has been set to detect all the models under
family 17 that do not match those of Zen1, as the range is larger for
zen2.

Zen2 adds some additional counters that are not present in Zen1 and
events for them have been added in this patch. Some counters have also
been removed for Zen2 thatwere previously present in Zen1 and have been
confirmed to always sample zero on zen2. These added/removed counters
have been omitted for brevity but can be found here:
https://gist.github.com/thakkarV/5b12ca5fd7488eb2c42e451e40bdd5f3

Note that PPR for Zen2 [1] does not include some counters that were
documented in the PPR for Zen1 based processors [2]. After having tested
these counters, some of them that still work for zen2 systems have been
preserved in the events for zen2. The counters that are omitted in [1]
but are still measurable and non-zero on zen2 (tested on a Ryzen 3900X
system) are the following:

PMC 0x000 fpu_pipe_assignment.{total|total0|total1|total2|total3}
PMC 0x004 fp_num_mov_elim_scal_op.*
PMC 0x046 ls_tablewalker.*
PMC 0x062 l2_latency.l2_cycles_waiting_on_fills
PMC 0x063 l2_wcb_req.*
PMC 0x06D l2_fill_pending.l2_fill_busy
PMC 0x080 ic_fw32
PMC 0x081 ic_fw32_miss
PMC 0x086 bp_snp_re_sync
PMC 0x087 ic_fetch_stall.*
PMC 0x08C ic_cache_inval.*
PMC 0x099 bp_tlb_rel
PMC 0x0C7 ex_ret_brn_resync
PMC 0x28A ic_oc_mode_switch.*
L3PMC 0x001 l3_request_g1.*
L3PMC 0x006 l3_comb_clstr_state.*

[1]: Processor Programming Reference (PPR) for AMD Family 17h Model 71h,
Revision B0 Processors, 56176 Rev 3.06 - Jul 17, 2019
[2]: Processor Programming Reference (PPR) for AMD Family 17h Models
01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019
All of the PPRs can be found at:
https://bugzilla.kernel.org/show_bug.cgi?id=206537

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>

---
Changes in v2:
    - Correct UMask for ls_mab_alloc.loads
Changes in v3:
    - branch: update BriefDescriptions of event to match the latest AMD
    PPR
    - cache: update BriefDescriptions and remove redundant
    PublicDescriptions. Add missing UMasks for counters 70h, 71h and 72h.
    - floating_point: update descriptions to latest PPR
    - memory: update descriptions.
    - other: update descriptions. change umask for PMC0xAF to be
    up to date with PPR 56176 Rev 3.06
Changes in v4:
    - PMC 0x46: Add I and D side tablewalker allocation breakdown by
    type 0 and 1 based on Zen 1 PPR 54945 Rev 3.03
    - clean up numerous event descriptions

 .../pmu-events/arch/x86/amdzen2/branch.json   |  52 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 338 +++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/core.json     | 130 +++++++
 .../arch/x86/amdzen2/floating-point.json      | 112 ++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 341 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 115 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 7 files changed, 1089 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/branch.json b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
new file mode 100644
index 000000000000..cfabc1711867
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
@@ -0,0 +1,52 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "[L1 Branch Prediction Overrides Existing Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 Branch Prediction Overrides Existing Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic Indirect Predictions.",
+    "PublicDescription": "Indirect Branch Prediction for potential multi-target branch (speculative)."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB.",
+    "UMask": "0xFF"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if1g",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 1GB page.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if2m",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 2MB page.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if4k",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 4KB page.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_tlb_rel",
+    "EventCode": "0x99",
+    "BriefDescription": "The number of ITLB reload requests."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
new file mode 100644
index 000000000000..1c60bfa0f00b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
@@ -0,0 +1,338 @@
+[
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache reads (including hardware and software prefetch).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache stores.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache shared reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Instruction cache reads.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.change_to_x",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache state change requests. Request change to writable, check L2 for current state.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2_cmd",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). PrefetchL2Cmd.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). L2 Prefetcher. All prefetches accepted by L2 pipeline, hit or miss. Types of PF and L2 hit/miss broken out in a separate perfmon event.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g1.group2",
+    "EventCode": "0x60",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_request_g2.group1",
+    "EventCode": "0x61",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g1 (PMCx060).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized non-cacheable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized non-cacheable.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g2.smc_inval",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Self-modifying code invalidates.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_originator",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus locks.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_responses",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus lock response.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
+    "EventCode": "0x62",
+    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_write",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB write requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB close requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_wcb_req.zero_byte_store",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB zero byte store requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_wcb_req.cl_zero",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB cache line zeroing requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache shared read hit in L2",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit in L2.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit on shared line in L2.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache store or state change hit in L2.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache request miss in L2 (all types).",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit modifiable line in L2.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit clean line in L2.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_fill_pending.l2_fill_busy",
+    "EventCode": "0x6d",
+    "BriefDescription": "Cycles with fill pending from L2. Total cycles spent with one or more fill requests in flight from L2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_pf_hit_l2",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetch hit in L2.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetcher hits in L3. Counts all L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit the L3.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetcher misses in L3. All L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ic_fw32",
+    "EventCode": "0x80",
+    "BriefDescription": "The number of 32B fetch windows transferred from IC pipe to DE instruction decoder (includes non-cacheable and cacheable fill responses)."
+  },
+  {
+    "EventName": "ic_fw32_miss",
+    "EventCode": "0x81",
+    "BriefDescription": "The number of 32B fetch windows tried to read the L1 IC and missed in the full tag."
+  },
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "The number of 64 byte instruction cache line was fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "The number of 64 byte instruction cache line fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "The number of instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 1GB page.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 2MB page.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 4KB page.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_snp_re_sync",
+    "EventCode": "0x86",
+    "BriefDescription": "The number of pipeline restarts caused by invalidating probes that hit on the instruction stream currently being executed. This would happen if the active instruction stream was being modified by another processor in an MP system - typically a highly unlikely event."
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_any",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_cache_inval.l2_invalidating_probe",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS). The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_cache_inval.fill_invalidated",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to overwriting fill response. The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC Mode Switch. OC to IC mode switch.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC Mode Switch. IC to OC mode switch.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x00",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "EventCode": "0x9A",
+    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
new file mode 100644
index 000000000000..de89e5a44ff1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
@@ -0,0 +1,130 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired Instructions."
+  },
+  {
+    "EventName": "ex_ret_cops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired Uops.",
+    "PublicDescription": "The number of micro-ops retired. This count includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 8."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired Branch Instructions.",
+    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of branch instructions retired, of any type, that were not correctly predicted. This includes those for which prediction is not attempted (far control transfers, exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired Taken Branch Instructions.",
+    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired Far Control Transfers.",
+    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_brn_resync",
+    "EventCode": "0xc7",
+    "BriefDescription": "Retired Branch Resyncs.",
+    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired Near Returns.",
+    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired Near Returns Mispredicted.",
+    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "MMX instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "x87 instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired Conditional Branch Instructions."
+  },
+  {
+    "EventName": "ex_ret_cond_misp",
+    "EventCode": "0xd2",
+    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Div Cycles Busy count."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Div Op Count."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_fus_brnch_inst",
+    "EventCode": "0x1d0",
+    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8.",
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
new file mode 100644
index 000000000000..f398e6b72c41
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
@@ -0,0 +1,112 @@
+[
+  {
+    "EventName": "fpu_pipe_assignment.total",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps.",
+    "PublicDescription": "Total number of fp uOps. The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0xf"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "All FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mac_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Multiply-add FLOPS. Multiply-add counts as 2 FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "PublicDescription": "",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Divide/square root FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Multiply FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Add/subtract FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.optimized",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Scalar Ops optimized. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass). This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops eliminated. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE bottom-executing uOps retired. The number of serializing Ops retired.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 bottom-executing uOps retired. The number of serializing Ops retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits. The number of serializing Ops retired.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_spill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. YMM spill fault.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. YMM fill fault.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_disp_faults.xmm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. XMM fill fault.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_disp_faults.x87_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. x87 fill fault.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
new file mode 100644
index 000000000000..715046b339cb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
@@ -0,0 +1,341 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons. Store To Load Interlock (STLI) are loads that were unable to complete because of a possible match with an older store, and the older store could not do STLF for some reason.",
+    "PublicDescription" : "Store-to-load conflicts: A load was unable to complete due to a non-forwardable conflict with an older store. Most commonly, a load's address range partially but not completely overlaps with an uncompleted older store. Software can avoid this problem by using same-size and same-alignment loads and stores when accessing the same data. Vector/SIMD code is particularly susceptible to this problem; software should construct wide vector stores by manipulating vector elements in registers using shuffle/blend/swap instructions prior to storing to memory, instead of using narrow element-by-element stores.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_hi_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. High speculative cacheable lock speculation succeeded.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_lo_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Low speculative cacheable lock speculation succeeded.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_locks.non_spec_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Non-speculative lock succeeded.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type. Comparable to legacy bus lock.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_ret_cl_flush",
+    "EventCode": "0x26",
+    "BriefDescription": "Number of retired CLFLUSH instructions."
+  },
+  {
+    "EventName": "ls_ret_cpuid",
+    "EventCode": "0x27",
+    "BriefDescription": "Number of retired CPUID instructions."
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Dispatch of a single op that performs a load from and store to the same memory address. Number of single ops that do load/store to an address.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of stores dispatched. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of loads dispatched. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_smi_rx",
+    "EventCode": "0x2B",
+    "BriefDescription": "Number of SMIs received."
+  },
+  {
+    "EventName": "ls_int_taken",
+    "EventCode": "0x2C",
+    "BriefDescription": "Number of interrupts taken."
+  },
+  {
+    "EventName": "ls_rdtsc",
+    "EventCode": "0x2D",
+    "BriefDescription": "Number of reads of the TSC (RDTSC instructions). The count is speculative."
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Number of STLF hits."
+  },
+  {
+    "EventName": "ls_st_commit_cancel2.st_commit_cancel_wcb_full",
+    "EventCode": "0x37",
+    "BriefDescription": "A non-cacheable store and the non-cacheable commit buffer is full."
+  },
+  {
+    "EventName": "ls_dc_accesses",
+    "EventCode": "0x40",
+    "BriefDescription": "Number of accesses to the dcache for load/store references.",
+    "PublicDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
+  },
+  {
+    "EventName": "ls_mab_alloc.dc_prefetcher",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. DC prefetcher.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_mab_alloc.stores",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. Stores.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_mab_alloc.loads",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. Loads.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from different die.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. Hit in cache; Remote CCX and the address's Home Node is on a different die.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. Local L2 hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "All L1 DTLB Misses or Reloads.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that miss in the L2 TLB.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that miss in the L2 TLB.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload coalesced page miss.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that miss the L2 TLB.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that hit in the L2 TLB.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that hit in the L2 TLB.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload hit a coalesced page.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that hit in the L2 TLB.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_tablewalker.iside",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks on I-side.",
+    "UMask": "0xc"
+  },
+  {
+    "EventName": "ls_tablewalker.ic_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks IC Type 1.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_tablewalker.ic_type0",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks IC Type 0.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_tablewalker.dside",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks on D-side.",
+    "UMask": "0x3"
+  },
+  {
+    "EventName": "ls_tablewalker.dc_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_tablewalker.dc_type0",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 0.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_misal_accesses",
+    "EventCode": "0x47",
+    "BriefDescription": "Misaligned loads."
+  },
+  {
+    "EventName": "ls_pref_instr_disp",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative).",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). PrefetchNTA instruction. See docAPM3 PREFETCHlevel.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). See docAPM3 PREFETCHW.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). Prefetch_T0_T1_T2. PrefetchT0, T1 and T2 instructions. See docAPM3 PREFETCHlevel.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a DC hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From DRAM (home node remote).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From another cache (home node remote).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. DRAM or IO from this thread's die.  From DRAM (home node local).",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From another cache (home node local).",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. Local L2 hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From DRAM (home node remote).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From another cache (home node remote).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From DRAM (home node local).",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From another cache (home node local).",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. Local L2 hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Cycles not in Halt."
+  },
+  {
+    "EventName": "ls_tlb_flush",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB Flushes"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/other.json b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
new file mode 100644
index 000000000000..e94994d4a60e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
@@ -0,0 +1,115 @@
+[
+  {
+    "EventName": "de_dis_uop_queue_empty_di0",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles where the Micro-Op Queue is empty."
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from either the decoders, OpCache or both.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder.opcache_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Count of dispatched Ops from OpCache.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder.decoder_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Count of dispatched Ops from Decoder.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_misc_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. FP Miscellaneous resource unavailable. Applies to the recovery of mispredicts with FP ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_sch_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. FP scheduler resource stall. Applies to ops that use the FP scheduler.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Floating point register file resource stall. Applies to all FP ops that have a destination register.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.taken_branch_buffer_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Taken branch buffer resource stall.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_sched_misc_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Scheduler miscellaneous resource stall.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.store_queue_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Store queue resource stall. Applies to all ops with store semantics.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.load_queue_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Load queue resource stall. Applies to all ops with load semantics.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Physical Register File resource stall. Applies to all ops that have an integer destination register.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. SC AGU dispatch stall.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ3_0_TokenStall.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 82a9db00125e..244a36e37a3a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -37,3 +37,4 @@ GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
+AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.25.1


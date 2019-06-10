Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2AD3AFAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbfFJH3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 03:29:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:14549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbfFJH3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:34 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] perf intel-pt: Add xmm registers to synthesized PEBS sample
Date:   Mon, 10 Jun 2019 10:28:00 +0300
Message-Id: <20190610072803.10456-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610072803.10456-1-adrian.hunter@intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add xmm register information from PEBS data in the Intel PT trace to the
synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3a6d5af6a71b..0175a4ec248f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1499,6 +1499,31 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
 	return pos;
 }
 
+#ifndef PERF_REG_X86_XMM0
+#define PERF_REG_X86_XMM0 32
+#endif
+
+static void intel_pt_add_xmm(struct regs_dump *intr_regs, u64 *pos,
+			     const struct intel_pt_blk_items *items,
+			     u64 regs_mask)
+{
+	u32 mask = items->has_xmm & (regs_mask >> PERF_REG_X86_XMM0);
+	const u64 *xmm = items->xmm;
+
+	/*
+	 * If there are any XMM registers, then there should be all of them.
+	 * Nevertheless, follow the logic to add only registers that were
+	 * requested (i.e. 'regs_mask') and that were provided (i.e. 'mask'),
+	 * and update the resulting mask (i.e. 'intr_regs->mask') accordingly.
+	 */
+	intr_regs->mask |= (u64)mask << PERF_REG_X86_XMM0;
+
+	for (; mask; mask >>= 1, xmm++) {
+		if (mask & 1)
+			*pos++ = *xmm;
+	}
+}
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1553,13 +1578,16 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	    items->mask[INTEL_PT_GP_REGS_POS]) {
 		u64 regs[sizeof(sample.intr_regs.mask)];
 		u64 regs_mask = evsel->attr.sample_regs_intr;
+		u64 *pos;
 
 		sample.intr_regs.abi = items->is_32_bit ?
 				       PERF_SAMPLE_REGS_ABI_32 :
 				       PERF_SAMPLE_REGS_ABI_64;
 		sample.intr_regs.regs = regs;
 
-		intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+		pos = intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+
+		intel_pt_add_xmm(&sample.intr_regs, pos, items, regs_mask);
 	}
 
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
-- 
2.17.1


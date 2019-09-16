Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FB8B3BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbfIPNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 09:43:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:53809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387736AbfIPNm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:42:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 06:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="387208994"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 06:42:58 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 02/14] perf/x86/intel: Set correct mask for TOPDOWN.SLOTS
Date:   Mon, 16 Sep 2019 06:41:16 -0700
Message-Id: <20190916134128.18120-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

TOPDOWN.SLOTS(0x0400) is not a generic event. It is only available on
fixed counter3.

Don't extend its mask to generic counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- Separate fixed counter3 definition patch

 arch/x86/events/intel/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 43c966d1208e..f0208ee554fc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5106,12 +5106,14 @@ __init int intel_pmu_init(void)
 
 	if (x86_pmu.event_constraints) {
 		/*
-		 * event on fixed counter2 (REF_CYCLES) only works on this
+		 * event on fixed counter2 (REF_CYCLES) and
+		 * fixed counter3 (TOPDOWN.SLOTS) only work on this
 		 * counter, so do not extend mask to generic counters
 		 */
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
 			if (c->cmask == FIXED_EVENT_FLAGS
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
+			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES
+			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_SLOTS) {
 				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
 			}
 			c->idxmsk64 &=
-- 
2.17.1


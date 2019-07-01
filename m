Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB125A11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 23:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfEUVlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 17:41:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:32416 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbfEUVlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:41:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 14:41:44 -0700
X-ExtLoop1: 1
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2019 14:41:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/9] perf/x86/intel: Set correct weight for TopDown metrics events
Date:   Tue, 21 May 2019 14:40:51 -0700
Message-Id: <20190521214055.31060-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190521214055.31060-1-kan.liang@linux.intel.com>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The topdown metrics and slots events are mapped to a fixed counter,
but should have the normal weight for the scheduler.
So special case this.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2eec172765f4..6de9249acb28 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5281,6 +5281,15 @@ __init int intel_pmu_init(void)
 		 * counter, so do not extend mask to generic counters
 		 */
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
+			/*
+			 * Don't limit the event mask for TopDown
+			 * metrics and slots events.
+			 */
+			if (x86_pmu.num_counters_fixed >= 3 &&
+			    c->idxmsk64 & INTEL_PMC_MSK_ANY_SLOTS) {
+				c->weight = hweight64(c->idxmsk64);
+				continue;
+			}
 			if (c->cmask == FIXED_EVENT_FLAGS
 			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
 				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
-- 
2.14.5


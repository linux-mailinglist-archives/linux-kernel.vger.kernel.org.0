Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED33E014B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfJVJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 05:58:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:26087 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbfJVJ6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:58:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="197074464"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2019 02:58:41 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 2/4] perf/x86/intel/pt: Factor out starting the trace
Date:   Tue, 22 Oct 2019 12:58:10 +0300
Message-Id: <20191022095812.67071-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PT trace is now enabled at the bottom of the event configuration
function that takes care of all configuration bits related to a given
event, including the address filter update. This is only needed where
the event configuration changes, that is, in ->add()/->start().

In the interrupt path we can use a lighter version that keeps the
configuration intact, since it hasn't changed, and only flips the
enable bit.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 05e43d0f430b..170f3b402274 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -397,6 +397,20 @@ static bool pt_event_valid(struct perf_event *event)
  * These all are cpu affine and operate on a local PT
  */
 
+static void pt_config_start(struct perf_event *event)
+{
+	struct pt *pt = this_cpu_ptr(&pt_ctx);
+	u64 ctl = event->hw.config;
+
+	ctl |= RTIT_CTL_TRACEEN;
+	if (READ_ONCE(pt->vmx_on))
+		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
+	else
+		wrmsrl(MSR_IA32_RTIT_CTL, ctl);
+
+	WRITE_ONCE(event->hw.config, ctl);
+}
+
 /* Address ranges and their corresponding msr configuration registers */
 static const struct pt_address_range {
 	unsigned long	msr_a;
@@ -468,7 +482,6 @@ static u64 pt_config_filters(struct perf_event *event)
 
 static void pt_config(struct perf_event *event)
 {
-	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 reg;
 
 	/* First round: clear STATUS, in particular the PSB byte counter. */
@@ -501,10 +514,7 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.config = reg;
-	if (READ_ONCE(pt->vmx_on))
-		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
-	else
-		wrmsrl(MSR_IA32_RTIT_CTL, reg);
+	pt_config_start(event);
 }
 
 static void pt_config_stop(struct perf_event *event)
@@ -1381,7 +1391,7 @@ void intel_pt_interrupt(void)
 
 		pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
 				 buf->output_off);
-		pt_config(event);
+		pt_config_start(event);
 	}
 }
 
-- 
2.23.0


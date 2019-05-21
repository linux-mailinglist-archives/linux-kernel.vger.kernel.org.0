Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653C925A15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 23:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfEUVmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 17:42:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:32416 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbfEUVlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:41:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 14:41:45 -0700
X-ExtLoop1: 1
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2019 14:41:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/9] perf/x86/intel: Export new TopDown metrics events for Icelake
Date:   Tue, 21 May 2019 14:40:52 -0700
Message-Id: <20190521214055.31060-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190521214055.31060-1-kan.liang@linux.intel.com>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Export new TopDown metrics events for perf that map to the sub metrics
in the metrics register, and another for the new slots fixed counter.
This makes the new fixed counters in Icelake visible to the perf
user tools.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6de9249acb28..79e9d05e047d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -320,6 +320,12 @@ EVENT_ATTR_STR_HT(topdown-recovery-bubbles, td_recovery_bubbles,
 EVENT_ATTR_STR_HT(topdown-recovery-bubbles.scale, td_recovery_bubbles_scale,
 	"4", "2");
 
+EVENT_ATTR_STR(slots,			slots,		"event=0x00,umask=0x4");
+EVENT_ATTR_STR(topdown-retiring,	td_retiring,	"event=0xff,umask=0x1");
+EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec,	"event=0xff,umask=0x2");
+EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound,	"event=0xff,umask=0x3");
+EVENT_ATTR_STR(topdown-be-bound,	td_be_bound,	"event=0xff,umask=0x4");
+
 static struct attribute *snb_events_attrs[] = {
 	EVENT_PTR(td_slots_issued),
 	EVENT_PTR(td_slots_retired),
@@ -4462,6 +4468,11 @@ EVENT_ATTR_STR(el-capacity-write, el_capacity_write, "event=0x54,umask=0x2");
 static struct attribute *icl_events_attrs[] = {
 	EVENT_PTR(mem_ld_hsw),
 	EVENT_PTR(mem_st_hsw),
+	EVENT_PTR(slots),
+	EVENT_PTR(td_retiring),
+	EVENT_PTR(td_bad_spec),
+	EVENT_PTR(td_fe_bound),
+	EVENT_PTR(td_be_bound),
 	NULL,
 };
 
-- 
2.14.5


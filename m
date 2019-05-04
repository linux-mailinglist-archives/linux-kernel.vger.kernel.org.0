Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA422139E6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfEDMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 08:52:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfEDMwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 742E63081244;
        Sat,  4 May 2019 12:52:23 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6A885C298;
        Sat,  4 May 2019 12:52:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/8] perf/x86/intel: Use update attributes for skylake format
Date:   Sat,  4 May 2019 14:52:06 +0200
Message-Id: <20190504125207.24662-8-jolsa@kernel.org>
In-Reply-To: <20190504125207.24662-1-jolsa@kernel.org>
References: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sat, 04 May 2019 12:52:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new pmu::update_attrs attribute group for
skylake specific format attributes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 235d06e2aac5..dc08e4cf18b8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4444,6 +4444,11 @@ static struct attribute_group group_format_extra = {
 	.is_visible = exra_is_visible,
 };
 
+static struct attribute_group group_format_extra_skl = {
+	.name       = "format",
+	.is_visible = exra_is_visible,
+};
+
 static const struct attribute_group *attr_update[] = {
 	&group_events_td,
 	&group_events_mem,
@@ -4451,17 +4456,18 @@ static const struct attribute_group *attr_update[] = {
 	&group_caps_gen,
 	&group_caps_lbr,
 	&group_format_extra,
+	&group_format_extra_skl,
 	NULL,
 };
 
 
 __init int intel_pmu_init(void)
 {
+	struct attribute **extra_skl_attr = NULL;
 	struct attribute **extra_attr = NULL;
 	struct attribute **td_attr = NULL;
 	struct attribute **mem_attr = NULL;
 	struct attribute **tsx_attr = NULL;
-	struct attribute **to_free = NULL;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
@@ -4949,8 +4955,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
-		extra_attr = merge_attr(extra_attr, skl_format_attr);
-		to_free = extra_attr;
+		extra_skl_attr = skl_format_attr;
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
@@ -4988,7 +4993,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.get_event_constraints = icl_get_event_constraints;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
-		extra_attr = merge_attr(extra_attr, skl_format_attr);
+		extra_skl_attr = skl_format_attr;
 		mem_attr = icl_events_attrs;
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
@@ -5023,6 +5028,7 @@ __init int intel_pmu_init(void)
 	group_events_mem.attrs = mem_attr;
 	group_events_tsx.attrs = tsx_attr;
 	group_format_extra.attrs = extra_attr;
+	group_format_extra_skl.attrs = extra_skl_attr;
 
 	x86_pmu.attr_update = attr_update;
 
@@ -5103,7 +5109,6 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.counter_freezing)
 		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
 
-	kfree(to_free);
 	return 0;
 }
 
-- 
2.20.1


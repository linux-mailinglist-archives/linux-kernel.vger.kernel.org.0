Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540C71ACF0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfELPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 11:55:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfELPzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C14A3084248;
        Sun, 12 May 2019 15:55:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6245D5C26D;
        Sun, 12 May 2019 15:55:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/9] perf/x86: Use update attribute groups for extra format
Date:   Sun, 12 May 2019 17:55:16 +0200
Message-Id: <20190512155518.21468-8-jolsa@kernel.org>
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 12 May 2019 15:55:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new pmu::update_attrs attribute group for
extra "format" directory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fff73623cf80..524b390a2c26 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4408,6 +4408,12 @@ lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.lbr_nr ? attr->mode : 0;
 }
 
+static umode_t
+exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return x86_pmu.version >= 2 ? attr->mode : 0;
+}
+
 static struct attribute_group group_events_td  = {
 	.name = "events",
 };
@@ -4433,12 +4439,18 @@ static struct attribute_group group_caps_lbr = {
 	.is_visible = lbr_is_visible,
 };
 
+static struct attribute_group group_format_extra = {
+	.name       = "format",
+	.is_visible = exra_is_visible,
+};
+
 static const struct attribute_group *attr_update[] = {
 	&group_events_td,
 	&group_events_mem,
 	&group_events_tsx,
 	&group_caps_gen,
 	&group_caps_lbr,
+	&group_format_extra,
 	NULL,
 };
 
@@ -5007,15 +5019,11 @@ __init int intel_pmu_init(void)
 
 	snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
 
-	if (version >= 2 && extra_attr) {
-		x86_pmu.format_attrs = merge_attr(intel_arch3_formats_attr,
-						  extra_attr);
-		WARN_ON(!x86_pmu.format_attrs);
-	}
 
 	group_events_td.attrs  = td_attr;
 	group_events_mem.attrs = mem_attr;
 	group_events_tsx.attrs = tsx_attr;
+	group_format_extra.attrs = extra_attr;
 
 	x86_pmu.attr_update = attr_update;
 
-- 
2.20.1


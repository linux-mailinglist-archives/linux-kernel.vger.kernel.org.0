Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8703033109
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfFCN3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:29:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfFCN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:29:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DThC3609767
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:29:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DThC3609767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568584;
        bh=8EPIEtVfPl/ljQOg1KnArFPw/lkWvIwGLWE1WjmExcI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=S648FvLKoArLj1B7doB0KgM2clYGaTtsGurdzhU6V59M2hMuH7zLq4xoDSvb0tFah
         ppoj9qrr4mulPBxgq8jx3B98dC8m1FxT1PNdIVmNATmWNKk9RIZZCzCcjtqTCI4IYu
         oGWrh+N+d4mivHqElbAgu+za4UAY4UmfG6e6XeDLM8nhOZdG2yTg+NEcHkOMUgKfTB
         rextu/4wRRE4z/3KaLgzJG6G8lYpL+7DReeeHTsA6WWI4vxJmfMxaWTRGnI5AJv1bL
         2WCKgVrv+Xxiao/QE2BVSXUk25gGYm3aK1LxCRIbhXBQ1aw/vv7WmcCwot++kRSqwd
         aOc6z9jvSjG3g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DTh2G609764;
        Mon, 3 Jun 2019 06:29:43 -0700
Date:   Mon, 3 Jun 2019 06:29:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-3ea40ac77261530b2c96734b99c0c9f1dc1d729d@git.kernel.org>
Cc:     tglx@linutronix.de, gregkh@linuxfoundation.org, jolsa@kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org,
        acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com
Reply-To: torvalds@linux-foundation.org, acme@kernel.org,
          tglx@linutronix.de, gregkh@linuxfoundation.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20190512155518.21468-8-jolsa@kernel.org>
References: <20190512155518.21468-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Use update attribute groups for extra
 format
Git-Commit-ID: 3ea40ac77261530b2c96734b99c0c9f1dc1d729d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3ea40ac77261530b2c96734b99c0c9f1dc1d729d
Gitweb:     https://git.kernel.org/tip/3ea40ac77261530b2c96734b99c0c9f1dc1d729d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:16 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:25 +0200

perf/x86: Use update attribute groups for extra format

Using the new pmu::update_attrs attribute group for
extra "format" directory.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-8-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d4002e71a0b8..de4779f44737 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4417,6 +4417,12 @@ lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
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
@@ -4442,12 +4448,18 @@ static struct attribute_group group_caps_lbr = {
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
 
@@ -5016,15 +5028,11 @@ __init int intel_pmu_init(void)
 
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
 

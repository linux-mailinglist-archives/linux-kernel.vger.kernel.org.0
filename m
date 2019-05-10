Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CAA1983C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 08:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfEJGI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 02:08:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfEJGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:08:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4A67K8r1921226
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 May 2019 23:07:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4A67K8r1921226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557468441;
        bh=PmlmIVDFuzfc1ITIkyMA7ltEHqkkvQcVOEDJZ10yuXY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=docbuebcqP7GPaAl6bwMrdfSSnfRy56z6y+Q0Or9hRWOQHJRm1PXAaunuJIEKSoeS
         KzpS6Tzc5Ad30x+WB5ll9DG1SsXk51hl40n6rdgNozFFzFrsWlebDhW+g/+FjZCzHB
         UvPmgw3Fro6O+9wP3oIOfacq4AyAG4KnYpFb7k1xawnIXnGiI0cwSJ3Q0SSpOnnotJ
         0A/vrHkHMa02LNUvV9eCYIK4EmpXLhVLoqz/qr2KkgXTRUGcnXjiE6/FWQUCZMtezf
         vOTr5poT9jbLd+vitVIwSeq/t+16JipwlaqUvgimR0AFg5eNM4Z/zKaA2ky8I2gFKJ
         7lpGeg6HNgPzA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4A67Kd61921223;
        Thu, 9 May 2019 23:07:20 -0700
Date:   Thu, 9 May 2019 23:07:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-6b89d4c1ae8596a8c9240f169ef108704de373f2@git.kernel.org>
Cc:     vincent.weaver@maine.edu, hpa@zytor.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, eranian@google.com,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: hpa@zytor.com, vincent.weaver@maine.edu, acme@redhat.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          jolsa@redhat.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, eranian@google.com,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20190509214556.123493-1-eranian@google.com>
References: <20190509214556.123493-1-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT*
 masking
Git-Commit-ID: 6b89d4c1ae8596a8c9240f169ef108704de373f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6b89d4c1ae8596a8c9240f169ef108704de373f2
Gitweb:     https://git.kernel.org/tip/6b89d4c1ae8596a8c9240f169ef108704de373f2
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Thu, 9 May 2019 14:45:56 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 10 May 2019 08:04:17 +0200

perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking

On Intel Westmere, a cmdline as follows:

  $ perf record -e cpu/event=0xc4,umask=0x2,name=br_inst_retired.near_call/p ....

was failing. Yet the event+ umask support PEBS.

It turns out this is due to a bug in the the PEBS event constraint table for
westmere. All forms of BR_INST_RETIRED.* support PEBS. Therefore the constraint
mask should ignore the umask. The name of the macro INTEL_FLAGS_EVENT_CONSTRAINT()
hint that this is the case but it was not. That macros was checking both the
event code and event umask. Therefore, it was only matching on 0x00c4.
There are code+umask macros, they all have *UEVENT*.

This bug fixes the issue by checking only the event code in the mask.
Both single and range version are modified.

Signed-off-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: kan.liang@intel.com
Link: http://lkml.kernel.org/r/20190509214556.123493-1-eranian@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 07fc84bb85c1..a6ac2f4f76fc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -394,10 +394,10 @@ struct cpu_hw_events {
 
 /* Event constraint, but match on all event flags too. */
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
-	EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
 
 #define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)			\
-	EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+	EVENT_CONSTRAINT_RANGE(c, e, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
 
 /* Check only flags, but allow all event/umask */
 #define INTEL_ALL_EVENT_CONSTRAINT(code, n)	\

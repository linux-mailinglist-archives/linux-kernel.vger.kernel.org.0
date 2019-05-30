Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F832F843
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfE3IHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:07:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfE3IHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:07:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U86w2G2903560
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:06:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U86w2G2903560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203618;
        bh=ZvhgDNjsbWAuBYcQoOxO0xUG5Z6dvo09/2kLCYNbkYU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rKXipFQDaNPOjtRbagzwI4GMdO8aFnKX9xL7FEago1kc/1+T4A8+ljnWaM7mypRK3
         9/yjTRfA0CkRBOFakeghWRTeIiKZKvlDD/jawBUb1tRFARGfpisschgO8hYFxW28nN
         11MZe5hipotuDtlxWSb9H+lVCriSuDrLj71C9fpz90YPhCTUBiquHrEAt7lSFXrtQo
         SFE8EFnxfn6C2WgDkQ/QVFpZetS2HaW1REKX0zo2GNSjrD5WwQ4uEK4MIXMpCR+a4y
         Xc+oED1t4906VmPThPwLV6wo1klFkBK5cpIuGIh5gQ9uqLBpJL5KFGpJfJ1yejapef
         ycmRY6tY3sDHA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U86vWv2903557;
        Thu, 30 May 2019 01:06:57 -0700
Date:   Thu, 30 May 2019 01:06:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Namhyung Kim <tipbot@zytor.com>
Message-ID: <tip-a0c0a4ac021b017e385d0328541ccfebeef165fc@git.kernel.org>
Cc:     hbathini@linux.vnet.ibm.com, kjlx@templeofstupid.com,
        acme@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        jolsa@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          hbathini@linux.vnet.ibm.com, kjlx@templeofstupid.com,
          acme@redhat.com, namhyung@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, jolsa@redhat.com
In-Reply-To: <20190522053250.207156-4-namhyung@kernel.org>
References: <20190522053250.207156-4-namhyung@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Add --namespaces option
Git-Commit-ID: a0c0a4ac021b017e385d0328541ccfebeef165fc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a0c0a4ac021b017e385d0328541ccfebeef165fc
Gitweb:     https://git.kernel.org/tip/a0c0a4ac021b017e385d0328541ccfebeef165fc
Author:     Namhyung Kim <namhyung@kernel.org>
AuthorDate: Wed, 22 May 2019 14:32:50 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf top: Add --namespaces option

Since 'perf record' already have this option, let's have it for 'perf top'
as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Link: http://lkml.kernel.org/r/20190522053250.207156-4-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 44d89fb9c788..cfea87c6f38e 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -262,6 +262,11 @@ Default is to monitor all CPUS.
 	The number of threads to run when synthesizing events for existing processes.
 	By default, the number of threads equals to the number of online CPUs.
 
+--namespaces::
+	Record events of type PERF_RECORD_NAMESPACES and display it with the
+	'cgroup_id' sort key.
+
+
 INTERACTIVE PROMPTING KEYS
 --------------------------
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fbbb0da43abb..31d78d874fc7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1208,6 +1208,9 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
+	if (opts->record_namespaces)
+		top->tool.namespace_events = true;
+
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
@@ -1500,6 +1503,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
+	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
+		    "Record namespaces events"),
 	OPT_END()
 	};
 	struct perf_evlist *sb_evlist = NULL;

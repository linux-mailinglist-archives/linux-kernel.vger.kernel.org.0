Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CB7F37C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfKGTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfKGTBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:01:42 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C522085B;
        Thu,  7 Nov 2019 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153301;
        bh=t/QgRpHFU2LPSl3N9NmsAbB0ibf1Lo3gcHs2HA98WTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnYfglODqyxPTYSEDhjmAe4WoATJIyD2mYLocg7NlBQwiO7dboT8D+hsOSQJaqjkV
         BnDfc9nFu/CjAy3c54psmbyIFEPX8u+DO97vukl1lGImVyBgTOD2SYayE3roB4E8n2
         WLMh1HiI+mekGppwETAbWsjYBMY9eYvoTGw9RPkk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/63] perf evsel: Always preserve errno while cleaning up perf_event_open failures
Date:   Thu,  7 Nov 2019 15:59:17 -0300
Message-Id: <20191107190011.23924-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In some cases when perf_event_open fails, it may do some closes to clean
up. In special cases these closes can fail too, which overwrites the
errno of the perf_event_open, which is then incorrectly reported.

Save/restore errno around closes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191020175202.32456-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index abc7fda4a0fe..d831038b55f2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1574,7 +1574,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 {
 	int cpu, thread, nthreads;
 	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
-	int pid = -1, err;
+	int pid = -1, err, old_errno;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
 	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
@@ -1727,8 +1727,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 */
 	if (err == -EMFILE && set_rlimit < INCREASED_MAX) {
 		struct rlimit l;
-		int old_errno = errno;
 
+		old_errno = errno;
 		if (getrlimit(RLIMIT_NOFILE, &l) == 0) {
 			if (set_rlimit == NO_CHANGE)
 				l.rlim_cur = l.rlim_max;
@@ -1812,6 +1812,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err)
 		threads->err_thread = thread;
 
+	old_errno = errno;
 	do {
 		while (--thread >= 0) {
 			close(FD(evsel, cpu, thread));
@@ -1819,6 +1820,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		}
 		thread = nthreads;
 	} while (--cpu >= 0);
+	errno = old_errno;
 	return err;
 }
 
-- 
2.21.0


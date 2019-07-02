Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAFAC5C726
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfGBC0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfGBC0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE82D21841;
        Tue,  2 Jul 2019 02:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034393;
        bh=VjWEkBhhN2oXEChv3gpfUzUSeqfy9+UHCTmi9kAyLik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6l0Kk8By6asCNK7e1nJdtuMaZzWZ6jwso+XHf4S9uTXB/6FeXC+2Z8yyutke47O4
         cmloRYECMSaL7b78DW/j7ap60/8FUi4ALVx/uz5UeMZr5/YotQcFfkouoJMJUP1ubQ
         6rJ+mRh9JCjGM8orRErPkZbNqP8/wps864md7o1w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/43] perf thread-stack: Eliminate code duplicating thread_stack__pop_ks()
Date:   Mon,  1 Jul 2019 23:25:36 -0300
Message-Id: <20190702022616.1259-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Use new function thread_stack__pop_ks() in place of equivalent code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190619064429.14940-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 4c826a2e08d8..6ff1ff4d4ce7 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -664,12 +664,9 @@ static int thread_stack__no_call_return(struct thread *thread,
 
 	if (ip >= ks && addr < ks) {
 		/* Return to userspace, so pop all kernel addresses */
-		while (thread_stack__in_kernel(ts)) {
-			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							tm, ref, true);
-			if (err)
-				return err;
-		}
+		err = thread_stack__pop_ks(thread, ts, sample, ref);
+		if (err)
+			return err;
 
 		/* If the stack is empty, push the userspace address */
 		if (!ts->cnt) {
@@ -679,12 +676,9 @@ static int thread_stack__no_call_return(struct thread *thread,
 		}
 	} else if (thread_stack__in_kernel(ts) && ip < ks) {
 		/* Return to userspace, so pop all kernel addresses */
-		while (thread_stack__in_kernel(ts)) {
-			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							tm, ref, true);
-			if (err)
-				return err;
-		}
+		err = thread_stack__pop_ks(thread, ts, sample, ref);
+		if (err)
+			return err;
 	}
 
 	if (ts->cnt)
-- 
2.20.1


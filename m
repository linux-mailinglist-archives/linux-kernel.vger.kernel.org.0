Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77F79F01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 04:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfG3C5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 22:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731787AbfG3C5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:57:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04DE20578;
        Tue, 30 Jul 2019 02:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455451;
        bh=nVoF7HQDXKKom6WszyBiiO+d/fSfn94PtvavAI2lHww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wzbxM8aTKP7Y0Zl8QWMpFwFfmSiTBFVjnSJZyjraUs4dulHf1r1T12xySKXQDZTCj
         vhcDY0p52eVyBcwabpcrcwc9gCg4M7VIg2z0L+g1+kIapYrcdsFJxrum36D7OUrVAj
         tO4rAfBk1ijgkHdPqLgaF7kXnX5KP4W0ZUkers+M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 024/107] perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages
Date:   Mon, 29 Jul 2019 23:54:47 -0300
Message-Id: <20190730025610.22603-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are holes in syscall tables with IDs not associated with any
syscall, mark those when trying to read information for syscalls, which
could happen when iterating thru all syscalls from 0 to the highest
numbered syscall id.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cku9mpcrcsqaiq0jepu86r68@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5dae7b172291..765b998755ce 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -976,6 +976,7 @@ static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
  * args_size: sum of the sizes of the syscall arguments, anything after that is augmented stuff: pathname for openat, etc.
+ * nonexistent: Just a hole in the syscall table, syscall id not allocated
  */
 struct syscall {
 	struct tep_event    *tp_format;
@@ -987,6 +988,7 @@ struct syscall {
 	}		    bpf_prog;
 	bool		    is_exit;
 	bool		    is_open;
+	bool		    nonexistent;
 	struct tep_format_field *args;
 	const char	    *name;
 	struct syscall_fmt  *fmt;
@@ -1491,9 +1493,6 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
-	if (name == NULL)
-		return -EINVAL;
-
 	if (id > trace->syscalls.max) {
 		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
 
@@ -1512,8 +1511,15 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	sc = trace->syscalls.table + id;
-	sc->name = name;
+	if (sc->nonexistent)
+		return 0;
 
+	if (name == NULL) {
+		sc->nonexistent = true;
+		return 0;
+	}
+
+	sc->name = name;
 	sc->fmt  = syscall_fmt__find(sc->name);
 
 	snprintf(tp_name, sizeof(tp_name), "sys_enter_%s", sc->name);
@@ -1811,14 +1817,21 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 		return NULL;
 	}
 
+	err = -EINVAL;
+
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
 	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
-	err = -EINVAL;
-	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL))
+	if (id > trace->syscalls.max)
 		goto out_cant_read;
 
+	if (trace->syscalls.table[id].name == NULL) {
+		if (trace->syscalls.table[id].nonexistent)
+			return NULL;
+		goto out_cant_read;
+	}
+
 	return &trace->syscalls.table[id];
 
 out_cant_read:
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27679F00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 04:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfG3C5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 22:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731787AbfG3C53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:57:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C4B216C8;
        Tue, 30 Jul 2019 02:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455448;
        bh=EASSxj9sw+3zA2cPBdwt8kv9OFzKD98mWXpVd808xiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNnfvIKxgnUXWZIxRD0lHs4hczCOKB8aS0tRImLzYABlwxdVLPU0DWc/NAxI/uV+y
         O0mrSu9TteDs+R0N6CsfgMez+yCiNiGZFRUfYNjKaOev76wqx7dtfROyFCUnQyGcH3
         1XSXEfxX04lrHiVUNJ6t92IqHvtfEU7/tmrorBOk=
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
Subject: [PATCH 023/107] perf trace: Forward error codes when trying to read syscall info
Date:   Mon, 29 Jul 2019 23:54:46 -0300
Message-Id: <20190730025610.22603-24-acme@kernel.org>
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

We iterate thru the syscall table produced from the kernel syscall
tables reading info, propagate the error and add to the debug message.

This helps in fixing further bugs, such as failing to read the
"sendfile" syscall info when it really should try the aliasm
"sendfile64".

  Problems reading syscall 40: 2 (No such file or directory)(sendfile) information

  # grep sendfile /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
	[40] = "sendfile",
  #

I.e. in the tracefs format file for the syscall tracepoints we have it
as sendfile64:

  # find /sys -type f -name format | grep sendfile
  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile64/format
  /sys/kernel/debug/tracing/events/syscalls/sys_exit_sendfile64/format
  #

But as "sendfile" in the file used to build the syscall table used in
perf:

  $ grep sendfile arch/x86/entry/syscalls/syscall_64.tbl
  40	common	sendfile		__x64_sys_sendfile64
  $

So we need to add, in followup patches, aliases in 'perf trace' syscall
data structures to cope with thie.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w3eluap63x9je0bb8o3t79tz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d403b09812d1..5dae7b172291 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1492,13 +1492,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
 	if (name == NULL)
-		return -1;
+		return -EINVAL;
 
 	if (id > trace->syscalls.max) {
 		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
 
 		if (nsyscalls == NULL)
-			return -1;
+			return -ENOMEM;
 
 		if (trace->syscalls.max != -1) {
 			memset(nsyscalls + trace->syscalls.max + 1, 0,
@@ -1525,10 +1525,10 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ? 6 : sc->tp_format->format.nr_fields))
-		return -1;
+		return -ENOMEM;
 
 	if (IS_ERR(sc->tp_format))
-		return -1;
+		return PTR_ERR(sc->tp_format);
 
 	sc->args = sc->tp_format->format.fields;
 	/*
@@ -1789,6 +1789,7 @@ typedef int (*tracepoint_handler)(struct trace *trace, struct perf_evsel *evsel,
 static struct syscall *trace__syscall_info(struct trace *trace,
 					   struct perf_evsel *evsel, int id)
 {
+	int err = 0;
 
 	if (id < 0) {
 
@@ -1811,9 +1812,10 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 	}
 
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
-	    trace__read_syscall_info(trace, id))
+	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
+	err = -EINVAL;
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL))
 		goto out_cant_read;
 
@@ -1821,7 +1823,8 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 
 out_cant_read:
 	if (verbose > 0) {
-		fprintf(trace->output, "Problems reading syscall %d", id);
+		char sbuf[STRERR_BUFSIZE];
+		fprintf(trace->output, "Problems reading syscall %d: %d (%s)", id, -err, str_error_r(-err, sbuf, sizeof(sbuf)));
 		if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
 			fprintf(trace->output, "(%s)", trace->syscalls.table[id].name);
 		fputs(" information\n", trace->output);
-- 
2.21.0


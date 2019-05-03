Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FE12578
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 02:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfECAZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 20:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfECAZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:25:56 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C782089E;
        Fri,  3 May 2019 00:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843154;
        bh=ySAy76dzbgtboTYkItlDEq6m/M3wGWhPi51WWm8Q7ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijJiP/dAjhYRzI67vaRO8JQPSg6lLbYHCyLsgI3NOprbqvWOVQjwMoI1fRweGvqx7
         ZMQyApFsRAn0OZ2ZRQfb0QUvJrQdbFzvVXOq51+gpStRmt+NVd5b0zm2o5abXlLt12
         Qh6EngcB9mET5S5YX5HTa05FAy1jt2etvWSdTJLM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/11] perf annotate: Fix build on 32 bit for BPF annotation
Date:   Thu,  2 May 2019 20:25:25 -0400
Message-Id: <20190503002533.29359-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Commit 6987561c9e86 ("perf annotate: Enable annotation of BPF programs") adds
support for BPF programs annotations but the new code does not build on 32-bit.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Acked-by: Song Liu <songliubraving@fb.com>
Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
Link: http://lkml.kernel.org/r/20190403194452.10845-1-cascardo@canonical.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c8b01176c9e1..09762985c713 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1714,8 +1714,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
 		return -1;
 
-	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
-		 sym->name, sym->start, sym->end - sym->start);
+	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
+		  sym->name, sym->start, sym->end - sym->start);
 
 	memset(tpath, 0, sizeof(tpath));
 	perf_exe(tpath, sizeof(tpath));
@@ -1740,7 +1740,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	info_linear = info_node->info_linear;
 	sub_id = dso->bpf_prog.sub_id;
 
-	info.buffer = (void *)(info_linear->info.jited_prog_insns);
+	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
 	info.buffer_length = info_linear->info.jited_prog_len;
 
 	if (info_linear->info.nr_line_info)
@@ -1776,7 +1776,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		const char *srcline;
 		u64 addr;
 
-		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
+		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
 		count = disassemble(pc, &info);
 
 		if (prog_linfo)
-- 
2.20.1


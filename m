Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11989DB26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 03:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfH0BhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 21:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfH0BhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F4CB21872;
        Tue, 27 Aug 2019 01:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869832;
        bh=9vRfG2MIh0GfanQEmqv1QvA+MIKQYxd5YRT6jcYiI4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeBgT9RAsf2/i3YkcZKuftgjJx+b/gRjFhx6ijKv2BENzc0tnSegKRvkWh4/fVkc1
         I/tnL2I41i2d0a6DNmQCYc7YclccLxa28G5tev1D5k/tGuCnd4V0WFjDCwyuZQoAOk
         ffkRSbiV8jIZsuhwl6OqyHJutta0zyp6g6+f9Fm8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/33] perf augmented_raw_syscalls: Postpone tmp map lookup to after pid_filter
Date:   Mon, 26 Aug 2019 22:36:11 -0300
Message-Id: <20190827013634.3173-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No sense in doing that lookup before figuring out if it will be used,
i.e. if the pid is being filtered that tmp space lookup will be useless.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o74yggieorucfg4j74tb6rta@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index b85b177c6726..0a8d217d65c7 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -250,13 +250,13 @@ int sys_enter(struct syscall_enter_args *args)
 	struct syscall *syscall;
 	int key = 0;
 
+	if (pid_filter__has(&pids_filtered, getpid()))
+		return 0;
+
         augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
         if (augmented_args == NULL)
                 return 1;
 
-	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
-
 	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
 
 	/*
-- 
2.21.0


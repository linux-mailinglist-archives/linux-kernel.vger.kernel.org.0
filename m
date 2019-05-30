Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848532FC58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfE3N3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 09:29:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35933 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfE3N3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:29:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so2584540plr.3;
        Thu, 30 May 2019 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MKbB7PTDLyUPgE5LxpgYdWEo36N/ezyeckgzW0tkbcQ=;
        b=KZICn+MNu+poaBOe9RL+jAsJOYKwlZroU8gM9qXOm1buylOI+ckaGSCpzu0HAaZ1fz
         eH6NacBTzFYqNbNgQCqvLz3oKYb8KtNvkIRUPB3uhyTwrRXB9amGji94WnqVJzygJtxU
         vdC83UACQ6cZtj2kTM4c4gFm6DXUtgehocpSmHR4XvER2I1cifLjzY7nUg8EavsiS6Df
         I73uRU7gI1pq5i920VU/aEEubl4vJnSCjuomNzU5M2egUB5Di4lsCv5yoAYYx8B846FB
         8YJWDZt3wvR+rGF3RfYhayUDndQeGB0fpPxmiyySLoLpocDWDnnLNHSNZUL+Zj1RyxBW
         O0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MKbB7PTDLyUPgE5LxpgYdWEo36N/ezyeckgzW0tkbcQ=;
        b=t3O4O1QSePU8LHThDslro5iH1XV73cG/HcWqjJtzb9H1bG9uOQNpa3oIFG2t3gBUls
         V6qWeebWFPIk5DT59ZX+h7jFkB/s9Uukrlo4867+vHlyrDrDEtOoMlP3cYQYWqpsYx2s
         d/9960fOX/bvhDqs9RyIebPnvQsG/HM3CXT0Ldo2a9Dv4aiPc4nzptqlbB2G8QHrpGjs
         hbSVV0fG64pCMtHr85BE4PgPX1SRzIOkY5snZDUvOjYGSLyMs2aUyjrjIh2yNQHtc40V
         IfDD4JVuoM1z6IsBltKCuxdXLruCE+2Ks+M+aDGQqgXWL0nLZ75ChpKr4WNAcPy74mMJ
         C/MQ==
X-Gm-Message-State: APjAAAWxa6JAHgtv+Xv7rFgosiseM7pmFNw4Cfc8rK4g5ac2aR4r6Ld6
        U2OwLwA+5P/QXAx9a/nGbIo=
X-Google-Smtp-Source: APXvYqyd7YiO3Ny5IPDNTGCQIaW42td9HCoDVpD98+8Zf/7AAlJG29s6U+Z3tA2vUib7HazFDmcKbg==
X-Received: by 2002:a17:902:2869:: with SMTP id e96mr3613687plb.203.1559222988499;
        Thu, 30 May 2019 06:29:48 -0700 (PDT)
Received: from node5.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id a5sm1402442pjo.29.2019.05.30.06.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 06:29:47 -0700 (PDT)
From:   ufo19890607 <ufo19890607@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com,
        arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com,
        adrian.hunter@intel.com, wangnan0@huawei.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Subject: [PATCH] perf record: Add support to collect callchains from kernel or user space only.
Date:   Thu, 30 May 2019 14:29:22 +0100
Message-Id: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

One can just record callchains in the kernel or user space with
this new options. We can use it together with "--all-kernel" options.
This two options is used just like print_stack(sys) or print_ustack(usr)
for systemtap.

Show below is the usage of this new option combined with "--all-kernel"
options.
	1. Configure all used events to run in kernel space and just
collect kernel callchains.
	$ perf record -a -g --all-kernel --kernel-callchains
	2. Configure all used events to run in kernel space and just
collect user callchains.
	$ perf record -a -g --all-kernel --user-callchains

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/Documentation/perf-record.txt | 6 ++++++
 tools/perf/builtin-record.c              | 4 ++++
 tools/perf/perf.h                        | 2 ++
 tools/perf/util/evsel.c                  | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index de269430720a..b647eb3db0c6 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -490,6 +490,12 @@ Configure all used events to run in kernel space.
 --all-user::
 Configure all used events to run in user space.
 
+--kernel-callchains::
+Collect callchains from kernel space.
+
+--user-callchains::
+Collect callchains from user space.
+
 --timestamp-filename
 Append timestamp to output file name.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e2c3a585a61e..dca55997934e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2191,6 +2191,10 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN_FLAG(0, "all-user", &record.opts.all_user,
 			 "Configure all used events to run in user space.",
 			 PARSE_OPT_EXCLUSIVE),
+	OPT_BOOLEAN(0, "kernel-callchains", &record.opts.kernel_callchains,
+		    "collect kernel callchains"),
+	OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
+		    "collect user callchains"),
 	OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
 		   "clang binary to use for compiling BPF scriptlets"),
 	OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options",
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index d59dee61b64d..711e009381ec 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -61,6 +61,8 @@ struct record_opts {
 	bool	     record_switch_events;
 	bool	     all_kernel;
 	bool	     all_user;
+	bool	     kernel_callchains;
+	bool	     user_callchains;
 	bool	     tail_synthesize;
 	bool	     overwrite;
 	bool	     ignore_missing_thread;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a6f572a40deb..a606b2833e27 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -680,6 +680,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 
 	attr->sample_max_stack = param->max_stack;
 
+	if (opts->kernel_callchains)
+		attr->exclude_callchain_user = 1;
+	if (opts->user_callchains)
+		attr->exclude_callchain_kernel = 1;
 	if (param->record_mode == CALLCHAIN_LBR) {
 		if (!opts->branch_stack) {
 			if (attr->exclude_user) {
-- 
2.14.1


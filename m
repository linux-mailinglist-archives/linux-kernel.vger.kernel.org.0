Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C370166C82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 02:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgBUBxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 20:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgBUBxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:53:22 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E306D24676;
        Fri, 21 Feb 2020 01:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582250001;
        bh=Ls6pzCNaJlTzXCYlHSca7gXFY+UWtFyhfRTt9OG8pYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skNfC2PuwrW2VmBPfjomb/QgTYNY9YJcPguvObSIL8K1OmXmLVi2NJ9GJTYjGkn+R
         XIQslf1NDhI+gREVQqHQoogqev+kuxCKEWq+EQ4tqXMFoYwzAYxZUMM96A8TDV7sEJ
         FtZk3FwMFQgrOU8PUG1HBareX2FXydaOQ+RLSjhk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/8] perf bpf: Remove bpf/ subdir from bpf.h headers used to build bpf events
Date:   Thu, 20 Feb 2020 22:53:03 -0300
Message-Id: <20200221015310.16914-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221015310.16914-1-acme@kernel.org>
References: <20200221015310.16914-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The bpf.h file needed gets installed in /usr/lib/include/perf/bpf/bpf.h,
and /usr/lib/include/perf/ is added to the include path passed to clang
to build the eBPF bytecode, so just remove "bpf/", its directly in the
path passed already. This was working by accident, fix it.

I.e. now this is back working:

  # cat /home/acme/git/perf/tools/perf/examples/bpf/hello.c
  #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
  	puts("Hello, world\n");
  	return 0;
  }

  license(GPL);
  # perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/hello.c
       0.000 pickup/21493 __bpf_stdout__(Hello, world)
      56.462 sh/13539 __bpf_stdout__(Hello, world)
      56.536 sh/13539 __bpf_stdout__(Hello, world)
      56.673 sh/13539 __bpf_stdout__(Hello, world)
      56.781 sh/13539 __bpf_stdout__(Hello, world)
      56.707 perf/13182 __bpf_stdout__(Hello, world)
      56.849 perf/13182 __bpf_stdout__(Hello, world)
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-d9myswhgo8gfi3vmehdqpxa7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/pid_filter.h | 2 +-
 tools/perf/include/bpf/stdio.h      | 2 +-
 tools/perf/include/bpf/unistd.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
index 607189a315b2..6e61c4bdf548 100644
--- a/tools/perf/include/bpf/pid_filter.h
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -3,7 +3,7 @@
 #ifndef _PERF_BPF_PID_FILTER_
 #define _PERF_BPF_PID_FILTER_
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 #define pid_filter(name) pid_map(name, bool)
 
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 7ca6fa5463ee..316af5b2ff35 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 struct bpf_map SEC("maps") __bpf_stdout__ = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
index d1a35b6c649d..ca7877f9a976 100644
--- a/tools/perf/include/bpf/unistd.h
+++ b/tools/perf/include/bpf/unistd.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
 
-- 
2.21.1


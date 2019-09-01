Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE35A492A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 14:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfIAMYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 08:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfIAMY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F25D2342E;
        Sun,  1 Sep 2019 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340667;
        bh=p5cK7tiPFTFPs4USBn355x3AfM7qbi1GJWko6MJHUG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt7+kpfUEi7kw1+ptkKkGC9JxZx9VYfOpoZrCRdMZATlKF1bFWMD8xgQlRLtVGgds
         pKUPgJJJtHUuSLDuL2YcGKBfCixqezXkpDCEMY68FCKdmLcKXRZcwRxLD43pi3duad
         vf6zByoTnbGM9g6YPTNWj/Wd6Qg7DhQYWcheRLrk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/47] perf env: Remove env.h from other headers where just a fwd decl is needed
Date:   Sun,  1 Sep 2019 09:22:56 -0300
Message-Id: <20190901122326.5793-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And fixup the fallout of c files not building due to now missing
headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-sw8k3kpla98pr3rqypbjk9hf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/common.h    | 4 +++-
 tools/perf/tests/mem2node.c | 2 ++
 tools/perf/util/cputopo.h   | 1 -
 tools/perf/util/mem2node.c  | 2 ++
 tools/perf/util/mem2node.h  | 3 ++-
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/common.h b/tools/perf/arch/common.h
index c298a446d1f6..e965ed8bb328 100644
--- a/tools/perf/arch/common.h
+++ b/tools/perf/arch/common.h
@@ -2,7 +2,9 @@
 #ifndef ARCH_PERF_COMMON_H
 #define ARCH_PERF_COMMON_H
 
-#include "../util/env.h"
+#include <stdbool.h>
+
+struct perf_env;
 
 int perf_env__lookup_objdump(struct perf_env *env, const char **path);
 bool perf_env__single_address_space(struct perf_env *env);
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 73b2855acaf4..7672ade70f20 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <linux/bitmap.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
 #include "cpumap.h"
 #include "debug.h"
+#include "env.h"
 #include "mem2node.h"
 #include "tests.h"
 
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index bae2f1d41856..7bf6b811f715 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -3,7 +3,6 @@
 #define __PERF_CPUTOPO_H
 
 #include <linux/types.h>
-#include "env.h"
 
 struct cpu_topology {
 	u32	  core_sib;
diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
index 14fb9e72aeeb..797d86a1ab09 100644
--- a/tools/perf/util/mem2node.c
+++ b/tools/perf/util/mem2node.c
@@ -1,8 +1,10 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/bitmap.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include "debug.h"
+#include "env.h"
 #include "mem2node.h"
 
 struct phys_entry {
diff --git a/tools/perf/util/mem2node.h b/tools/perf/util/mem2node.h
index 59c4752a2181..8dfa2b58d0cd 100644
--- a/tools/perf/util/mem2node.h
+++ b/tools/perf/util/mem2node.h
@@ -2,8 +2,9 @@
 #define __MEM2NODE_H
 
 #include <linux/rbtree.h>
-#include "env.h"
+#include <linux/types.h>
 
+struct perf_env;
 struct phys_entry;
 
 struct mem2node {
-- 
2.21.0


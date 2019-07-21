Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE16F2D9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGUL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfGUL2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 996143082A98;
        Sun, 21 Jul 2019 11:28:14 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BB995D9D3;
        Sun, 21 Jul 2019 11:28:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 24/79] libperf: Add build version support
Date:   Sun, 21 Jul 2019 13:24:11 +0200
Message-Id: <20190721112506.12306-25-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 21 Jul 2019 11:28:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding shared library version, generating following files:

  $ ll toos/perf/lib/libperf.so*
  libperf.so -> libperf.so.0.0.1
  libperf.so.0 -> libperf.so.0.0.1
  libperf.so.0.0.1

Link: http://lkml.kernel.org/n/tip-d2cnt8qoqc5nxiibvzvuw6ir@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Makefile    | 20 +++++++++++++++++---
 tools/perf/lib/libperf.map |  4 ++++
 2 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/lib/libperf.map

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index e6f2eb702aaa..25a6476f8b12 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Most of this file is copied from tools/lib/bpf/Makefile
 
+LIBPERF_VERSION = 0
+LIBPERF_PATCHLEVEL = 0
+LIBPERF_EXTRAVERSION = 1
+
 MAKEFLAGS += --no-print-directory
 
 ifeq ($(srctree),)
@@ -47,7 +51,13 @@ all:
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-LIBPERF_SO := $(OUTPUT)libperf.so
+VERSION_SCRIPT := libperf.map
+
+PATCHLEVEL    = $(LIBPERF_PATCHLEVEL)
+EXTRAVERSION  = $(LIBPERF_EXTRAVERSION)
+VERSION       = $(LIBPERF_VERSION).$(LIBPERF_PATCHLEVEL).$(LIBPERF_EXTRAVERSION)
+
+LIBPERF_SO := $(OUTPUT)libperf.so.$(VERSION)
 LIBPERF_A  := $(OUTPUT)libperf.a
 LIBPERF_IN := $(OUTPUT)libperf-in.o
 
@@ -58,7 +68,11 @@ $(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
 
 $(LIBPERF_SO): $(LIBPERF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so $^ -o $@
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
+                                    -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libperf.so
+	@ln -sf $(@F) $(OUTPUT)libperf.so.$(LIBPERF_VERSION)
+
 
 libs: $(LIBPERF_A) $(LIBPERF_SO)
 
@@ -67,7 +81,7 @@ all: fixdep
 
 clean:
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
-                *.o *~ *.a *.so .*.d .*.cmd LIBPERF-CFLAGS
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS
 
 FORCE:
 
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
new file mode 100644
index 000000000000..a8e913988edf
--- /dev/null
+++ b/tools/perf/lib/libperf.map
@@ -0,0 +1,4 @@
+LIBPERF_0.0.1 {
+	local:
+		*;
+};
-- 
2.21.0


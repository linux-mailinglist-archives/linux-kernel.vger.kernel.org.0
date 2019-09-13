Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9AB209D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391160AbfIMNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 09:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391144AbfIMNYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:24:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB2473061424;
        Fri, 13 Sep 2019 13:24:23 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1156F5C1D4;
        Fri, 13 Sep 2019 13:24:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 09/73] libperf: Link libapi.a in libperf.so
Date:   Fri, 13 Sep 2019 15:22:51 +0200
Message-Id: <20190913132355.21634-10-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 13 Sep 2019 13:24:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linking libapi.a in libperf.so, because we are about
to use some of the api functions in it.

Link: http://lkml.kernel.org/n/tip-a31mqxtuket2y8sdn7un7dka@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Makefile | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index e325c0503dc6..54466cc84544 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -59,7 +59,13 @@ else
   CFLAGS := -g -Wall
 endif
 
-INCLUDES = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/ -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
+INCLUDES = \
+-I$(srctree)/tools/perf/lib/include \
+-I$(srctree)/tools/lib/ \
+-I$(srctree)/tools/include \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/ \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
+-I$(srctree)/tools/include/uapi
 
 # Append required CFLAGS
 override CFLAGS += $(EXTRA_WARNINGS)
@@ -88,13 +94,34 @@ LIBPERF_PC := $(OUTPUT)libperf.pc
 
 LIBPERF_ALL := $(LIBPERF_A) $(OUTPUT)libperf.so*
 
+LIB_DIR := $(srctree)/tools/lib/api/
+
+ifneq ($(OUTPUT),)
+ifneq ($(subdir),)
+  API_PATH=$(OUTPUT)/../lib/api/
+else
+  API_PATH=$(OUTPUT)
+endif
+else
+  API_PATH=$(LIB_DIR)
+endif
+
+LIBAPI = $(API_PATH)libapi.a
+
+$(LIBAPI): FORCE
+	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
+
+$(LIBAPI)-clean:
+	$(call QUIET_CLEAN, libapi)
+	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
+
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
 $(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
 
-$(LIBPERF_SO): $(LIBPERF_IN)
+$(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
                                     -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
 	@ln -sf $(@F) $(OUTPUT)libperf.so
@@ -106,7 +133,7 @@ libs: $(LIBPERF_A) $(LIBPERF_SO) $(LIBPERF_PC)
 all: fixdep
 	$(Q)$(MAKE) libs
 
-clean:
+clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd LIBPERF-CFLAGS $(LIBPERF_PC)
 	$(Q)$(MAKE) -C tests clean
-- 
2.21.0


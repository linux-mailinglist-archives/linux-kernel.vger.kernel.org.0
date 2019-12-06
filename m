Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF86115199
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 14:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLFNzb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Dec 2019 08:55:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbfLFNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:55:26 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-irBnFsKINz-hy3RrghuPXw-1; Fri, 06 Dec 2019 08:55:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDDAB8017DF;
        Fri,  6 Dec 2019 13:55:20 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F80F67156;
        Fri,  6 Dec 2019 13:55:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 2/3] libperf: Additional fixes
Date:   Fri,  6 Dec 2019 14:55:12 +0100
Message-Id: <20191206135513.31586-3-jolsa@kernel.org>
In-Reply-To: <20191206135513.31586-1-jolsa@kernel.org>
References: <20191206135513.31586-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: irBnFsKINz-hy3RrghuPXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing various paths (mainly include) to reflect the
libperf move under separate directory and adding new
directory under MANIFEST.

Link: https://lkml.kernel.org/n/tip-5sw076568tnrery8vpd7u8yo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Makefile       | 2 +-
 tools/lib/perf/tests/Makefile | 2 +-
 tools/perf/MANIFEST           | 1 +
 tools/perf/Makefile.config    | 2 +-
 tools/perf/Makefile.perf      | 2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 0f233638ef1f..768dd423730b 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -60,7 +60,7 @@ else
 endif
 
 INCLUDES = \
--I$(srctree)/tools/perf/lib/include \
+-I$(srctree)/tools/lib/perf/include \
 -I$(srctree)/tools/lib/ \
 -I$(srctree)/tools/include \
 -I$(srctree)/tools/arch/$(SRCARCH)/include/ \
diff --git a/tools/lib/perf/tests/Makefile b/tools/lib/perf/tests/Makefile
index a43cd08c5c03..96841775feaf 100644
--- a/tools/lib/perf/tests/Makefile
+++ b/tools/lib/perf/tests/Makefile
@@ -16,7 +16,7 @@ all:
 
 include $(srctree)/tools/scripts/Makefile.include
 
-INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
+INCLUDE = -I$(srctree)/tools/lib/perf/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
 
 $(TESTS_A): FORCE
 	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index 70f1ff4e2eb4..ae2aab5b1be0 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -7,6 +7,7 @@ tools/lib/traceevent
 tools/lib/api
 tools/lib/bpf
 tools/lib/subcmd
+tools/lib/perf
 tools/lib/argv_split.c
 tools/lib/ctype.c
 tools/lib/hweight.c
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c90f4146e5a2..80e55e796be9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -286,7 +286,7 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-INC_FLAGS += -I$(src-perf)/lib/include
+INC_FLAGS += -I$(srctree)/tools/lib/perf/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
 INC_FLAGS += -I$(srctree)/tools/include/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index eae5d5e95952..3eda9d4b88e7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -230,7 +230,7 @@ LIB_DIR         = $(srctree)/tools/lib/api/
 TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 BPF_DIR         = $(srctree)/tools/lib/bpf/
 SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
-LIBPERF_DIR     = $(srctree)/tools/perf/lib/
+LIBPERF_DIR     = $(srctree)/tools/lib/perf/
 
 # Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
 # Without this setting the output feature dump file misses some features, for
-- 
2.21.0


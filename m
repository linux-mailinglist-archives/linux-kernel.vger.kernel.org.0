Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470EED6678
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfJNPtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 11:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfJNPtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:49:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 282BB3079B77;
        Mon, 14 Oct 2019 15:49:00 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF88D5D9C9;
        Mon, 14 Oct 2019 15:48:57 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf jvmti: Link in tools/lib/ctype.o
Date:   Mon, 14 Oct 2019 17:48:56 +0200
Message-Id: <20191014154856.25306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 14 Oct 2019 15:49:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The libperf-jvmti.so links already with tools/lib/string.o
to use strlcpy. However the string.o depends on ctype.o
so we need to link it in as well.

Fixes: 79743bc927f6 ("perf jvmti: Link against tools/lib/string.o to have weak strlcpy()")
Link: http://lkml.kernel.org/n/tip-zitavtnkcu2guqwfgtp7n7bg@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/jvmti/Build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index 1e148bbdf820..7de7f90bf3fb 100644
--- a/tools/perf/jvmti/Build
+++ b/tools/perf/jvmti/Build
@@ -3,6 +3,7 @@ jvmti-y += jvmti_agent.o
 
 # For strlcpy
 jvmti-y += libstring.o
+jvmti-y += libctype.o
 
 CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
 CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
@@ -15,3 +16,7 @@ CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PE
 $(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
-- 
2.21.0


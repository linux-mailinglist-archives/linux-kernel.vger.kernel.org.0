Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8409A497B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfIAMse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 08:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbfIAMsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8720C10A8138;
        Sun,  1 Sep 2019 12:48:32 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C841600CE;
        Sun,  1 Sep 2019 12:48:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 3/4] perf tests: Add libperf automated test
Date:   Sun,  1 Sep 2019 14:48:21 +0200
Message-Id: <20190901124822.10132-4-jolsa@kernel.org>
In-Reply-To: <20190901124822.10132-1-jolsa@kernel.org>
References: <20190901124822.10132-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Sun, 01 Sep 2019 12:48:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding libperf build test.

Link: http://lkml.kernel.org/n/tip-r1be6tz02ay0bf2729a7xwjk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/make | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 17ee3facfd4d..128a0d801ac1 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -327,6 +327,10 @@ make_kernelsrc_tools:
 	(make -C ../../tools $(PARALLEL_OPT) $(K_O_OPT) perf) > $@ 2>&1 && \
 	test -x $(KERNEL_O)/tools/perf/perf && rm -f $@ || (cat $@ ; false)
 
+make_libperf:
+	@echo "- make -C lib";
+	make -C lib clean >$@ 2>&1; make -C lib >>$@ 2>&1 && rm $@
+
 FEATURES_DUMP_FILE := $(FULL_O)/BUILD_TEST_FEATURE_DUMP
 FEATURES_DUMP_FILE_STATIC := $(FULL_O)/BUILD_TEST_FEATURE_DUMP_STATIC
 
@@ -365,5 +369,5 @@ $(foreach t,$(run),$(if $(findstring make_static,$(t)),\
 			$(eval $(t) := $($(t)) FEATURES_DUMP=$(FEATURES_DUMP_FILE))))
 endif
 
-.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools
+.PHONY: all $(run) $(run_O) tarpkg clean make_kernelsrc make_kernelsrc_tools make_libperf
 endif # ifndef MK
-- 
2.21.0


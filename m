Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914F7B922E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 16:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfITO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 10:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388850AbfITOZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:25:58 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB8F20882;
        Fri, 20 Sep 2019 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989557;
        bh=8tS2cpwMnR0yGFuX3AlIQxRUJKM+LfMuo4w3GtTG5DY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qLax+rHaht1EK7zfl3mIRR7xQ4HIaqBXqaq8q/9iQDFAYDrQKzuRSyDTfGCv4qgu
         Rrf5ttfJf6f8IFC2HTVSmajknXDwCBnjQG9bJYUMIHgYgWr40JXy9p8BawN4QOvO3t
         Ku425EBLmaq6T/NpYVPCrJPv0cYiriHk0NroBE00=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/31] perf tests: Add libperf automated test for 'make -C tools/perf build-test'
Date:   Fri, 20 Sep 2019 11:25:13 -0300
Message-Id: <20190920142542.12047-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a libperf build test, that is triggered when one does:

  $ make -C tools/perf build-test

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190901124822.10132-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 70c48475896d..6b3afed5d910 100644
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


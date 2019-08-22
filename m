Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCD9A199
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfHVVCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393410AbfHVVCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:05 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78784233FC;
        Thu, 22 Aug 2019 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507724;
        bh=by3Yem3DYDU8JqS7nvUHadRGFGvLAmeOxIZebxIL35Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONOpNzsl8QVgeIo4J2Cr7Yw30Pgfr+yOheKGlWpDpV+P5OQYbQmayHyKlhl4Z+fTu
         Cc+cVy3RJ5D1yJoydfVLZKjJlJF/id/afGbVF0u96iCmavTYt+3eLm7LMhExsQtb1v
         VWsNpBPC2DqPTRbxgQs2WGDi7ADGYWXK7uV9Pvhs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 13/25] perf tests: Add missing counts.h
Date:   Thu, 22 Aug 2019 18:00:48 -0300
Message-Id: <20190822210100.3461-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those are getting counts.h via evsel.h, that don't strictly need
counts.h, just forward declarations for some structs, so add it here
before we remove it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-phldqlfxxu563txja7evd4zt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 1 +
 tools/perf/tests/openat-syscall.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 8322b6aa4047..4ae4dea07466 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -16,6 +16,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "stat.h"
+#include "util/counts.h"
 
 int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index f217972977e0..58df4bda5e12 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -10,6 +10,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "tests.h"
+#include "util/counts.h"
 
 int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077CBB9210
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 16:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbfITO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 10:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389196AbfITO0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1190E207E0;
        Fri, 20 Sep 2019 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989599;
        bh=s/zzqvnkdrBxTvqrJeqRQDqjCgs9sjCek//ExdgDSJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fK/7PJurClGhFWLlFtaeE4gH98o8kkiTdrjBdxgjthqVfM0aubO46bHDotET9z/1m
         pdEs9T5KFrCE2OQiS0pyUyIRHRp9yPeAc0uV5rut6POuIYX4yh9D7xNUov5nNV2ZXK
         QuG6PjDqe5YLGQ8/tsd6sCwdtr4bbk3WRoupBGj0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/31] perf python: Remove debug.h
Date:   Fri, 20 Sep 2019 11:25:28 -0300
Message-Id: <20190920142542.12047-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We only need to have the prototype for the eprintf() replacement we use
in the python binding, provide it and avoid dragging debug.h as a
dependency.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-s0gy4ur3drmhsknsddwjco59@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 96dd3333c911..0ba19dd75510 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -6,7 +6,6 @@
 #include <linux/err.h>
 #include <perf/cpumap.h>
 #include <traceevent/event-parse.h>
-#include "debug.h"
 #include "evlist.h"
 #include "callchain.h"
 #include "evsel.h"
@@ -60,6 +59,8 @@ int parse_callchain_record(const char *arg __maybe_unused,
  */
 int verbose;
 
+int eprintf(int level, int var, const char *fmt, ...);
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 	va_list args;
-- 
2.21.0


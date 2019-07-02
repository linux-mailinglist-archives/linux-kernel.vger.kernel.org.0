Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4625C738
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfGBC1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfGBC1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A422173E;
        Tue,  2 Jul 2019 02:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034451;
        bh=VxXLcuX2g5OoRfNrCUAXFT4E0SI6ydIeu4vtBMqTUuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+f0EIQm0VN6+15pKZQSsEDFkNT7Yb3YNr5YhQUUCuUKZ5LBmECYejJLGONdH/2g8
         xEksE2OJZkjMzs1qal9KmLTrWEQhIO2Vy3MvFESzXYYZiQLMXKH9EbzXMtkwNbt6xX
         5AfDYtn2k/XJZhrHPooq3YRNFhCiKUS8PhRQcs4g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 22/43] perf tools: Use linux/ctype.h in more places
Date:   Mon,  1 Jul 2019 23:25:55 -0300
Message-Id: <20190702022616.1259-23-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There were a few places where we still were using the libc version of
ctype.h, switch to the one in tools/lib/ctype.c that the rest of perf
uses.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wa4nz4kt61eze88eprk20tfd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/header.c | 2 +-
 tools/perf/util/metricgroup.c      | 2 +-
 tools/perf/util/time-utils.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index 3db85cd2069e..a25896135abe 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -11,7 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <string.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 #include "../../util/header.h"
 #include "../../util/util.h"
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 699e020737d9..a0cf3cd95ced 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -17,7 +17,7 @@
 #include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct perf_evsel *evsel,
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 2b48816a2d2e..369fa19dd596 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -7,7 +7,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
-#include <ctype.h>
+#include <linux/ctype.h>
 
 #include "perf.h"
 #include "debug.h"
-- 
2.20.1


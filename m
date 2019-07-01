Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8757E3D658
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407304AbfFKTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405412AbfFKTEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38BC2184B;
        Tue, 11 Jun 2019 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279872;
        bh=Q1atFUoQS2pRqri6DZIJ1w4j3BQXi1mYeMgS2dJtx/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tetL2HuAuG0wuowwfXIfCT+hdfOcPHuI2Rp4WSk8mShBaFbF3N/1tNHM1CprbMPdB
         n5kwIJOJKLYgey320dnW/iI1Ehb264nSovOuRMxh31qTnwg/cdJ8Yyi2o4ygoBhAX2
         laY9MI0I4fqleRrvMgBUAv4AQD8jFlPXfJx34cG0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 74/85] perf time-utils: Treat time ranges consistently
Date:   Tue, 11 Jun 2019 15:59:00 -0300
Message-Id: <20190611185911.11645-75-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Currently, options allow only 1 explicit (non-percentage) time range.
In preparation for adding support for multiple explicit time ranges,
treat time ranges consistently.

Instead of treating some time ranges as inclusive and some as excluding
the end time, treat all time ranges as inclusive. This is only a 1
nanosecond change but is necessary to treat multiple explicit time
ranges in a consistent manner.

Note, there is a later patch that adds a test for time-utils.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 20663a460df3..1d67cf1216c7 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -389,13 +389,12 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 		ptime = &ptime_buf[i];
 
 		if (timestamp >= ptime->start &&
-		    ((timestamp < ptime->end && i < num - 1) ||
-		     (timestamp <= ptime->end && i == num - 1))) {
-			break;
+		    (timestamp <= ptime->end || !ptime->end)) {
+			return false;
 		}
 	}
 
-	return (i == num) ? true : false;
+	return true;
 }
 
 int perf_time__parse_for_ranges(const char *time_str,
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692123D65A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407328AbfFKTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407312AbfFKTEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BE1521872;
        Tue, 11 Jun 2019 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279879;
        bh=kKzgPGyp1rFRUoMeCAbqGywocjRtjiVE1tkm510zKkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jc6EyRQ0aCx+K96v6C5S6lAnLRdisZNqrZwTnVzVh0qlljoLetRseYHt/joUk74rB
         jT698RKvsg0wI7VaLQmtTULx/5C1M18copSjfdD/Wx6bMtfcf4B0ShAjXpI7/WkmJq
         U/BeZ4aqTB8DhMQKnLq6m1q/kjPoSeHvOOUz25EY=
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
Subject: [PATCH 76/85] perf time-utils: Prevent percentage time range overlap
Date:   Tue, 11 Jun 2019 15:59:02 -0300
Message-Id: <20190611185911.11645-77-acme@kernel.org>
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

Prevent percentage time range overlap. This is only a 1 nanosecond
change but makes the results more logical e.g. a sample cannot be in
both the first 10% and the second 20%.

Note, there is a later patch that adds a test for time-utils.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 69441faab3d0..3e87c21c293c 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -148,6 +148,9 @@ static int set_percent_time(struct perf_time_interval *ptime, double start_pcnt,
 	ptime->start = start + round(start_pcnt * total);
 	ptime->end = start + round(end_pcnt * total);
 
+	if (ptime->end > ptime->start && ptime->end != end)
+		ptime->end -= 1;
+
 	return 0;
 }
 
-- 
2.20.1


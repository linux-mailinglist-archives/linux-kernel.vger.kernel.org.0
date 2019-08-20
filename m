Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287BA96969
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfHTT2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 15:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbfHTT2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:15 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA277230F2;
        Tue, 20 Aug 2019 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329295;
        bh=8hxSSt4ABaCovEYDd6K+BZw0tuWiuJTzE9Vsc0Y+4t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXQgTQgWkxIq9Mc+w/QTXTBeVLqbXU6NGewcg66bUvXo8iCeHZXXeuVUDabe8+EU7
         uXnSpwOHVg4d09x9Mgim4i/5uQ0oJFalY3SkBRyGOUyv1MQV3NV6HODuzevgzm0U3F
         BdYt6Di1nh3XFX/FwZDbFGd79jUr2M+Q7MY+1Vrw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/17] perf evsel: Add comment for 'idx' member in 'struct perf_sample_id
Date:   Tue, 20 Aug 2019 16:27:22 -0300
Message-Id: <20190820192733.19180-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The 'idx' member was added as preparation for AUX area sampling. Add a
comment to describe why.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/83ff264f-84c3-5372-8976-dd9293d20c6f@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9cd6e3ae479a..efe08065838f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -23,6 +23,13 @@ struct perf_sample_id {
 	struct hlist_node 	node;
 	u64		 	id;
 	struct evsel		*evsel;
+       /*
+	* 'idx' will be used for AUX area sampling. A sample will have AUX area
+	* data that will be queued for decoding, where there are separate
+	* queues for each CPU (per-cpu tracing) or task (per-thread tracing).
+	* The sample ID can be used to lookup 'idx' which is effectively the
+	* queue number.
+	*/
 	int			idx;
 	int			cpu;
 	pid_t			tid;
-- 
2.21.0


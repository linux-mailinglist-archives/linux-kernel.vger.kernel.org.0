Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1702BA03DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfH1N5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfH1N5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5F4D8980E7;
        Wed, 28 Aug 2019 13:57:48 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D0B61001B00;
        Wed, 28 Aug 2019 13:57:46 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 13/23] libperf: Add PERF_RECORD_SWITCH 'struct context_switch_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:07 +0200
Message-Id: <20190828135717.7245-14-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 28 Aug 2019 13:57:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_SWITCH event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-hduuqm2bnzbxhhoynf2x3d3q@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 6 ++++++
 tools/perf/util/event.h             | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3bcbc1eaeb35..a7b0344bb8b4 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -110,6 +110,12 @@ struct perf_record_sample {
 	__u64			 array[];
 };
 
+struct context_switch_event {
+	struct perf_event_header header;
+	__u32			 next_prev_pid;
+	__u32			 next_prev_tid;
+};
+
 struct attr_event {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f89e8ddadd46..012b2ba9a9a8 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,12 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct context_switch_event {
-	struct perf_event_header header;
-	u32 next_prev_pid;
-	u32 next_prev_tid;
-};
-
 struct thread_map_event_entry {
 	u64	pid;
 	char	comm[16];
-- 
2.21.0


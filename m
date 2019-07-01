Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7212BC20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfE0Wjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 18:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfE0Wjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:39:51 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A71420859;
        Mon, 27 May 2019 22:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996790;
        bh=ua6I4CLzAefT55wVsbJQWhe6NsT3WuAgTj2A2upB0No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr3C0E88d7EpsjFaXwQUHY6dpELFbBM42/ACMZrjgHXYmifwpkxZe6dwYd/ImHrPz
         AP+wGB3e3NrM4ZH/PpGQf0YmrmDibxquNF2gTkj1gSb+VrV66zk+qts78jk6vFArOk
         OsXq/2gV5X2ug4ft5tI/1gYWp9oB52d0ISy70I2M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/44] perf session: Add missing swap ops for namespace events
Date:   Mon, 27 May 2019 19:37:13 -0300
Message-Id: <20190527223730.11474-28-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

In case it's recorded in a different arch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com> <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: http://lkml.kernel.org/r/20190522053250.207156-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2310a1752983..54cf163347f7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -647,6 +647,26 @@ static void perf_event__throttle_swap(union perf_event *event,
 		swap_sample_id_all(event, &event->throttle + 1);
 }
 
+static void perf_event__namespaces_swap(union perf_event *event,
+					bool sample_id_all)
+{
+	u64 i;
+
+	event->namespaces.pid		= bswap_32(event->namespaces.pid);
+	event->namespaces.tid		= bswap_32(event->namespaces.tid);
+	event->namespaces.nr_namespaces	= bswap_64(event->namespaces.nr_namespaces);
+
+	for (i = 0; i < event->namespaces.nr_namespaces; i++) {
+		struct perf_ns_link_info *ns = &event->namespaces.link_info[i];
+
+		ns->dev = bswap_64(ns->dev);
+		ns->ino = bswap_64(ns->ino);
+	}
+
+	if (sample_id_all)
+		swap_sample_id_all(event, &event->namespaces.link_info[i]);
+}
+
 static u8 revbyte(u8 b)
 {
 	int rev = (b >> 4) | ((b & 0xf) << 4);
@@ -887,6 +907,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_LOST_SAMPLES]	  = perf_event__all64_swap,
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
+	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
-- 
2.20.1


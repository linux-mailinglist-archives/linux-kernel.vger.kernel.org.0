Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75532BC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 00:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfE0Wjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 18:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfE0Wjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:39:46 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23482081C;
        Mon, 27 May 2019 22:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996786;
        bh=DsYg7AzSvHFuFdz1+CG0RxTB+NMpLarMplA0DbFOavM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfKrts1/Aur6f3rwUt0FTAX19jSOnYBhEG0y3xA2FahI6qI2bDE94rTmP+QdICtPl
         zRqlwbY8sKmxgmP3fdm0bKHZo9lIMhYPhhA1X+c7B5UwdBBKsWu8GRu3Lc3bA2qzyD
         wZFGCCmNs9rz8QW8NF563HmfkGEY/DwHCJAM7MzA=
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
Subject: [PATCH 26/44] perf namespace: Protect reading thread's namespace
Date:   Mon, 27 May 2019 19:37:12 -0300
Message-Id: <20190527223730.11474-27-acme@kernel.org>
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

It seems that the current code lacks holding the namespace lock in
thread__namespaces().  Otherwise it can see inconsistent results.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Link: http://lkml.kernel.org/r/20190522053250.207156-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 403045a2bbea..b413ba5b9835 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -133,7 +133,7 @@ void thread__put(struct thread *thread)
 	}
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread)
+static struct namespaces *__thread__namespaces(const struct thread *thread)
 {
 	if (list_empty(&thread->namespaces_list))
 		return NULL;
@@ -141,10 +141,21 @@ struct namespaces *thread__namespaces(const struct thread *thread)
 	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
 }
 
+struct namespaces *thread__namespaces(const struct thread *thread)
+{
+	struct namespaces *ns;
+
+	down_read((struct rw_semaphore *)&thread->namespaces_lock);
+	ns = __thread__namespaces(thread);
+	up_read((struct rw_semaphore *)&thread->namespaces_lock);
+
+	return ns;
+}
+
 static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 				    struct namespaces_event *event)
 {
-	struct namespaces *new, *curr = thread__namespaces(thread);
+	struct namespaces *new, *curr = __thread__namespaces(thread);
 
 	new = namespaces__new(event);
 	if (!new)
-- 
2.20.1


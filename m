Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358622CE00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfE1RvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 13:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfE1RvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:51:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBBB2189F;
        Tue, 28 May 2019 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559065864;
        bh=DsYg7AzSvHFuFdz1+CG0RxTB+NMpLarMplA0DbFOavM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfrukAQ8tCRy4O98o8gI4NYU2wQ0GGu4DlqXdDKGLqyx8XmBOI5HaJTj0AcLAUPiC
         eXk2WsIZr5uSijep5RwaPA2LIwfPdhh6G/nuGWwxKIDLh9pRvKFM0ruGWo4TAh+Y72
         rHcSa6KWyScaQpQ1Nje4+RsryoypuHsRqsEeHiX8=
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
Subject: [PATCH 09/14] perf namespace: Protect reading thread's namespace
Date:   Tue, 28 May 2019 14:50:15 -0300
Message-Id: <20190528175020.13343-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528175020.13343-1-acme@kernel.org>
References: <20190528175020.13343-1-acme@kernel.org>
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


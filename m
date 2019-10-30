Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E9AE9C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 14:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfJ3Nr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 09:47:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:28792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfJ3Nr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:47:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="190281925"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2019 06:47:36 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 1/2] perf: Reattach a misplaced comment
Date:   Wed, 30 Oct 2019 15:47:30 +0200
Message-Id: <20191030134731.5437-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030134731.5437-1-alexander.shishkin@linux.intel.com>
References: <20191030134731.5437-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A comment is in a wrong place in perf_event_create_kernel_counter().
Fix that.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfd89b4a02d8..d2f16546a2ab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11415,10 +11415,6 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	struct perf_event *event;
 	int err;
 
-	/*
-	 * Get the target context (task or percpu):
-	 */
-
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
 				 overflow_handler, context, -1);
 	if (IS_ERR(event)) {
@@ -11429,6 +11425,9 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	/* Mark owner so we could distinguish it from user events. */
 	event->owner = TASK_TOMBSTONE;
 
+	/*
+	 * Get the target context (task or percpu):
+	 */
 	ctx = find_get_context(event->pmu, task, event);
 	if (IS_ERR(ctx)) {
 		err = PTR_ERR(ctx);
-- 
2.23.0


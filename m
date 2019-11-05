Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B969EF6AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 08:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbfKEH5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 02:57:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:59042 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387711AbfKEH5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:57:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 23:57:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="212488240"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2019 23:57:07 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Consistently fail fork on allocation failures
Date:   Tue,  5 Nov 2019 09:57:02 +0200
Message-Id: <20191105075702.60319-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  313ccb9615948 ("perf: Allocate context task_ctx_data for child event")

makes the inherit path skip over the current event in case of task_ctx_data
allocation failure. This, however, is inconsistent with allocation failures
in perf_event_alloc(), which would abort the fork.

Correct this by returning an error code on task_ctx_data allocation
failure and failing the fork in that case.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8ff1218e91b1..c8203f1b2d20 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12026,7 +12026,7 @@ inherit_event(struct perf_event *parent_event,
 						   GFP_KERNEL);
 		if (!child_ctx->task_ctx_data) {
 			free_event(child_event);
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 
-- 
2.24.0.rc1


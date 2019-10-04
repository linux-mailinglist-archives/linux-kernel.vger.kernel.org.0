Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07A0CBB00
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbfJDM5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:57:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:12043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387440AbfJDM5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:57:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 05:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="222133152"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 04 Oct 2019 05:57:34 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Fix inheritance of aux_output groups
Date:   Fri,  4 Oct 2019 15:57:29 +0300
Message-Id: <20191004125729.32397-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  b43762ef010 ("perf: Allow normal events to output AUX data")

forgets to configure aux_output relation in the inherited groups, which
results in child PEBS events forever failing to schedule.

Fix this by setting up the AUX output link in the inheritance path.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5bb2557d5f6..761995f21b30 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12024,6 +12024,10 @@ static int inherit_group(struct perf_event *parent_event,
 					    child, leader, child_ctx);
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
+
+		if (sub->aux_event == parent_event &&
+		    !perf_get_aux_event(child_ctr, leader))
+			return -EINVAL;
 	}
 	return 0;
 }
-- 
2.23.0


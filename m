Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99A017702E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 08:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCCHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 02:37:04 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40497 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:37:04 -0500
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 99C28FF805;
        Tue,  3 Mar 2020 07:37:00 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] blktrace: fix dereference after null check
Date:   Tue,  3 Mar 2020 10:33:59 +0300
Message-Id: <20200303073358.57799-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a recent change in blktrace.c that added a RCU protection to
`q->blk_trace` in order to fix a use-after-free issue during access.

However the change missed an edge case that can lead to dereferencing of
`bt` pointer even when it's NULL:

```
        bt->act_mask = value; // bt can still be NULL here
```

Added a reassignment into the NULL check block to fix the issue.

Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 Huge thanks goes to Steven Rostedt for his assistance.

 kernel/trace/blktrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4560878f0bac..29ea88f10b87 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1896,8 +1896,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}

 	ret = 0;
-	if (bt == NULL)
+	if (bt == NULL) {
 		ret = blk_trace_setup_queue(q, bdev);
+		bt = q->blk_trace;
+	}

 	if (ret == 0) {
 		if (attr == &dev_attr_act_mask)
--
2.25.1


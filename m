Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F06158969
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 06:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBKFYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 00:24:21 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41683 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727557AbgBKFYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:24:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TpeDbVp_1581398649;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpeDbVp_1581398649)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Feb 2020 13:24:18 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: vmpressure: don't need call kfree if kstrndup fails
Date:   Tue, 11 Feb 2020 13:24:08 +0800
Message-Id: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kstrndup fails (returns NULL) there is no memory is allocated by
kmalloc, so no need to call kfree().

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmpressure.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 4bac22f..0590f00 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -371,10 +371,8 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
 	int ret = 0;
 
 	spec_orig = spec = kstrndup(args, MAX_VMPRESSURE_ARGS_LEN, GFP_KERNEL);
-	if (!spec) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!spec)
+		return -ENOMEM;
 
 	/* Find required level */
 	token = strsep(&spec, ",");
-- 
1.8.3.1


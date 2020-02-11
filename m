Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30B515896A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 06:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBKFYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 00:24:32 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37366 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727557AbgBKFYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:24:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TpeTAeD_1581398658;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpeTAeD_1581398658)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Feb 2020 13:24:29 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: vmpressure: use mem_cgroup_is_root API
Date:   Tue, 11 Feb 2020 13:24:09 +0800
Message-Id: <1581398649-125989-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mem_cgroup_is_root() API to check if memcg is root memcg instead of
open coding.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmpressure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 0590f00..d69019f 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -280,7 +280,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		enum vmpressure_levels level;
 
 		/* For now, no users for root-level efficiency */
-		if (!memcg || memcg == root_mem_cgroup)
+		if (!memcg || mem_cgroup_is_root(memcg))
 			return;
 
 		spin_lock(&vmpr->sr_lock);
-- 
1.8.3.1


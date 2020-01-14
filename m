Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5184E13A9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 13:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgANMzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 07:55:09 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37789 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:55:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TnjKHlv_1579006506;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnjKHlv_1579006506)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 20:55:06 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
Date:   Tue, 14 Jan 2020 20:55:00 +0800
Message-Id: <1579006500-127143-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro are never used in git history. So better to remove.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/vmscan.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4e699ed3501e..033e7145061b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -146,20 +146,6 @@ struct scan_control {
 	struct reclaim_state reclaim_state;
 };
 
-#ifdef ARCH_HAS_PREFETCH
-#define prefetch_prev_lru_page(_page, _base, _field)			\
-	do {								\
-		if ((_page)->lru.prev != _base) {			\
-			struct page *prev;				\
-									\
-			prev = lru_to_page(&(_page->lru));		\
-			prefetch(&prev->_field);			\
-		}							\
-	} while (0)
-#else
-#define prefetch_prev_lru_page(_page, _base, _field) do { } while (0)
-#endif
-
 #ifdef ARCH_HAS_PREFETCHW
 #define prefetchw_prev_lru_page(_page, _base, _field)			\
 	do {								\
-- 
1.8.3.1


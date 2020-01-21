Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECD81438B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAUIt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:49:26 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34246 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgAUItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToHVM-7_1579596562;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHVM-7_1579596562)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/jfs: remove unused MAXL2PAGES
Date:   Tue, 21 Jan 2020 16:49:20 +0800
Message-Id: <1579596560-257920-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one use it from Linux-2.6.12-rc2, so better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Dave Kleikamp <shaggy@kernel.org> 
Cc: jfs-discussion@lists.sourceforge.net 
Cc: linux-kernel@vger.kernel.org 
---
 fs/jfs/jfs_dmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index caade185e568..7dfcab2a2da6 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -4027,7 +4027,6 @@ static int dbGetL2AGSize(s64 nblocks)
  */
 #define MAXL0PAGES	(1 + LPERCTL)
 #define MAXL1PAGES	(1 + LPERCTL * MAXL0PAGES)
-#define MAXL2PAGES	(1 + LPERCTL * MAXL1PAGES)
 
 /*
  * convert number of map pages to the zero origin top dmapctl level
-- 
1.8.3.1


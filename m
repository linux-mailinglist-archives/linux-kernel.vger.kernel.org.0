Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1036122A63
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 05:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfETDYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 23:24:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728932AbfETDYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:24:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BFDE2B496AE44860F57;
        Mon, 20 May 2019 11:24:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 May 2019 11:24:40 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] intel_th: msu: Fix unused variable warning on arm64 platform
Date:   Mon, 20 May 2019 11:23:20 +0800
Message-ID: <1558322600-63308-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this compiler warning on arm64 platform.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/hwtracing/intel_th/msu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 81bb54fa3ce8..e15ed5c308e1 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -780,7 +780,7 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 {
 	struct msc_window *win;
-	int ret = -ENOMEM, i;
+	int ret = -ENOMEM;
 
 	if (!nr_blocks)
 		return 0;
@@ -812,7 +812,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 		goto err_nomem;
 
 #ifdef CONFIG_X86
-	for (i = 0; i < ret; i++)
+	for (int i = 0; i < ret; i++)
 		/* Set the page as uncached */
 		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
 #endif
@@ -860,8 +860,6 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
  */
 static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 {
-	int i;
-
 	msc->nr_pages -= win->nr_blocks;
 
 	list_del(&win->entry);
@@ -871,7 +869,7 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 	}
 
 #ifdef CONFIG_X86
-	for (i = 0; i < win->nr_blocks; i++)
+	for (int i = 0; i < win->nr_blocks; i++)
 		/* Reset the page to write-back */
 		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
 #endif
-- 
2.7.4


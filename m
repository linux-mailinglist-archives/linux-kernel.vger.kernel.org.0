Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7610FC4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLCLPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 06:15:25 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:44365 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:15:25 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Dec 2019 06:15:25 EST
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 3 Dec 2019 19:45:22 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: taejoon.song@lge.com
Received: from unknown (HELO ubuntu0.156.147.1.1) (10.177.220.34)
        by 156.147.1.121 with ESMTP; 3 Dec 2019 19:45:22 +0900
X-Original-SENDERIP: 10.177.220.34
X-Original-MAILFROM: taejoon.song@lge.com
From:   Taejoon Song <taejoon.song@lge.com>
To:     minchan@google.com, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        yjay.kim@lge.com, Taejoon Song <taejoon.song@lge.com>
Subject: [PATCH] zram: try to avoid worst-case scenario on same element pages
Date:   Tue,  3 Dec 2019 19:43:53 +0900
Message-Id: <1575369833-16424-1-git-send-email-taejoon.song@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The worst-case scenario on finding same element pages is that almost
all elements are same at the first glance but only last few elements
are different.

Since the same element tends to be grouped from the beginning of the
pages, if we check the first element with the last element before
looping through all elements, we might have some chances to quickly
detect non-same element pages.

1. Test is done under LG webOS TV (64-bit arch)
2. Dump the swap-out pages (~819200 pages)
3. Analyze the pages with simple test script which counts the iteration
   number and measures the speed at off-line

Under 64-bit arch, the worst iteration count is PAGE_SIZE / 8 bytes = 512.
The speed is based on the time to consume page_same_filled() function only.
The result, on average, is listed as below:

                                   Num of Iter    Speed(MB/s)
Looping-Forward (Orig)                 38            99265
Looping-Backward                       36           102725
Last-element-check (This Patch)        33           125072

The result shows that the average iteration count decreases by 13% and
the speed increases by 25% with this patch. This patch does not increase
the overall time complexity, though.

I also ran simpler version which uses backward loop. Just looping backward
also makes some improvement, but less than this patch.

Signed-off-by: Taejoon Song <taejoon.song@lge.com>
---
 drivers/block/zram/zram_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4285e75..afadd7f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -207,14 +207,17 @@ static inline void zram_fill_page(void *ptr, unsigned long len,
 
 static bool page_same_filled(void *ptr, unsigned long *element)
 {
-	unsigned int pos;
 	unsigned long *page;
 	unsigned long val;
+	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
 
 	page = (unsigned long *)ptr;
 	val = page[0];
 
-	for (pos = 1; pos < PAGE_SIZE / sizeof(*page); pos++) {
+	if (val != page[last_pos])
+		return false;
+
+	for (pos = 1; pos < last_pos - 1; pos++) {
 		if (val != page[pos])
 			return false;
 	}
-- 
2.7.4


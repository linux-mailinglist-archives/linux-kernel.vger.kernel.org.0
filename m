Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F95B131B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfILRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 13:00:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729855AbfILQzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:55:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD85C710C0A98E5A65C6;
        Fri, 13 Sep 2019 00:55:39 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 13 Sep 2019 00:55:29 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/misc: Remove unneeded variable in st_tty_open
Date:   Fri, 13 Sep 2019 00:52:27 +0800
Message-ID: <1568307147-43468-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st_tty_open do not need local variable to store different value,
Hence just remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/misc/ti-st/st_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 7d9e23a..2ae9948 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -708,7 +708,6 @@ long st_write(struct sk_buff *skb)
  */
 static int st_tty_open(struct tty_struct *tty)
 {
-	int err = 0;
 	struct st_data_s *st_gdata;
 	pr_info("%s ", __func__);
 
@@ -731,7 +730,8 @@ static int st_tty_open(struct tty_struct *tty)
 	 */
 	st_kim_complete(st_gdata->kim_data);
 	pr_debug("done %s", __func__);
-	return err;
+
+	return 0;
 }
 
 static void st_tty_close(struct tty_struct *tty)
-- 
1.7.12.4


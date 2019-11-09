Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD038F5D32
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 04:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfKIDcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 22:32:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfKIDcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:32:36 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DDEA978F084C895BF6C3;
        Sat,  9 Nov 2019 11:32:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 11:32:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>,
        <andrew@aj.id.au>
CC:     <alistair@popple.id.au>, <linux-fsi@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fsi: aspeed: Use devm_kfree in aspeed_master_release()
Date:   Sat, 9 Nov 2019 11:32:09 +0800
Message-ID: <20191109033209.45244-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'aspeed' is allocted by devm_kfree(), it should not be
freed bt kfree().

Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 3dd82dd..0f63eec 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -361,7 +361,7 @@ static void aspeed_master_release(struct device *dev)
 	struct fsi_master_aspeed *aspeed =
 		to_fsi_master_aspeed(dev_to_fsi_master(dev));
 
-	kfree(aspeed);
+	devm_kfree(dev, aspeed);
 }
 
 /* mmode encoders */
-- 
2.7.4



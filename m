Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D64C0F92
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 06:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfI1ESV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 00:18:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfI1ESV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 00:18:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D4828D31D6D6FCF2D98;
        Sat, 28 Sep 2019 12:18:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 12:18:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oded.gabbay@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] habanalabs: remove set but not used variable 'ctx'
Date:   Sat, 28 Sep 2019 12:18:04 +0800
Message-ID: <20190928041804.41656-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/misc/habanalabs/device.c: In function hpriv_release:
drivers/misc/habanalabs/device.c:45:17: warning: variable ctx set but not used [-Wunused-but-set-variable]

It is never used since commit eb7caf84b029 ("habanalabs:
maintain a list of file private data objects")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/habanalabs/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 459fee7..2f5a4da 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -42,12 +42,10 @@ static void hpriv_release(struct kref *ref)
 {
 	struct hl_fpriv *hpriv;
 	struct hl_device *hdev;
-	struct hl_ctx *ctx;
 
 	hpriv = container_of(ref, struct hl_fpriv, refcount);
 
 	hdev = hpriv->hdev;
-	ctx = hpriv->ctx;
 
 	put_pid(hpriv->taskpid);
 
-- 
2.7.4



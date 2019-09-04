Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67326A7FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 11:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfIDJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 05:49:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727722AbfIDJto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:49:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 03AD6568DDFD3012E604;
        Wed,  4 Sep 2019 17:49:43 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 17:49:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <yoshihiro.shimoda.uh@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <colin.king@canonical.com>,
        <biju.das@bp.renesas.com>, <swboyd@chromium.org>,
        <yuehaibing@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] usb: gadget: renesas_usb3: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 17:48:36 +0800
Message-ID: <20190904094836.18532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index e098f16..922a19b 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2732,7 +2732,6 @@ static struct usb_role_switch_desc renesas_usb3_role_switch_desc = {
 static int renesas_usb3_probe(struct platform_device *pdev)
 {
 	struct renesas_usb3 *usb3;
-	struct resource *res;
 	int irq, ret;
 	const struct renesas_usb3_priv *priv;
 	const struct soc_device_attribute *attr;
@@ -2751,8 +2750,7 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 	if (!usb3)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	usb3->reg = devm_ioremap_resource(&pdev->dev, res);
+	usb3->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(usb3->reg))
 		return PTR_ERR(usb3->reg);
 
-- 
2.7.4



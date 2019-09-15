Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633ABB2DE9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfIOD0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 23:26:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfIOD0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 23:26:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0B86862CC76848BE9217;
        Sun, 15 Sep 2019 11:26:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Sun, 15 Sep 2019 11:26:13 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <valentina.manea.m@gmail.com>, <shuah@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH] usbip: vhci_hcd indicate failed message
Date:   Sun, 15 Sep 2019 11:43:32 +0800
Message-ID: <20190915034332.21168-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the return value of vhci_init_attr_group and
sysfs_create_group is non-zero, which mean they failed
to init attr_group and create sysfs group, so it would
better add 'failed' message to indicate that.

Fixes: 0775a9cbc694 ("usbip: vhci extension: modifications to vhci driver")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 000ab7225717..dd54c95d2498 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1185,12 +1185,12 @@ static int vhci_start(struct usb_hcd *hcd)
 	if (id == 0 && usb_hcd_is_primary_hcd(hcd)) {
 		err = vhci_init_attr_group();
 		if (err) {
-			pr_err("init attr group\n");
+			pr_err("init attr group failed\n");
 			return err;
 		}
 		err = sysfs_create_group(&hcd_dev(hcd)->kobj, &vhci_attr_group);
 		if (err) {
-			pr_err("create sysfs files\n");
+			pr_err("create sysfs failed\n");
 			vhci_finish_attr_group();
 			return err;
 		}
-- 
2.20.1


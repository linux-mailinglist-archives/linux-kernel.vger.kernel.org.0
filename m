Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE529A12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 16:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403981AbfEXO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 10:29:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390885AbfEXO3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:29:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D30FCC3B7DC05045323B;
        Fri, 24 May 2019 22:28:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 22:28:47 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] ipmi_ssif: fix unexpected driver unregister warning
Date:   Fri, 24 May 2019 22:37:24 +0800
Message-ID: <20190524143724.43218-1-wangkefeng.wang@huawei.com>
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

If platform_driver_register() fails from init_ipmi_ssif(),
platform_driver_unregister() called unconditionally will
trigger following warning,

ipmi_ssif: Unable to register driver: -12
------------[ cut here ]------------
Unexpected driver unregister!
WARNING: CPU: 1 PID: 6305 at drivers/base/driver.c:193 driver_unregister+0x60/0x70 drivers/base/driver.c:193

Fix it by adding platform_registered variable, only unregister platform
driver when it is already successfully registered.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index cf8156d6bc07..305fa5054274 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -303,6 +303,7 @@ struct ssif_info {
 	((unsigned int) atomic_read(&(ssif)->stats[SSIF_STAT_ ## stat]))
 
 static bool initialized;
+static bool platform_registered;
 
 static void return_hosed_msg(struct ssif_info *ssif_info,
 			     struct ipmi_smi_msg *msg);
@@ -2088,6 +2089,8 @@ static int init_ipmi_ssif(void)
 		rv = platform_driver_register(&ipmi_driver);
 		if (rv)
 			pr_err("Unable to register driver: %d\n", rv);
+		else
+			platform_registered = true;
 	}
 
 	ssif_i2c_driver.address_list = ssif_address_list();
@@ -2111,7 +2114,7 @@ static void cleanup_ipmi_ssif(void)
 
 	kfree(ssif_i2c_driver.address_list);
 
-	if (ssif_trydmi)
+	if (ssif_trydmi && platform_registered)
 		platform_driver_unregister(&ipmi_driver);
 
 	free_ssif_clients();
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95608D0551
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 03:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfJIBrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 21:47:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfJIBrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:47:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A4AE99E700B83A829429;
        Wed,  9 Oct 2019 09:47:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 09:47:32 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <biju.das@bp.renesas.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
Date:   Wed, 9 Oct 2019 09:47:07 +0800
Message-ID: <20191009014707.38716-1-maowenan@huawei.com>
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

If CONFIG_TYPEC_HD3SS3220=y, CONFIG_USB_ROLE_SWITCH=m, below errors
can be found:
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
hd3ss3220.c:(.text+0x154): undefined reference to `usb_role_switch_set_role'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
hd3ss3220.c:(.text+0x294): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x2f4): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x348): undefined reference to `usb_role_switch_set_role'
hd3ss3220.c:(.text+0x390): undefined reference to `usb_role_switch_set_role'
drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
hd3ss3220.c:(.text+0x5e8): undefined reference to `fwnode_usb_role_switch_get'
hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
make: *** [vmlinux] Error 1

This patch add dependency USB_ROLE_SWITCH for TYPEC_HD3SS3220.

Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/usb/typec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index aceb2af..b4f2aac 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -53,6 +53,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
 config TYPEC_HD3SS3220
 	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
 	depends on I2C
+	depends on USB_ROLE_SWITCH
 	help
 	  Say Y or M here if your system has TI HD3SS3220 Type-C DRP Port
 	  controller driver.
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3696FA42C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 03:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfKMCOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 21:14:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727577AbfKMCOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:14:42 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6FE83DB6A79074E0F32;
        Wed, 13 Nov 2019 10:14:40 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 10:14:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <perex@perex.cz>,
        <davem@davemloft.net>, <joe@perches.com>, <yuehaibing@huawei.com>,
        <tglx@linutronix.de>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] staging: hp100: Fix build error without ETHERNET
Date:   Wed, 13 Nov 2019 10:13:06 +0800
Message-ID: <20191113021306.35464-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should depends on ETHERNET, otherwise building fails:

drivers/staging/hp/hp100.o: In function `hp100_pci_remove':
hp100.c:(.text+0x165): undefined reference to `unregister_netdev'
hp100.c:(.text+0x214): undefined reference to `free_netdev'

Fixes: 52340b82cf1a ("hp100: Move 100BaseVG AnyLAN driver to staging")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/hp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/hp/Kconfig b/drivers/staging/hp/Kconfig
index fb395cf..f20ab21 100644
--- a/drivers/staging/hp/Kconfig
+++ b/drivers/staging/hp/Kconfig
@@ -6,6 +6,7 @@
 config NET_VENDOR_HP
 	bool "HP devices"
 	default y
+	depends on ETHERNET
 	depends on ISA || EISA || PCI
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
-- 
2.7.4



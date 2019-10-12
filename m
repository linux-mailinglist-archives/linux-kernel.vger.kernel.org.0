Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C46D4F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfJLK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 06:58:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726793AbfJLK6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 06:58:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 17DDA52DD7ACBD57E359;
        Sat, 12 Oct 2019 18:58:38 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 12 Oct 2019 18:58:34 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <Jerome.Pouiller@silabs.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] staging: wfx: fix an undefined reference error when CONFIG_MMC=m
Date:   Sat, 12 Oct 2019 18:54:53 +0800
Message-ID: <1570877693-52711-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit the following error when compile the kernel.

drivers/staging/wfx/main.o: In function `wfx_core_init':
/home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
drivers/staging/wfx/main.o: In function `wfx_core_exit':
/home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v2->v3:
    We'd better not use #ifdef in .c file to use IS_ENABLED instead.

v1->v2:
    We should prefer to current dependencies rather than force to enable. 

 drivers/staging/wfx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/Makefile b/drivers/staging/wfx/Makefile
index 0d9c1ed..77d68b7 100644
--- a/drivers/staging/wfx/Makefile
+++ b/drivers/staging/wfx/Makefile
@@ -19,6 +19,6 @@ wfx-y := \
 	sta.o \
 	debug.o
 wfx-$(CONFIG_SPI) += bus_spi.o
-wfx-$(subst m,y,$(CONFIG_MMC)) += bus_sdio.o
+wfx-$(CONFIG_MMC) += bus_sdio.o
 
 obj-$(CONFIG_WFX) += wfx.o
-- 
1.7.12.4


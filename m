Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4472EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 14:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGXMhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 08:37:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38036 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfGXMhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:37:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0F19ED0A275507F1B81C;
        Wed, 24 Jul 2019 20:37:34 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 20:37:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mtd: hyperbus: Fix Kconfig warning
Date:   Wed, 24 Jul 2019 20:37:17 +0800
Message-ID: <20190724123717.34128-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: unmet direct dependencies detected for MUX_MMIO
  Depends on [n]: MULTIPLEXER [=m] && (OF [=n] || COMPILE_TEST [=n])
  Selected by [m]:
  - HBMC_AM654 [=m] && MTD [=m] && MTD_HYPERBUS [=m]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mtd/hyperbus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
index cff6bbd..769d129 100644
--- a/drivers/mtd/hyperbus/Kconfig
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -14,6 +14,7 @@ if MTD_HYPERBUS
 
 config HBMC_AM654
 	tristate "HyperBus controller driver for AM65x SoC"
+	depends on OF
 	select MULTIPLEXER
 	select MUX_MMIO
 	help
-- 
2.7.4



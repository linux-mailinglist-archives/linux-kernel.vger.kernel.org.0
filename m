Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9BB2C8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfE1Obt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 10:31:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfE1Obt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:31:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09013B321758B27C89EF;
        Tue, 28 May 2019 22:31:39 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 22:31:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <TheSven73@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] staging: fieldbus: Fix build error without CONFIG_REGMAP_MMIO
Date:   Tue, 28 May 2019 22:29:12 +0800
Message-ID: <20190528142912.13224-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build error while CONFIG_REGMAP_MMIO is not set

drivers/staging/fieldbus/anybuss/arcx-anybus.o: In function `controller_probe':
arcx-anybus.c: undefined reference to `__devm_regmap_init_mmio_clk'

Select REGMAP_MMIO to fix it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2411a336c8ce ("staging: fieldbus: arcx-anybus: change custom -> mmio regmap")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix patch style warning
---
 drivers/staging/fieldbus/anybuss/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fieldbus/anybuss/Kconfig b/drivers/staging/fieldbus/anybuss/Kconfig
index 8bc3d9a..635a0a7 100644
--- a/drivers/staging/fieldbus/anybuss/Kconfig
+++ b/drivers/staging/fieldbus/anybuss/Kconfig
@@ -14,6 +14,7 @@ if HMS_ANYBUSS_BUS
 config ARCX_ANYBUS_CONTROLLER
 	tristate "Arcx Anybus-S Controller"
 	depends on OF && GPIOLIB && HAS_IOMEM && REGULATOR
+	select REGMAP_MMIO
 	help
 	  Select this to get support for the Arcx Anybus controller.
 	  It connects to the SoC via a parallel memory bus, and
-- 
2.7.4



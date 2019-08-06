Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5632583652
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbfHFQI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:08:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732203AbfHFQI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:08:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E2BBCD242C6BF83393B;
        Wed,  7 Aug 2019 00:08:25 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Wed, 7 Aug 2019 00:08:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <corbet@lwn.net>, <mchehab+samsung@kernel.org>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <frieder.schrempf@kontron.de>, John Garry <john.garry@huawei.com>
Subject: [PATCH] docs: mtd: Update spi nor reference driver
Date:   Wed, 7 Aug 2019 00:06:23 +0800
Message-ID: <1565107583-68506-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference driver no longer exists since commit 50f1242c6742 ("mtd:
fsl-quadspi: Remove the driver as it was replaced by spi-fsl-qspi.c").

Update reference to spi-fsl-qspi.c driver.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
index f5333e3bf486..1f0437676762 100644
--- a/Documentation/driver-api/mtd/spi-nor.rst
+++ b/Documentation/driver-api/mtd/spi-nor.rst
@@ -59,7 +59,7 @@ Part III - How can drivers use the framework?
 
 The main API is spi_nor_scan(). Before you call the hook, a driver should
 initialize the necessary fields for spi_nor{}. Please see
-drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to fsl-quadspi.c
+drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
 when you want to write a new driver for a SPI NOR controller.
 Another API is spi_nor_restore(), this is used to restore the status of SPI
 flash chip such as addressing mode. Call it whenever detach the driver from
-- 
2.17.1


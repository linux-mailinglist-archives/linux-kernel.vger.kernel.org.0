Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3D11C353
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 03:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfLLCiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 21:38:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbfLLCix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:38:53 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47BA6599017D03920C66;
        Thu, 12 Dec 2019 10:38:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 12 Dec 2019 10:38:41 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <willy@infradead.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] scsi: sym53c8xx_2: fix typos in comments
Date:   Thu, 12 Dec 2019 10:35:56 +0800
Message-ID: <20191212023556.72618-1-chenzhou10@huawei.com>
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

Fix the typo "GPOI" -> "GPIO" in comment.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/scsi/sym53c8xx_2/sym_nvram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_nvram.c b/drivers/scsi/sym53c8xx_2/sym_nvram.c
index 9dc17f1..d37e2a6 100644
--- a/drivers/scsi/sym53c8xx_2/sym_nvram.c
+++ b/drivers/scsi/sym53c8xx_2/sym_nvram.c
@@ -227,7 +227,7 @@ static void sym_display_Tekram_nvram(struct sym_device *np, Tekram_nvram *nvram)
 /*
  *  24C16 EEPROM reading.
  *
- *  GPOI0 - data in/data out
+ *  GPIO0 - data in/data out
  *  GPIO1 - clock
  *  Symbios NVRAM wiring now also used by Tekram.
  */
@@ -524,7 +524,7 @@ static int sym_read_Symbios_nvram(struct sym_device *np, Symbios_nvram *nvram)
 /*
  *  93C46 EEPROM reading.
  *
- *  GPOI0 - data in
+ *  GPIO0 - data in
  *  GPIO1 - data out
  *  GPIO2 - clock
  *  GPIO4 - chip select
-- 
2.7.4


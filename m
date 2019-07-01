Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8950138FB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfEDK2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 06:28:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727568AbfEDK2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:28:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 102CF6A7CC9AEFD6C2D8;
        Sat,  4 May 2019 18:28:35 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 May 2019
 18:28:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <fbarrat@linux.ibm.com>, <ajd@linux.ibm.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] misc: ocxl: Make ocxl_remove static
Date:   Sat, 4 May 2019 18:27:20 +0800
Message-ID: <20190504102720.42220-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/misc/ocxl/pci.c:44:6: warning:
 symbol 'ocxl_remove' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/ocxl/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
index f2a3ef4..cb920aa 100644
--- a/drivers/misc/ocxl/pci.c
+++ b/drivers/misc/ocxl/pci.c
@@ -41,7 +41,7 @@ static int ocxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 }
 
-void ocxl_remove(struct pci_dev *dev)
+static void ocxl_remove(struct pci_dev *dev)
 {
 	struct ocxl_fn *fn;
 	struct ocxl_afu *afu;
-- 
2.7.4



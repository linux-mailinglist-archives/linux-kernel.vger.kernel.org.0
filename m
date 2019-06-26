Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64B55E21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 04:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFZCJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 22:09:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfFZCJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:09:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ABF09652E0975C785EF7;
        Wed, 26 Jun 2019 10:09:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Jun 2019
 10:09:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] nvme-pci: Make nvme_dev_pm_ops static
Date:   Wed, 26 Jun 2019 10:09:02 +0800
Message-ID: <20190626020902.38240-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/nvme/host/pci.c:2926:25: warning:
 symbol 'nvme_dev_pm_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1893520..f500133 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2923,7 +2923,7 @@ static int nvme_simple_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops nvme_dev_pm_ops = {
+static const struct dev_pm_ops nvme_dev_pm_ops = {
 	.suspend	= nvme_suspend,
 	.resume		= nvme_resume,
 	.freeze		= nvme_simple_suspend,
-- 
2.7.4



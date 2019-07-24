Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4311D73123
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfGXOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:09:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfGXOJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:09:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B2EAF9EA050138488E51;
        Wed, 24 Jul 2019 22:09:02 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 22:08:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] xen/pciback: remove set but not used variable 'old_state'
Date:   Wed, 24 Jul 2019 22:08:50 +0800
Message-ID: <20190724140850.10760-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/xen/xen-pciback/conf_space_capability.c: In function pm_ctrl_write:
drivers/xen/xen-pciback/conf_space_capability.c:119:25: warning:
 variable old_state set but not used [-Wunused-but-set-variable]

It is never used so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/xen-pciback/conf_space_capability.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 73427d8..e569413 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -116,13 +116,12 @@ static int pm_ctrl_write(struct pci_dev *dev, int offset, u16 new_value,
 {
 	int err;
 	u16 old_value;
-	pci_power_t new_state, old_state;
+	pci_power_t new_state;
 
 	err = pci_read_config_word(dev, offset, &old_value);
 	if (err)
 		goto out;
 
-	old_state = (pci_power_t)(old_value & PCI_PM_CTRL_STATE_MASK);
 	new_state = (pci_power_t)(new_value & PCI_PM_CTRL_STATE_MASK);
 
 	new_value &= PM_OK_BITS;
-- 
2.7.4



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA212E188
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 02:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgABBta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 20:49:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgABBt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:49:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0E475EF1EAB605045B9A;
        Thu,  2 Jan 2020 09:49:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 2 Jan 2020 09:49:18 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <suganath-prabu.subramani@broadcom.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH next] scsi: mpt3sas: remove call to memset after dma_alloc_coherent
Date:   Thu, 2 Jan 2020 09:45:26 +0800
Message-ID: <20200102014526.139275-1-chenzhou10@huawei.com>
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

Function dma_alloc_coherent use in ioc -> request already zeroes out
memory, so memset is not needed.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 45fd8df..663dd4d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5090,7 +5090,6 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		_base_release_memory_pools(ioc);
 		goto retry_allocation;
 	}
-	memset(ioc->request, 0, sz);
 
 	if (retry_sz)
 		ioc_err(ioc, "request pool: dma_alloc_coherent succeed: hba_depth(%d), chains_per_io(%d), frame_sz(%d), total(%d kb)\n",
-- 
2.7.4


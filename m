Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5025881DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 15:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfHENul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 09:50:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729845AbfHENu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:50:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 20F3588411166E615543;
        Mon,  5 Aug 2019 21:50:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 21:50:13 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 08/15] scsi: hisi_sas: Make slot buf minimum allocation of PAGE_SIZE
Date:   Mon, 5 Aug 2019 21:48:05 +0800
Message-ID: <1565012892-75940-9-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
References: <1565012892-75940-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

For a system with PAGE_SIZE of 16K or 64K, the size every time we want to
alloc may be small like 4K, but for function dmam_alloc_coherent(), the
least size it allocates is PAGE_SIZE, so it will waste much memory for the
situation.

To solve the issue, limit the minimum allocation size of slot buf to
PAGE_SIZE.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 7efa8dfa0cc1..39ae69e42d26 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2389,7 +2389,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 	else
 		sz_slot_buf_ru = sizeof(struct hisi_sas_slot_buf_table);
 	sz_slot_buf_ru = roundup(sz_slot_buf_ru, 64);
-	s = lcm(max_command_entries_ru, sz_slot_buf_ru);
+	s = max(lcm(max_command_entries_ru, sz_slot_buf_ru), PAGE_SIZE);
 	blk_cnt = (max_command_entries_ru * sz_slot_buf_ru) / s;
 	slots_per_blk = s / sz_slot_buf_ru;
 
-- 
2.17.1


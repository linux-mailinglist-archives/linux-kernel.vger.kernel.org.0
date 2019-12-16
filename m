Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C727711FD11
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 04:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLPDFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 22:05:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfLPDFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:05:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 17C909BF6094140D07F3;
        Mon, 16 Dec 2019 11:04:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 16 Dec 2019
 11:04:49 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <pjones@redhat.com>, <konrad@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] iscsi_ibft: Remove unneeded semicolon
Date:   Mon, 16 Dec 2019 11:12:10 +0800
Message-ID: <1576465930-34966-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/firmware/iscsi_ibft.c:804:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/firmware/iscsi_ibft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 7e12cbd..8748692 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -801,7 +801,7 @@ static void ibft_unregister(void)
 		ibft_kobj = boot_kobj->data;
 		if (ibft_kobj->hdr && ibft_kobj->hdr->id == id_nic)
 			sysfs_remove_link(&boot_kobj->kobj, "device");
-	};
+	}
 }

 static void ibft_cleanup(void)
--
2.7.4


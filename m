Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A1B13BA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 08:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgAOHCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 02:02:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgAOHCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:02:35 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2E0C26AAF424853E4FA2;
        Wed, 15 Jan 2020 15:02:33 +0800 (CST)
Received: from huawei.com (10.175.107.192) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Jan 2020
 15:02:24 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangchenfeng1@huawei.com>, <wanghongzhe@huawei.com>
Subject: [PATCH] tpm:tpm_tis_spi: set cs_change = 0 when timesout
Date:   Tue, 15 Jan 2019 15:02:29 +0800
Message-ID: <1547535749-23221-1-git-send-email-wanghongzhe@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.107.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hongzhe <wanghongzhe@huawei.com>

when i reach TPM_RETRY, the cs cannot  change back to 'high'.
So the TPM chips thinks this communication is not over.
And next times communication cannot be effective because the
communications mixed up with the last time.

Signed-off-by: Wang Hongzhe <wanghongzhe@huawei.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index d1754fd..27e57bf 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -66,8 +66,15 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 				break;
 		}
 
-		if (i == TPM_RETRY)
+		if (i == TPM_RETRY) {
+			spi_xfer->len = 1;
+			spi_xfer->cs_change = 0;
+			spi_message_init(&m);
+			spi_message_add_tail(spi_xfer, &m);
+			if (ret < 0)
+				return ret;
 			return -ETIMEDOUT;
+		}
 	}
 
 	return 0;
-- 
1.7.12.4


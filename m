Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4D13A8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 12:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgANL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 06:56:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgANL4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:56:50 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D9E49CC318F77E6BF210;
        Tue, 14 Jan 2020 19:56:46 +0800 (CST)
Received: from huawei.com (10.175.107.192) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 19:56:38 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangchenfeng1@huawei.com>, <wanghongzhe@huawei.com>
Subject: [PATCH] tpm: tpm_tis_spi: set cs_change = 0 when timesout
Date:   Tue, 14 Jan 2020 20:31:59 +0800
Message-ID: <1579005119-16318-1-git-send-email-wanghongzhe@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.107.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when i reach TPM_RETRY, the cs cannot  change back to 'high'.So the TPM chips thinks this communication is not over. 
And next times communication cannot be effective because the communications mixed up with the last time.

Signed-off-by: wanghongzhe <wanghongzhe@huawei.com>
---
 drivers/char/tpm/tpm_tis_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index d1754fd..a1ae4f6 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -67,7 +67,14 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 		}
 
 		if (i == TPM_RETRY)
+ 		{
+ 			spi_xfer.cs_change = 0;
+ 			spi_xfer->len = 1;
+ 			spi_message_init(&m);
+ 			spi_message_add_tail(spi_xfer, &m);
+ 			ret = spi_sync_locked(phy->spi_device, &m);
 			return -ETIMEDOUT;
+ 		}
 	}
 
 	return 0;
-- 
1.7.12.4


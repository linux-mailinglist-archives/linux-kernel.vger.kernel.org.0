Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54C2A2B3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 06:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEYES3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 00:18:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfEYES2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 00:18:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A3AC57A6F2A73DE5BF64;
        Sat, 25 May 2019 12:18:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 12:18:13 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jeremy@azazel.net>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH net] =?UTF-8?q?staging:=20Remove=20set=20but=20not=20used?= =?UTF-8?q?=20variable=20=E2=80=98status=E2=80=99?=
Date:   Sat, 25 May 2019 12:26:42 +0800
Message-ID: <20190525042642.78482-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/kpc2000/kpc_spi/spi_driver.c: In function
‘kp_spi_transfer_one_message’:
drivers/staging/kpc2000/kpc_spi/spi_driver.c:282:9: warning: variable
‘status’ set but not used [-Wunused-but-set-variable]
     int status = 0;
         ^~~~~~
The variable 'status' is not used any more, remve it.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/staging/kpc2000/kpc_spi/spi_driver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_spi/spi_driver.c b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
index 86df16547a92..16f9518f8d63 100644
--- a/drivers/staging/kpc2000/kpc_spi/spi_driver.c
+++ b/drivers/staging/kpc2000/kpc_spi/spi_driver.c
@@ -279,7 +279,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
     struct kp_spi       *kpspi;
     struct spi_transfer *transfer;
     union kp_spi_config sc;
-    int status = 0;
     
     spidev = m->spi;
     kpspi = spi_master_get_devdata(master);
@@ -332,7 +331,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
     /* do the transfers for this message */
     list_for_each_entry(transfer, &m->transfers, transfer_list) {
         if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
-            status = -EINVAL;
             break;
         }
         
@@ -370,7 +368,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
             m->actual_length += count;
             
             if (count != transfer->len) {
-                status = -EIO;
                 break;
             }
         }
-- 
2.20.1


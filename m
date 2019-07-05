Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD275FA16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGDO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 10:29:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40172 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfGDO3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:29:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B52EE2000B3;
        Thu,  4 Jul 2019 16:29:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E28DB200DA6;
        Thu,  4 Jul 2019 16:29:14 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2E9FB402C0;
        Thu,  4 Jul 2019 22:29:09 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     srinivas.kandagatla@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     gregkh@linuxfoundation.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fugang.duan@nxp.com
Subject: [PATCH nvmem 1/1] nvmem: imx: correct the fuse word index
Date:   Thu,  4 Jul 2019 22:20:15 +0800
Message-Id: <20190704142015.10701-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

iMX8 fuse word index represent as one 4-bytes word,
it should not be divided by 4.

Exp:
- MAC0 address layout in fuse:
offset 708: MAC[3] MAC[2] MAC[1] MAC[0]
offset 709: XX     xx     MAC[5] MAC[4]

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/nvmem/imx-ocotp-scu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index d9dc482..be2f5f0 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -71,8 +71,8 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 	void *p;
 	int i, ret;
 
-	index = offset >> 2;
-	num_bytes = round_up((offset % 4) + bytes, 4);
+	index = offset;
+	num_bytes = round_up(bytes, 4);
 	count = num_bytes >> 2;
 
 	if (count > (priv->data->nregs - index))
@@ -100,7 +100,7 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 		buf++;
 	}
 
-	memcpy(val, (u8 *)p + offset % 4, bytes);
+	memcpy(val, (u8 *)p, bytes);
 
 	kfree(p);
 
-- 
2.7.4


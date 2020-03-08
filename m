Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8644A17D1FB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 07:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCHGBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 01:01:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36000 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgCHGBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 01:01:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so3189020pgu.3;
        Sat, 07 Mar 2020 22:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Nj+26QvFCgpaOHrw23MsZ4NAuEdSFH7yEAjrK++Ph7Q=;
        b=ohLVqCZz9ZojWIUPgcMSqQIPWwojo/6mzc71lhE48LHeFgJxOmmVwdgdPBpmL1iDQO
         U9jROmGe8Yx5d35U5P4flLgvzyFNmAY6de6jbRaGf/hg4gERmcQUjcm6PstFd6WjRopj
         POLd7iVt7NLAvjST3yvpJTAYsS31oGABAD6YRv12FXb7h7vsSUJeGfHddG0Imz3U5h3t
         AqsaPoeSJpLcwBloOAGGsHdzb/e8rSnH0nE/sEtHCdTPzZqLtWcWJSmLq77sooRG9sEX
         NRsym+L6Ju1OBB3JJVqslN6C7ZzlnFvZaXUr4TXulNYIAVv0n18tyq7OgztF4f+VPnnE
         YO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nj+26QvFCgpaOHrw23MsZ4NAuEdSFH7yEAjrK++Ph7Q=;
        b=BtFvzhe9Atvrxc7Jw+ACTm08cun3MB61CF0S/DSHtDxZy3ocMXIctH7MpWXbRRtRM5
         rGsyXsAgRWBm5ZMP3Eswf+U3mdGNIBEegJ3VX7La0zYn0OmrfjjWPmdEM6gsszWoTzEg
         oHyQ0Jts+URR10ChG9d7z51V5lx69ilk30FQG9gxV1i0qSILP71qTE3ipOKpR4tZ+Cj3
         H+0NcPlH2dQYTKxhLvgYkSENtqWHNyWwV8xvurf4DnuJz3t9q7ppMMChTq/GPFZeibGZ
         +aQjlZenbNE2XnccMZBrbZk9EIDGQRjTo06SbCyceEbPl1L/AsgegiOf0PiOLuzdKegE
         6Gfw==
X-Gm-Message-State: ANhLgQ0y5jczMJdrGf3DwUP0KE/SeDaxSAObp7tCULCpuN/7vs+E8Kxd
        fYNLqOI3qRB5kP+CTHQhqrQ=
X-Google-Smtp-Source: ADFU+vt2Xz7+USz64L6//xelwLrvzVvwplLv4CLEaJIuDQbH02H0pJn7CyGnd6EjkOX4Ul/JTOO07g==
X-Received: by 2002:a63:1044:: with SMTP id 4mr10987545pgq.412.1583647260210;
        Sat, 07 Mar 2020 22:01:00 -0800 (PST)
Received: from localhost.localdomain ([149.129.63.152])
        by smtp.gmail.com with ESMTPSA id 185sm33483620pfv.104.2020.03.07.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 22:00:59 -0800 (PST)
From:   Jianhui Zhao <zhaojh329@gmail.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jianhui Zhao <zhaojh329@gmail.com>
Subject: [PATCH] crypto: atmel-i2c - Fix wakeup fail
Date:   Sun,  8 Mar 2020 14:00:53 +0800
Message-Id: <20200308060053.23515-1-zhaojh329@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wake token cannot be sent without ignoring the nack for the
device address

Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
---
 drivers/crypto/atmel-i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index 1d3355913b40..13624cde67e8 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -3,6 +3,7 @@
  * Microchip / Atmel ECC (I2C) driver.
  *
  * Copyright (c) 2017, Microchip Technology Inc.
+ * Copyright (c) 2020 Jianhui Zhao <zhaojh329@gmail.com>
  * Author: Tudor Ambarus <tudor.ambarus@microchip.com>
  */
 
@@ -176,7 +177,8 @@ static int atmel_i2c_wakeup(struct i2c_client *client)
 	 * device is idle, asleep or during waking up. Don't check for error
 	 * when waking up the device.
 	 */
-	i2c_master_send(client, i2c_priv->wake_token, i2c_priv->wake_token_sz);
+	i2c_transfer_buffer_flags(client, i2c_priv->wake_token,
+				i2c_priv->wake_token_sz, I2C_M_IGNORE_NAK);
 
 	/*
 	 * Wait to wake the device. Typical execution times for ecdh and genkey
-- 
2.17.1


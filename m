Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAD526ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 10:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfFYIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 04:41:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40701 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfFYIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so15364801ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weUglzTtIq4sAlt0j1mvPYtNfW0fP+4XOBaGGUaVvYI=;
        b=cKzjRJU3W6eX2V54ZSciulywf3c73hUnd9N3wXCg9BINskPrwtkJ63YSFwVvBrbuC1
         CGZOBLEAFdw00YNYIlLdmbhr2QHxDB5USG2qSsv+R8mnU/m8IvGFNDqoRUAgcQ57i+M3
         DafM2JkjdQs6zUlzBC/nZg/coUZ/brAyrNE2eqiFzGsuV13ziA4yMJ/CvMZI0tXe6fG9
         TOMM3YPHIIzFRB0V/tyvXcSju3NVoggCF2Bfb5HgQ+u3hbrLlfU0OpyrckhMTFAF7tM3
         vuTMTduCUjmtV9Zw52AjR8CkDnmAsOJMKRovKM69dRwqh8BvzsJ46rZF6XrDihrSxyu+
         DyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weUglzTtIq4sAlt0j1mvPYtNfW0fP+4XOBaGGUaVvYI=;
        b=GeFdvdZmCm0cEGU7MrYdWadHlwOaMtkYoL9B1QErTfsG0r5RLWsf7ChC891Xy0BsQR
         uckLIwiH2HdNpGxvxuLEVAoNJzgk/8FcdgoN5D/D1PSX7WOZY68A2z/ZivfTTX9xCIuI
         ZZngJgwOTKWnE9Rg2OFWB/bDvjDGdLw0VlLilIGvPMGbV+tzD0M5Gy7fAR5XXzDUy5aS
         btNB997r5YueOp8SEbXy/GuR2SjywiFkIgutDXdSIFRTyGBgx76M6ZmDeIV/MYQrq1HQ
         8MPdciGuyCzHE/D1x1rl7ObkzC+xCXjrW2IiQGtnnPVpOcz0lrGP0PjJjN8TDfCNTMzG
         S2Vg==
X-Gm-Message-State: APjAAAUifNMmhabGy+zKQgCQUSKsxSMpPYasBFfROKUxsZNxJr6PUitw
        a+SCARZ8qq/aZMQPwO/h6kZiituUfcg0KA==
X-Google-Smtp-Source: APXvYqwr2UPRGbsF9+g5c/Vm6ACGW8PfyCMEJqNaS7EA9TcoBGg/vFtltckQI/9D4XY8lSG3cKlypg==
X-Received: by 2002:a2e:5d1:: with SMTP id 200mr65784559ljf.10.1561452095398;
        Tue, 25 Jun 2019 01:41:35 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id h78sm341564ljf.88.2019.06.25.01.41.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:41:34 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 1/4] staging: kpc2000: add missing spaces in kpc2000_i2c.c
Date:   Tue, 25 Jun 2019 10:41:27 +0200
Message-Id: <20190625084130.1107-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625084130.1107-1-simon@nikanor.nu>
References: <20190625084130.1107-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch "CHECK: spaces preferred around that '+' (ctx:VxV)".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 69e8773c1ef8..3e08df9f205d 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -257,7 +257,7 @@ static int i801_block_transaction_by_block(struct i2c_device *priv, union i2c_sm
 		len = data->block[0];
 		outb_p(len, SMBHSTDAT0(priv));
 		for (i = 0; i < len; i++)
-			outb_p(data->block[i+1], SMBBLKDAT(priv));
+			outb_p(data->block[i + 1], SMBBLKDAT(priv));
 	}
 
 	status = i801_transaction(priv, I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
@@ -337,8 +337,8 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
 		/* Retrieve/store value in SMBBLKDAT */
 		if (read_write == I2C_SMBUS_READ)
 			data->block[i] = inb_p(SMBBLKDAT(priv));
-		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
-			outb_p(data->block[i+1], SMBBLKDAT(priv));
+		if (read_write == I2C_SMBUS_WRITE && i + 1 <= len)
+			outb_p(data->block[i + 1], SMBBLKDAT(priv));
 		/* signals SMBBLKDAT ready */
 		outb_p(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_INTR, SMBHSTSTS(priv));
 	}
-- 
2.20.1


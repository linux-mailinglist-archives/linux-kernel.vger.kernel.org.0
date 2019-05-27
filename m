Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D802BB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 22:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfE0UKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 16:10:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40447 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfE0UKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so517758wmg.5;
        Mon, 27 May 2019 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+c7EUbgBQhlzZ37NOreDYMAwd8bxw3irPCzpd3kWrE=;
        b=gbyFYMESgLGOeRm9ME4IdNBI0YZ6YdBSJXE5ykZmP6QQOKtNBykYFL/TeH6nOX4ri/
         Uz0Q3jJQta0zUKjvSyF2lNxeL0X9oSahiY2dNOFQrRyAWqhtMl+izapHKYdsSNiRELAV
         NRL6k9eCnfks+xQfkBtino4GQqq8IPYHSQWWERBX1DhZgaLXYCKHSc9wihGoDfRZ5o+0
         mt99CI2qM/8kEn0y/CqkVoGpOOpqtOj1FbR380vVKTpk83ujGaK/ZkXL1+sHO41PI+En
         vUBzcF1h9fVTLpVAQV9n8/s1U4aSVd92wspN+HW2fS1I5bWGhduT0VVhoCCWB7Zx/HyH
         eT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+c7EUbgBQhlzZ37NOreDYMAwd8bxw3irPCzpd3kWrE=;
        b=kPfIJ6vDBEzejVTib55mqmrSWj6Qvik/CaMQRHreWBz3UCUzWYoWAY6DuEOhjOO0uT
         7+U9aZNJo7uyvqOkx2Znr/i3hJZKu5/RI5QkE+6+eMl0pkfNpC8BWqDd3RnKOFhGlkKU
         bhsz6imv/QXelO6OlqRyDE31Uu97VPiXJ8jxGjhbEaMeO7WXr9qKL61OgNQhpSfeZ6bW
         fwImFF+N6fUyZEWMB5EI5oejoQDqMnjFY1DF85rjouWZkTE0lXxNNfL0aX1ijWZXuVg5
         ii++CY/IXJ3rjahsTmCCRvmU+230QsUEsIlQO/hQsqE39b74rrhNg3NOvMxpmXy8XENY
         a5PA==
X-Gm-Message-State: APjAAAXido5VQ6l/Teb43/00KITcn4rUShZ7t6zQwtXC0N4y2ReFHLjS
        aqpaqwtVcwlwqVZwAKmgOCo=
X-Google-Smtp-Source: APXvYqw+dciatO5GNWSimwPwvfx+GkadexGDSVXlmLIezPzMcRKJXzffRGQ5/NfbGb/tBQECadYRQQ==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr488971wml.45.1558987817783;
        Mon, 27 May 2019 13:10:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:16 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 4/7] ASoC: sun4i-spdif: Add support for H6 SoC
Date:   Mon, 27 May 2019 22:06:24 +0200
Message-Id: <20190527200627.8635-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a different mapping for the fifo register controller.

Actually only the fifo TX bit is used in the drivers.

Use the freshly introduced quirks to make this drivers compatible with
the Allwinner H6.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 045d0cc4b62a..54c09346d298 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -75,6 +75,18 @@
 	#define SUN4I_SPDIF_FCTL_RXOM(v)		((v) << 0)
 	#define SUN4I_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
 
+#define SUN50I_H6_SPDIF_FCTL (0x14)
+	#define SUN50I_H6_SPDIF_FCTL_HUB_EN		BIT(31)
+	#define SUN50I_H6_SPDIF_FCTL_FTX		BIT(30)
+	#define SUN50I_H6_SPDIF_FCTL_FRX		BIT(29)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL(v)		((v) << 12)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL_MASK		GENMASK(19, 12)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL(v)		((v) << 4)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL_MASK		GENMASK(10, 4)
+	#define SUN50I_H6_SPDIF_FCTL_TXIM		BIT(2)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM(v)		((v) << 0)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
+
 #define SUN4I_SPDIF_FSTA	(0x18)
 	#define SUN4I_SPDIF_FSTA_TXE			BIT(14)
 	#define SUN4I_SPDIF_FSTA_TXECNTSHT		(8)
@@ -438,6 +450,12 @@ static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.has_reset	= true,
 };
 
+static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks = {
+	.reg_dac_txdata = SUN8I_SPDIF_TXFIFO,
+	.val_fctl_ftx   = SUN50I_H6_SPDIF_FCTL_FTX,
+	.has_reset      = true,
+};
+
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-spdif",
@@ -451,6 +469,10 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun8i-h3-spdif",
 		.data = &sun8i_h3_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-spdif",
+		.data = &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
-- 
2.20.1


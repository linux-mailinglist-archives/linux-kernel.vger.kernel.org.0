Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA57D83F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 00:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbfJOWqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 18:46:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39659 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732798AbfJOWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:46:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so3693185pgn.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4jPbEpStvoUmUf7XK4zyw0nvt3WHJ3xzkcs9laO4hG8=;
        b=aj0nzXQuZcm5i5mM8hTJD3NkWTCcm+OlCa1ywD83GOYTxBrzgCF7KDf4QkLJsSTGYK
         +5Booo2zMkyajvtr3STAXfw2eAfgOyoq+2hD7onuTQduuaQDFCI5naZfz3lO6H+O3bTv
         0wq5kUq5L3tICbQDiYPASCPgPE6OlfTJvUKE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4jPbEpStvoUmUf7XK4zyw0nvt3WHJ3xzkcs9laO4hG8=;
        b=tvFrUhi2dvmSpL6DlCSE4HReOIX2xEgJmTy10Acuy7WFATa/49RjbQZtDEyOlaRXpg
         69ixyNCTWhW/d+qdS7XTrK4exskXixXbvcpQV5jYgxXzZjnMMMBZpplcwOI1wqCgcBT8
         60kWedJ0Qn6o5kcG/lU2GxudWo7ay5hyeawBgqAaw5rSw6wzOgGttNQHpayhtLKyLLEb
         EhGqfWDPQLOkbz0bkFsNzHehL0frJXwi7lXevju+HnMTkbOzJl8xqdhtzLKNd3/18q2o
         PZjN/y9Z7xZoYE/d8aS9Qt46tEWJ50pFbkD6l10AqUiVZDlJkmOo/4PpP+dcaVvZmXEQ
         3ZXA==
X-Gm-Message-State: APjAAAXNZIhIEh1vQWxe9N3x4IeriuhJJ/lnyuNu+dMslF+ObSp2T0tA
        X5DreufpOc9vpHb8cvF4NBj5PA==
X-Google-Smtp-Source: APXvYqz7J6nIBGHsc/tXWOzElPmlb8C4f2Qk4gnUSI7DZwt+tiNmtzDwY843yJy/A7Ju6KrAX9rXMg==
X-Received: by 2002:a63:dd11:: with SMTP id t17mr4184483pgg.242.1571179595974;
        Tue, 15 Oct 2019 15:46:35 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e127sm23019837pfe.37.2019.10.15.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:46:35 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] memory: brcmstb: dpfe: pass *priv as argument to brcmstb_dpfe_download_firmware()
Date:   Tue, 15 Oct 2019 15:45:10 -0700
Message-Id: <20191015224513.16969-6-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015224513.16969-1-mmayer@broadcom.com>
References: <20191015224513.16969-1-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than passing a (struct platform_device *) to
brcmstb_dpfe_download_firmware(), we pass a (struct private_data *).
This is the more sensible thing to do.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 3b61e7108912..f905a0076db7 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -582,21 +582,18 @@ static int __write_firmware(u32 __iomem *mem, const u32 *fw,
 	return 0;
 }
 
-static int brcmstb_dpfe_download_firmware(struct platform_device *pdev)
+static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 {
 	const struct dpfe_firmware_header *header;
 	unsigned int dmem_size, imem_size;
-	struct device *dev = &pdev->dev;
+	struct device *dev = priv->dev;
 	bool is_big_endian = false;
-	struct brcmstb_dpfe_priv *priv;
 	const struct firmware *fw;
 	const u32 *dmem, *imem;
 	struct init_data init;
 	const void *fw_blob;
 	int ret;
 
-	priv = platform_get_drvdata(pdev);
-
 	/*
 	 * Skip downloading the firmware if the DCPU is already running and
 	 * responding to commands.
@@ -811,7 +808,9 @@ static ssize_t show_dram(struct device *dev, struct device_attribute *devattr,
 
 static int brcmstb_dpfe_resume(struct platform_device *pdev)
 {
-	return brcmstb_dpfe_download_firmware(pdev);
+	struct brcmstb_dpfe_priv *priv = platform_get_drvdata(pdev);
+
+	return brcmstb_dpfe_download_firmware(priv);
 }
 
 static int brcmstb_dpfe_probe(struct platform_device *pdev)
@@ -861,7 +860,7 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	ret = brcmstb_dpfe_download_firmware(pdev);
+	ret = brcmstb_dpfe_download_firmware(priv);
 	if (ret) {
 		dev_err(dev, "Couldn't download firmware -- %d\n", ret);
 		return ret;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E366E6F82
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 11:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfJ1KLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 06:11:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40806 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732215AbfJ1KLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:11:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so6591198pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1p7hyilQyLC0LoGK1FT1eESXa0Fk3YdfBZS2estKH68=;
        b=cucz40bZRRrdO+e+HJGqz+I/9B2vU7e56mSOqqOdRHE/RZPibLqsfWu1ch2dr7DHX3
         lqPPvTD3byOFkERnOlHE0oRmOu4pFTqY5GSRau/NsxvRJObzn6E7FepKen7ivRt3F2+d
         Ct+POSt0czcTq39fvtm/uE0My3IEVK9mjVs8Bqqh+3Qvz1S9xL27OrRUcol4rYL1yxep
         68CjipFi3LIVl8MGlQ0IvZVKsKrI3qkkpagNYFnm5vNDRvwYkclnvNOHc69BwEokS6N/
         MKIIZE9HU94gwOF1hYcY9KoIHqtFyX8Rm44SzDyWvmKc2E54dhz8NYWoOFcl95/a9Zk5
         wEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1p7hyilQyLC0LoGK1FT1eESXa0Fk3YdfBZS2estKH68=;
        b=rPgoKM3be7Jj3wxG0WN6RajzbDvPptBNXRRZrFXADcnugzU9SdMWfFe9+TCWMsn7sC
         sbGsQRIyefctuh5zhAVWDfX4zfaxLWpbzzCHCkjqWuoyFHtjCLjey2E67YiVXLEvtwjm
         O1nH1Ck0yE40G3M63gpIC3vcW1Kd9NMsHyGQbK6gV9WZRDPOQ4pv230fcn9lW1TxFVbH
         eXtLzV0gzvcgM5UVbG+ePiEDVrg5vKEqhyKCSWjkoggH9XhcIvILGuRrF/HoDKBS4sbZ
         dQGF4KF12+nq/Rg3VEg63KNJQQbq6okt6mzn4fh0xAWYxgtFJzZq05iqrbuEmYdtxDlF
         yRKg==
X-Gm-Message-State: APjAAAVuPGhxPmw6gA4EO61A5dEf9kywT99WeoTDZiH6EEIXPMmLok9p
        w3d5+yq4SPEcTaBStHTc4G+2cg==
X-Google-Smtp-Source: APXvYqyUQbhozdji5PoUp9pBffE1WZ62zPZ70Ne570w03Yia1eFR4XRvUaRNh7fWaaSL77lSy1TF+Q==
X-Received: by 2002:a63:540c:: with SMTP id i12mr10145632pgb.322.1572257478956;
        Mon, 28 Oct 2019 03:11:18 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m26sm3071872pgd.87.2019.10.28.03.11.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 03:11:17 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, ling_ling.xu@unisoc.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: sprd: adi: Add missing lock protection when rebooting
Date:   Mon, 28 Oct 2019 18:10:30 +0800
Message-Id: <7b04711127434555e3a1a86bc6be99860cd86668.1572257085.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

When rebooting the system, we should lock the watchdog after
configuration to make sure the watchdog can reboot the system
successfully.

Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 9a05128..9613cfe 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -393,6 +393,9 @@ static int sprd_adi_restart_handler(struct notifier_block *this,
 	val |= BIT_WDG_RUN | BIT_WDG_RST;
 	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_CTRL, val);
 
+	/* Lock the watchdog */
+	sprd_adi_write(sadi, sadi->slave_pbase + REG_WDG_LOCK, ~WDG_UNLOCK_KEY);
+
 	mdelay(1000);
 
 	dev_emerg(sadi->dev, "Unable to restart system\n");
-- 
1.7.9.5


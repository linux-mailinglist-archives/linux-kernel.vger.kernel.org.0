Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6336511901C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 19:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfLJSza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 13:55:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfLJSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so21339861wrh.5;
        Tue, 10 Dec 2019 10:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zGMvJWZo3bb5zgamkdnRKaVLQdrbvMefeySxvLbMI38=;
        b=aje+hkE/+cZZU+/Ppdll3mTIUW8qKLA/5x0PZcMiq9tm8zyH+AGTKB3VKONQeMMb0x
         lwQPhevBddVLD4SciVMGl2Bj4TVXtoiH6BoGPS44K78xEHxShUwpYMahFEH0++K6dn00
         +8CJKs1LOJfc2AC7LUq+yr23Ih8ey/yE5GL9qZUYROTj/suTP/ln0TCT+RT0ohpm2Lu9
         gJrEoia4D4eoAqwXWZdmzG6svXXmpOFSRKRIveCibqU2K+Z0AUbT69WxDyrlC64PYfPP
         J0frDKrvRy/uoumh6+aEYeteQ+72B0B+qT0yqyLxbvH+GUGS3WwmMpCwn+1iX00I2f3c
         bigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zGMvJWZo3bb5zgamkdnRKaVLQdrbvMefeySxvLbMI38=;
        b=XhxlvcH3tVa83xUTBaAZJGPGG1LJ0NS1aK37qFp0IYpu4J7NClSBI7JHNW+adYefYv
         vUbzUL5mjcxZJVZ43/MsU66FTJXgcI4n463R3eCpq6FsMBp+lRLPd2qEnTq7kC84Pivy
         Edu5ObRrEycsDKoy8Vl2S6cvsAtxQ0npiEpr7JvOaQ/cB2vXs5WlZPhKcSSSi7csx8xk
         IBGZkBMT4d1uZPQVsFB7cHIV3WkEQr4TgTNYpqA3x9kEaNbs7IoD3OQGnaW816QK3gA8
         HA9GaiE/9qtlMT+hc7YwGZtmNksIXa8U0x9wHkhO3Gkw3QnBee4Z4rAHc5rmt3zCbsPh
         DtYQ==
X-Gm-Message-State: APjAAAUPNA18z2Ha2MhOvSkEWZKSon3q2FW4mTXK6n69JN4ik2ZZn+cu
        toZs9SxeE3QRihMWlonrPu9NTX/W
X-Google-Smtp-Source: APXvYqzIS8G0PdjjpBmf61HE3iOGZM19FKt+i8oHcpYPbW7+AdFkhjQQuMhi7akcabIgkfnvSZTsTQ==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr4764181wrv.291.1576004125685;
        Tue, 10 Dec 2019 10:55:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:25 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 5/8] ata: ahci_brcm: Manage reset line during suspend/resume
Date:   Tue, 10 Dec 2019 10:53:48 -0800
Message-Id: <20191210185351.14825-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were not managing the reset line during suspend/resume, but this
needs to be done to ensure that the controller can exit low power modes
correctly, especially with deep sleep suspend mode that may reset parts
of the logic.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 66a570d0da83..76612577a59a 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -343,10 +343,16 @@ static int brcm_ahci_suspend(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
+	int ret;
 
 	brcm_sata_phys_disable(priv);
 
-	return ahci_platform_suspend(dev);
+	ret = ahci_platform_suspend(dev);
+
+	if (!IS_ERR_OR_NULL(priv->rcdev))
+		reset_control_assert(priv->rcdev);
+
+	return ret;
 }
 
 static int brcm_ahci_resume(struct device *dev)
@@ -354,7 +360,12 @@ static int brcm_ahci_resume(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
-	int ret;
+	int ret = 0;
+
+	if (!IS_ERR_OR_NULL(priv->rcdev))
+		ret = reset_control_deassert(priv->rcdev);
+	if (ret)
+		return ret;
 
 	/* Make sure clocks are turned on before re-configuration */
 	ret = ahci_platform_enable_clks(hpriv);
-- 
2.17.1


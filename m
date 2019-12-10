Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50E119020
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 19:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfLJSzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 13:55:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37356 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfLJSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so4413501wmf.2;
        Tue, 10 Dec 2019 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMN6HasSUrZjdtLofZk55AQ4vWrDosUhaoGmITPUruw=;
        b=N6OcGoP2//bOSKN/C0LkpKHYEx2GCJWt/G7nnQxkK5nBgqLkCPfGnYoc8x0wN5EF72
         AIamhHDO9meWhDiSzAVBn2LrVkJTRLaOGzggXQAnEuRNlUzqoCFC0TNmWZl08vnQCoas
         wObGE4wqtbw1mj69aeB8Sa9cLDX6k1LfX+4aXdQAMYVUFRTPdAGld2Msx0pbr4orQ8Fq
         4l27QWvtciXYq7rbFWOUfG3orjyIbycWidiIZEYzG6JWLPJcDTCfzDtvEcV6y4mjdYR4
         ySodLRRV1D9rleVYfzlsYxGwU8FTevKfnKQWYf/v+L2iWNuR4Sj83ewPsN9PaSgo6Ul+
         9Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMN6HasSUrZjdtLofZk55AQ4vWrDosUhaoGmITPUruw=;
        b=Ik3w5CHsLVtGqp04TSkVvgaFB/xanl+9w5QZzrqJixZOeYznevfoh/OgxoPWhJklY9
         Y6454R6wnBs9czSGJhB/GiJD6FtlSszfHDarPdI9WBfrRYyJZLabk5nZqoDTtlE/V9pM
         VEvzXaEdJ2buYN24UhcoKCI5T3ddgbosbKvFmynZS48o+3FVI54hgMlhQbY6pjo21g0b
         ZleKflNh/R8EpM1cstq5rRkcjgdl3A8b7sULdZxizNorwyxtLV2yFB33tfA2uBvoQ0bR
         ogwPoXZaVs8dmk3m2XIFcKD1P/LTFmiFylfaUk8eOgnPfJTHJxfPH+A6y4UXOl5Mq24g
         ylJA==
X-Gm-Message-State: APjAAAWcCuIBT6IJkJyHvR6IQDDUzKLNJrxxIhTKPBELiRQUOfe7rS1p
        khNlJpfU5rfp9EmmW0k2aVdMT065
X-Google-Smtp-Source: APXvYqwvZzO8JHumxzd0awYSiQe8a+UtB87swX6SrfJGACOtIOliudtPwPNlG5qFoIdU2iNZotugcA==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr7027735wml.71.1576004128685;
        Tue, 10 Dec 2019 10:55:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:28 -0800 (PST)
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
Subject: [PATCH 6/8] ata: ahci_brcm: Add a shutdown callback
Date:   Tue, 10 Dec 2019 10:53:49 -0800
Message-Id: <20191210185351.14825-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that we quiesce the controller and shut down the clocks in a
shutdown callback.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 76612577a59a..58e1a6e5478d 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -532,11 +532,26 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void brcm_ahci_shutdown(struct platform_device *pdev)
+{
+	int ret;
+
+	/* All resources releasing happens via devres, but our device, unlike a
+	 * proper remove is not disappearing, therefore using
+	 * brcm_ahci_suspend() here which does explicit power management is
+	 * appropriate.
+	 */
+	ret = brcm_ahci_suspend(&pdev->dev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to shutdown\n");
+}
+
 static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahci_resume);
 
 static struct platform_driver brcm_ahci_driver = {
 	.probe = brcm_ahci_probe,
 	.remove = brcm_ahci_remove,
+	.shutdown = brcm_ahci_shutdown,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_of_match,
-- 
2.17.1


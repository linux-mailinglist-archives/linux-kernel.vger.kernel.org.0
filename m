Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21D916A10B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgBXJJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:09:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35913 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBXJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so4813515pgu.3;
        Mon, 24 Feb 2020 01:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GajakFXyxMUa9GNvnGruzNckL7Z3CRJUy+Vqs4Yc4uI=;
        b=TVJhfUQoGV593qut6pCiS/bCkZgzc7RtJeAtWE9Uz5zqFFd/b42P0f30AVI6Im20JL
         1tBQogDqHgVi7A5ig4oxX7GqP0XCnzhojJuQf5koMb6hCIn6do0B/LWBg04MQOBl5JX2
         Y0bC36gaebvgxHMiGB3cb0z63mbBon8aauz9PipRLcZ/2sPgIx5+Yx7V3pFxiA23G0X7
         Td5RIFboO9BnaKISaPlgxt6yyucrPy8EKg917V9LwjH4BziziPEYp6AXOTRKWJW1aqDW
         PdWOdKtS8owG/JSWK/VqeTd0pNUW8rEl92PNYpwTxhOhK2S/0JQo2my3V/E/J16PwJlp
         RwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GajakFXyxMUa9GNvnGruzNckL7Z3CRJUy+Vqs4Yc4uI=;
        b=juJwC3Gut22hji8QD8o6xPzxkAKTN3KbratDkA90E+BlrNybaMdjDbrcjWhvKlv7OA
         FJr5GCopPTVbpjBS7DbXlCHYLACwOzkTS6mmEAaKNiAoTEOZE5Y26Fr2jC9GiCafiHJt
         YjG3cr5qF5iDaagZ0JGE81ueZYihvA4kA0r4mspQcOmOkcaGEmo8YPwmyq3q8d6T18AR
         jhIWZ/IHp/XwvHVD8121h4DJ9DDnnl0L270FZDioUdUHBPtmuz+KgRS9yPRo2rcKW7q2
         BZ6dTKfGmFvO2GS2ceYBA7on3t1vd5qalLjavbgEZcwNDwNLNzAeUPje3UQVrHUBfcyZ
         EeqQ==
X-Gm-Message-State: APjAAAWkUQlgW5HIXJJvSDBSoAZxN3aWByYrowqZyDvMyYR4h6NGGnPa
        WBbOqqpFO6v8Rgr3Rtdt7vc=
X-Google-Smtp-Source: APXvYqy+7zLvfzNMJy6gcXf74WOA+gfoYUuV3jX3LYG4EOi+ogkHGDKa2vIarB4A5dQhlzlKd9EnCg==
X-Received: by 2002:a62:1a09:: with SMTP id a9mr50691454pfa.64.1582535341020;
        Mon, 24 Feb 2020 01:09:01 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t17sm4521674pgn.94.2020.02.24.01.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Feb 2020 01:09:00 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: sdhci-sprd: Set the missing MMC_CAP_WAIT_WHILE_BUSY flag
Date:   Mon, 24 Feb 2020 17:08:49 +0800
Message-Id: <96f16647f6a6e8cb058c44e46c61b122df027059.1582535202.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum host controller supports HW busy detection for I/O
operations, which means when the host gets a transfer complete event,
that always indicates the busy signal is released. Thus we can set
the MMC_CAP_WAIT_WHILE_BUSY flag to remove some redundant software
busy polling.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d346223..2ab42c5 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -556,7 +556,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		sdhci_sprd_voltage_switch;
 
 	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		MMC_CAP_ERASE | MMC_CAP_CMD23;
+		MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto pltfm_free;
-- 
1.9.1


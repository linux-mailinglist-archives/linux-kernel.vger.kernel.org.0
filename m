Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71442141BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 04:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgASDuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 22:50:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45430 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgASDuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:50:05 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so13994764pfg.12;
        Sat, 18 Jan 2020 19:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZ5T5UfJAQJwU5MzOJB4Yvh3UEefL9B9keDh3VxMHPs=;
        b=t4mtc3amxopGywAWkZqoZtv/mHuTlllXRwI6sX52MewkHrKOOI5+rZHWRrRto3WjKN
         cj5X3IhWIJ4WdVCLuF9sPjhXYbvIBM6XzylDFE9F0a7Vlj4ya/4D3B+Ujz5HVBFI52n3
         iTPmt/c50xoQjhjXxke0+rNJGMmhkLowBvoXzUDmqJi6BW/tgC1mtBzsc3Z0NEdZC+sd
         eeve8wGELp/UuiA4PiEz7x8IePkw3biEhYlOMGUg7HXxGQYFhDrWjnc3BhhrU602FBYM
         QM1wx6Emk7X35rYg6alUeDnM8tLKB/C/WLmWOTTb8pqSQ8YlXODVVspdgtrp0lqrzmYS
         wGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZ5T5UfJAQJwU5MzOJB4Yvh3UEefL9B9keDh3VxMHPs=;
        b=gBVizkjPAII6TzmMC1pvNIDxlgLQnwNg6K4TYysjqpVq47xZAMJkXxKXceyesXI+Yp
         6QgyPclIr2kAdHug41bmEx2sp8Z2NfOOTTqPvSCaBqCSTcenBjnwuoynEs2E2QeTF7ic
         qmfDW7mgj+lqU7Xjvf903luoNVeMwcCNet7GgxgN9xAxsNN76Gug3OXbLnV27xbBEnoT
         WUi7WvEmhBhMl8YwyhZTDnGswrcolAgdzKkK+gJ/yIZiHX15Sf4na0khlKVNE4lujjH7
         YCNHwnWe3O3y6lrmVrwl2aVaOk8dFC1Lb7k97wYumzg0WAp9t0cVmUAZIN0TRHLfJt5I
         oxaQ==
X-Gm-Message-State: APjAAAXW2E342+5IRW6sr6yvyIfzHVcgJUuoRObvZy/UZbyehaF+1Rq0
        ULdoSj9AGZE3PW+oc3GgOV0=
X-Google-Smtp-Source: APXvYqzSlkpFIebImLyEI/U5zYhbjiRWFjKvEXDA8jNQCknif976ZwYQmGZnZs1hBpLhRizaVyPAuw==
X-Received: by 2002:a65:4206:: with SMTP id c6mr54128856pgq.46.1579405805266;
        Sat, 18 Jan 2020 19:50:05 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 144sm36126980pfc.124.2020.01.18.19.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 19:50:04 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
X-Google-Original-From: Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] mmc: sdhci: fix an issue of mixing different types
Date:   Sun, 19 Jan 2020 11:49:02 +0800
Message-Id: <20200119034902.20688-1-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue reported by sparse, since different type of parameter is
used on calling dmaengine_prep_slave_sg().

Fixes: 36e1da441fec (mmc: sdhci: add support for using external DMA devices)
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 30b5a624b50e..4503009f993b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1235,8 +1235,8 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
 		return -EINVAL;
 
 	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
-				       mmc_get_dma_dir(data),
-				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+			(enum dma_transfer_direction) mmc_get_dma_dir(data),
+			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc)
 		return -EINVAL;
 
-- 
2.20.1


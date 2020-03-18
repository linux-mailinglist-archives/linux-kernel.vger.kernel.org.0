Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956D2189F92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 16:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 11:25:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56131 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCRPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:25:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so3868015wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=nab/6yTyXyAvQS5wvzCsXOFKPhMnWoE9hRGSnfG/O/U=;
        b=oDZH2AI1geJDKc2hNLj03MFjQNBoAC965fStJ+rKJG+IX/+5cu4NeJusNWhq7cMSr2
         AkgSVoRdoKFIp4bOJBbWe8P9a8C8KnKetzn5nJjpq9mu4mvkQJtEKPGHSox/4Knjnxh6
         nKabomFkcAe2n7ALhgF2Qgx4VaCz4e+yjHaNrBe9jUso5okE/4f4LRMRtI+lmeFOR5sQ
         23y8whNXTerFt/xeS1rMD64zs1olpvYlPazR5b1hgqrvLN9tSa1Ofw2XkzFJi0Hu7c+V
         +iDhNmnA8/k6axU9IyIIGiXj16GO7VQZwc/3B1dLARSytOvLOcYTDvqK4NRGGRbcmUJd
         PmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nab/6yTyXyAvQS5wvzCsXOFKPhMnWoE9hRGSnfG/O/U=;
        b=eNEx0Z3oghkPBUq6ZbBq1e1rcY7CoxICqejzIqLjOs+Tv4OObCoRIs2dCCUEP41Wmx
         pp3bjfnZXOoOMOCGLGXLWvCZTnjgetPJ3WiNNENHA4UWW4fza1Rc41cPrYkpmeRoBEuy
         UHz2odlFlPliUaHOXKR8fXI7Ft4rSxE6u8XWn8gg3BF90ucQBal3mTKp3CiAI/fqCwBc
         5k7SVdSGckCnIZT1JRZIZad2TrJy25E/E6OJ1ho4mEOB9y6Yk07semCHKQ2Y15hyDfc2
         bsGQusQkAaxbOvlcEp2TjZP/2AZ0nyTK/yjZq5C8vQ5vqAKCcif0hLZuZSBQkz24XtPZ
         ZeVw==
X-Gm-Message-State: ANhLgQ3ML/dcYyV0QtXXbiQAp7IlOV8oX8/fklhgJxnSPao7Ia0l7gOF
        ApItToeAGHa7kRizLkdXqWnvJVd9Nlg=
X-Google-Smtp-Source: ADFU+vtG5bw8E90hbIOPGoH28YXVsfwUmdGhXR28j/CWC/7TvD0xA+OrQfwWjbc0BJ9lY7yLu4sfOA==
X-Received: by 2002:a1c:9e97:: with SMTP id h145mr5673353wme.36.1584545118593;
        Wed, 18 Mar 2020 08:25:18 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id d21sm9785085wrb.51.2020.03.18.08.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Mar 2020 08:25:17 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     avienamo@nvidia.com, jonathanh@nvidia.com,
        thierry.reding@gmail.com, treding@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] soc/tegra: pmc: should select GENERIC_PINCONF
Date:   Wed, 18 Mar 2020 15:25:08 +0000
Message-Id: <1584545108-20111-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have hit the following build error:
armv7a-hardfloat-linux-gnueabi-ld: drivers/soc/tegra/pmc.o: in function `pinconf_generic_dt_node_to_map_pin':
pmc.c:(.text+0x500): undefined reference to `pinconf_generic_dt_node_to_map'
armv7a-hardfloat-linux-gnueabi-ld: drivers/soc/tegra/pmc.o:(.rodata+0x1f88): undefined reference to `pinconf_generic_dt_free_map'

So SOC_TEGRA_PMC should select GENERIC_PINCONF

Fixes: 4a37f11c8f57 ("soc/tegra: pmc: Implement pad configuration via pinctrl")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 3693532949b8..6bc603d0b9d9 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -133,6 +133,7 @@ config SOC_TEGRA_FLOWCTRL
 
 config SOC_TEGRA_PMC
 	bool
+	select GENERIC_PINCONF
 
 config SOC_TEGRA_POWERGATE_BPMP
 	def_bool y
-- 
2.24.1


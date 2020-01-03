Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13A412F2A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgACBR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:17:57 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40465 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACBR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:17:57 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so4075400pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 17:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DC9VSwlhL0N/YPRwix5EBAHxHcNpcMljkAxlNuK95w0=;
        b=RbBEYaw0P5wuMiO0yKp2g3L1uXIy0bSk1wxT40I52Lb1+HeGjZeZO/hC6/dBcPtMX1
         sYZxlAJ0oA/z18XSDj2VMfoPCv6p2Z9Fguz67e74kP4vV6mYRpum2ySLiH6qpbIiMiDB
         kHsjDKsM88yYM68O6cMYqVjDcpk5Etn1Dk/SHhJqmhayQEDNLl+2xTg/DsuQGZQLk3Cs
         EMIelmhY4CUtpnJLVHXbHqFoIieIRfJwkoos1ovFeP1c8e6MSi1HUKSr9SP/I3MSUTWf
         +xTJ9lA4dt4NeWEU4+u2UWs7qjXp9lohWHnqyDBCbtf4zC0Z/ZvsNHmrfSRN+Fii9rmO
         /Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DC9VSwlhL0N/YPRwix5EBAHxHcNpcMljkAxlNuK95w0=;
        b=EabQ3op6A0pVKamY9w5QQmv0t1PsgEpW8f0eUBNKD7OpK2cW5pyKAhWqv2MmOIoW9A
         k1EtHVrfD9QIvzND8vVe5ZLGQVJ+JS1E5JpFlooSyNXC0z54BBhW00oK/B4LVSbZD0SI
         KeMffxSJKwgxpQcXj7mYbmI47eHiNnXCyab9axvXkr3DMW4pijmPbR1jHSU/Nvl//MyF
         lW546WoMaU+ztySbO/PG48m8thX+DI+yeri1jHX6/Un5zZvyqfz4hoENjLoXWvRNZ504
         3pRn8vKpK7Gyu5JYotKMMVVnfRBlPMH2kdV0r+eik9pxLMjCB3/pgtma/CaTaqCnvBBy
         6PZg==
X-Gm-Message-State: APjAAAV1VDVZY5Yug8mUWf0tkT0sGSqQRcz9HgTNzb4PbeZLuZMVFJmf
        WqN6fu+fPTSarVQT5BU9vtE=
X-Google-Smtp-Source: APXvYqwi3rFKCLRbMO3l47X9oVeJsrXzYJ+GNdaDQrJ9shPUWFSTFKPZFXu/wy639wGXv2JgFy5iQQ==
X-Received: by 2002:a17:902:fe98:: with SMTP id x24mr88927208plm.155.1578014276672;
        Thu, 02 Jan 2020 17:17:56 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l2sm12234208pjt.31.2020.01.02.17.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 17:17:56 -0800 (PST)
Date:   Thu, 2 Jan 2020 17:17:54 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: switch to using
 devm_fwnode_gpiod_get()
Message-ID: <20200103011754.GA260926@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_fwnode_get_index_gpiod_from_child() is going away as the name is
too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index c0d322a859f71..4495834e37653 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -998,10 +998,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	if (byt_rt5651_gpios) {
 		devm_acpi_dev_add_driver_gpios(codec_dev, byt_rt5651_gpios);
-		priv->ext_amp_gpio = devm_fwnode_get_index_gpiod_from_child(
-						&pdev->dev, "ext-amp-enable", 0,
-						codec_dev->fwnode,
-						GPIOD_OUT_LOW, "speaker-amp");
+		priv->ext_amp_gpio = devm_fwnode_gpiod_get(&pdev->dev,
+							   codec_dev->fwnode,
+							   "ext-amp-enable",
+							   GPIOD_OUT_LOW,
+							   "speaker-amp");
 		if (IS_ERR(priv->ext_amp_gpio)) {
 			ret_val = PTR_ERR(priv->ext_amp_gpio);
 			switch (ret_val) {
@@ -1017,10 +1018,11 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 				return ret_val;
 			}
 		}
-		priv->hp_detect = devm_fwnode_get_index_gpiod_from_child(
-						&pdev->dev, "hp-detect", 0,
-						codec_dev->fwnode,
-						GPIOD_IN, "hp-detect");
+		priv->hp_detect = devm_fwnode_gpiod_get(&pdev->dev,
+							codec_dev->fwnode,
+							"hp-detect",
+							GPIOD_IN,
+							"hp-detect");
 		if (IS_ERR(priv->hp_detect)) {
 			ret_val = PTR_ERR(priv->hp_detect);
 			switch (ret_val) {
-- 
2.24.1.735.g03f4e72817-goog


-- 
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50BF12DFCF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgAARuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 12:50:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34211 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgAARuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:50:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so37390548wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 09:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=No6+pF/29hbexfyxLIzSLoDPs3T39QBZzwsgULMLjzI=;
        b=NXurigMwYAQN2BXM6VE1oNj59pJfcDf/GmwRuLupHEIrV3Fb9IKI1Jibo7AC/IN0xt
         gLz5S7HZCZxFNpxkwx/W19965ayR3mAbUXbXkTC0QY5RjSM56QyQpbb2zXbRMf1BLE9h
         7lOkj89n6yrb1g7sYGMj3hO6FhJt8SCllSEmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=No6+pF/29hbexfyxLIzSLoDPs3T39QBZzwsgULMLjzI=;
        b=kAEUdVaFSehgSydvXw4ItZCDQJwlbLPobFnu1yFiGte9SGOZky4og1GvlqGqgahKbA
         60/mEh1nWfqt5iTIfthWxmmpmKgEXrO8RCHEpIi00y6lkIhptxis/FsSqQ/3q29XZh4R
         2Jp+RiHUuQIy3vQRKno2vdYfiStNrvXamHQu5GgUXJgWeUmKsr1LHtCKo7wEbEavClTl
         xo+nt3E6o82YKTBNBRTYxkxOArXRowEB8JsUz6hsAGZLABgb56cMun1RnCJM2LVqs4gK
         fpeggWVUf7qa9gzH9nG+GSsSRmnkOTqcSLUsz1yeLJN+aM4GyMH38IRhlAYKEgiJiI4+
         bnTw==
X-Gm-Message-State: APjAAAUKX7GVswG2lDi0rVrrD/kRpgaL4TjKC3qW6ahnvUe9w7LgyeQO
        SLUMKtPvDPTeCME4BnOIk+v7Fg==
X-Google-Smtp-Source: APXvYqyHk5wszacOXxFJy13iANAkqZjsEnRI8ddi99VniJ5LfU8EKyJIi6TsS/cwaTsfA3cedckmEw==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr36319687wrq.129.1577901014081;
        Wed, 01 Jan 2020 09:50:14 -0800 (PST)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id r15sm6025085wmh.21.2020.01.01.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 09:50:13 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] crypto: caam - add clock entry for i.MX8MM
Date:   Wed,  1 Jan 2020 18:50:11 +0100
Message-Id: <20200101175011.1875-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101175011.1875-1-michael@amarulasolutions.com>
References: <20200101175011.1875-1-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock entry needed to support i.MX8MM.

[    1.040682] caam 30900000.crypto: Entropy delay = 3200
[    1.045935] caam 30900000.crypto: Entropy delay = 3600
[    1.118813] caam 30900000.crypto: Instantiated RNG4 SH0
[    1.186476] caam 30900000.crypto: Instantiated RNG4 SH1
[    1.191726] caam 30900000.crypto: device ID = 0x0a16040100000000 (Era 9)
[    1.198434] caam 30900000.crypto: job rings = 3, qi = 0
[    1.222717] caam algorithms registered in /proc/crypto
[    1.231297] caam 30900000.crypto: caam pkc algorithms registered in /proc/crypto

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/crypto/caam/ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index d7c3c3805693..ab8df3b550a7 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -99,10 +99,11 @@ static inline int run_descriptor_deco0(struct device *ctrldev, u32 *desc,
 
 	if (ctrlpriv->virt_en == 1 ||
 	    /*
-	     * Apparently on i.MX8MQ it doesn't matter if virt_en == 1
+	     * Apparently on i.MX8MQ and i.MX8MM it doesn't matter if virt_en == 1
 	     * and the following steps should be performed regardless
 	     */
-	    of_machine_is_compatible("fsl,imx8mq")) {
+	    of_machine_is_compatible("fsl,imx8mq") ||
+	    of_machine_is_compatible("fsl,imx8mm")) {
 		clrsetbits_32(&ctrl->deco_rsr, 0, DECORSR_JR0);
 
 		while (!(rd_reg32(&ctrl->deco_rsr) & DECORSR_VALID) &&
@@ -509,6 +510,7 @@ static const struct soc_device_attribute caam_imx_soc_table[] = {
 	{ .soc_id = "i.MX6*",  .data = &caam_imx6_data },
 	{ .soc_id = "i.MX7*",  .data = &caam_imx7_data },
 	{ .soc_id = "i.MX8MQ", .data = &caam_imx7_data },
+	{ .soc_id = "i.MX8MM", .data = &caam_imx7_data },
 	{ .family = "Freescale i.MX" },
 	{ /* sentinel */ }
 };
-- 
2.17.1


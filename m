Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5212517D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 20:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfLRTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 14:10:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45823 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfLRTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:10:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1718309pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+shghrwvHSuaCCAe91cOcF/cABrNe9ZFXBpEs6T1pk=;
        b=pZ8uPDUyofDjdToN5t1zFX7EOUoQHgElefAtWAY2a0xE3C+UzywVgYFh1cRo//8ldK
         dkxGA87VEybp7sOpx7eGEyvPyE02cVpzJh0Sz7GwLzhuxvhmE39bwoNFOrYIt6IIko8w
         59oJZCYsccwqdnIMNu4JjudoACBiEOxWsVD3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+shghrwvHSuaCCAe91cOcF/cABrNe9ZFXBpEs6T1pk=;
        b=rKJcm+7C4buEO36S9PdfHM8zjYs57hg4d6wOj2g4tTvbrk4g879AY016zpyhaMZkla
         Ml6icJhuO6sS3zJvdSSVv3xEzpElIGPC+EMGta8ZW3z3o7RVbT4fk3HpcfhRrDlx9gQA
         NcdMzitOz7+roz+nsLlF+T7vqpDlu67MXCYDZwQopAf77+jK3VXK1cvXmhYqWQ2Fnw6u
         RG+KpmxxM0WQjmfC5x2HRFe76jqFxtWkPc4hETq3XNCfOpel3MIGz7xUBMvMQFFetnq+
         rsermKpwB8yEigt8q7TyJhkkh0yumYQMMs32XEsKpGXqJZ5Vw5ZEAAzGrpJQGrA8dOBp
         b1xw==
X-Gm-Message-State: APjAAAUqKkHwKJwFJZOMy0goQB+1jUJYsk67vxlouzw3N541AtUVsy8k
        Jp8x/iKawR9rSxGAQqsb2lSdTw==
X-Google-Smtp-Source: APXvYqzWo+135srItLCIbQetR6+zfji/31rxO3bMV0dn+U+qlizWEE04ek5zqZbLuYJfUG+Gr29Dsw==
X-Received: by 2002:a62:c541:: with SMTP id j62mr4808803pfg.237.1576696249620;
        Wed, 18 Dec 2019 11:10:49 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:78ea:e014:edb4:e862])
        by smtp.gmail.com with ESMTPSA id q7sm3745855pjd.3.2019.12.18.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:10:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v13 5/7] drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
Date:   Thu, 19 Dec 2019 00:40:15 +0530
Message-Id: <20191218191017.2895-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191218191017.2895-1-jagan@amarulasolutions.com>
References: <20191218191017.2895-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so add compatible
for Allwinner A64 with uninitialized has_mod_clk driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
Changes for v13:
- update the changes since has_mod_clk is dropped in previous patch

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index de8955fbeb00..8669d5f0e744 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1264,6 +1264,7 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
 
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-mipi-dsi" },
+	{ .compatible = "allwinner,sun50i-a64-mipi-dsi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.18.0.321.gffc6fa0e3


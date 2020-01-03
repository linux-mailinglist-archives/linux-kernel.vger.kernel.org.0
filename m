Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 264D212FC42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgACSTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 13:19:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34831 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgACSTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so18448622pfo.2;
        Fri, 03 Jan 2020 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=vB48KKzajgF0TdWQFeNgtIHOSjWfmrSCxxblLZl9BdQYP7K7bDNHn/pvbTxZ0XEyuA
         a1P28pDCd2An1QLxjD4z2AoGtK+buld4Ddw76w+9I6BzMmXICtdYtBw8ANmUkJF94v2y
         eBHJk5eR7N+9d1q+mefG478YaydsRUEVLA72oe8zzqhxx1VUX9D8/S19iwLo/J8o2zKw
         liRG7dx5PHCxK0+9lBH7eOgXGwEDHgum2zxUc1OsyYbbBV0Qrwhax6VzXF7hpCaeMlNb
         9wNYAZ7k4bmbLfDIffpzPBA84JyBzuSRodAGeI21S5pJKibERgB5IBettK/GN1soPrRS
         wnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=pi+W9i+dmw+ItU5uzjSSr3xFZrx+JxpSprMC2AEj3XPpZUUpAPVYu2ucwZbX+Yckrv
         H4hYFpjhbC1/2e7rYvui6somk47KDm8QQkzDDb2qjwiaIOl/S8cz/YczRAs3tah6fxCE
         x3Bz0JGU7eq9ZProOwqdaWKNdOafULr/Kw9ysGwsxMca5Ly8wVm/zXv4WerGU1VgIbTy
         lez68ix3LlFBDflV36QjmuMbyBIp1wstAP6x7HsdO/KJECmnBiP5JEp0Na5PszsFO/HJ
         EEfwfspmRaG8gVAuhvwmSDDZyEFb8fpi4mDTP0USfOzCd1hXIdnzjsmq4QGIKP9gyl6j
         iPcg==
X-Gm-Message-State: APjAAAVfDyIGJzcUVjK5prxSlFYxntCH7tZ8cQZ7AbhHDZfvHaMpcyg9
        8y3A6cDTYiL2JIc8pgDEvRShFN4b
X-Google-Smtp-Source: APXvYqxnOuW+7U6eGKXIMR0ijUF5NkCQefanxaJ3IyaESoBBixKe2pCIAFqqvJqbCksTyWdPcOxPdQ==
X-Received: by 2002:a63:31cf:: with SMTP id x198mr96136045pgx.272.1578075583530;
        Fri, 03 Jan 2020 10:19:43 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:43 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Srinath Mannam <srinath.mannam@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v4 12/13] phy: usb: USB driver is crashing during S3 resume on 7216
Date:   Fri,  3 Jan 2020 13:18:10 -0500
Message-Id: <20200103181811.22939-13-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a result of the USB 2.0 clocks not being disabled/enabled
during suspend/resume on XHCI only systems.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index cc5763ace3ad..1ab44f54244b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -543,7 +543,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
 		brcm_usb_wake_enable(&priv->ini, true);
 		if (priv->phys[BRCM_USB_PHY_3_0].inited)
 			clk_disable_unprepare(priv->usb_30_clk);
-		if (priv->phys[BRCM_USB_PHY_2_0].inited)
+		if (priv->phys[BRCM_USB_PHY_2_0].inited || !priv->has_eohci)
 			clk_disable_unprepare(priv->usb_20_clk);
 		if (priv->wake_irq >= 0)
 			enable_irq_wake(priv->wake_irq);
-- 
2.17.1


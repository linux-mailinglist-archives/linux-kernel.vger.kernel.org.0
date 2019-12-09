Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A381178B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 22:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLIVoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 16:44:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37438 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfLIVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:44:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so17912065wru.4;
        Mon, 09 Dec 2019 13:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=r0A9QKGNMVItckScTkm0GdDW0YuEXqS+mWFFB49B7SLYshVDaeyKf4ZpB4QeGxE8XA
         5+nzpikrhCWpn+n1wHy8QlbOKgjiybhyB/dzbwnzY2gYFAeo/fY7yPapKGimk+rHc/Sc
         3I5KpwwbRsdQL8L4Va6rwrhwU0yqm5ubZhCMe8VtHNQvuo5WvGk8ysw4SblV6o2BZbq+
         X6yWD1FnuJxO2C8d1eAOSpUqfsxAGzTgmfQGczuI4fMIl2EEO7uCu7llTkhKRzE3GYXq
         /rw2V3pdlUnztCTkd7W6qXiGTiJnqNlz8r6kHc8gvZbOHQwemA2JdDbwIfd+JTWhuq/+
         AxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=k13JVqtp/8x2Qi3/qiYTHYBzGmUKODVtEDNdhCYD0kUHsHPGtsLmQ5DspAg2zJBrfP
         iOTlo0jn0DQ/44g4PmAyxixGJ/IAC0f6qp4NAKtZQXbKkALSeAS1neSWf+X+WGohlqTD
         ABoAXsb5P7gIt/tIayPUbrWvJWGZylevj/H/VLsAHkIGIPjqbHvCzsIlPUIxbiqpHGVV
         y4f+8DhL3HnaIs04kysNeqppSbCwwu8RXhkvW9UvoOf6EX92yEsbyyUSZHmVeA6qXz8T
         /wobAKkQcknL78LDACGP0MH8iSM6QJ+v+Dfzis5ZBErdRCd3YkbeI53PQYPnzbyjwzEa
         Vvzg==
X-Gm-Message-State: APjAAAVs0EqHjY2EBfdrUvuGVi7CdzPylqcHZcADt+WwasMvxGKAm/nY
        Tpui9DRFZ3QP+R8e618P0fKhvXSW0no=
X-Google-Smtp-Source: APXvYqyu3cOe/0n4P9H5DreM7NJRC8ZUn5q2kGRq9jniAUbcNpT+ByFsYPc5sfvUpG+LJIoEcxidHA==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr4118184wrw.370.1575927858126;
        Mon, 09 Dec 2019 13:44:18 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z6sm757714wmz.12.2019.12.09.13.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:44:17 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 resend 12/13] phy: usb: USB driver is crashing during S3 resume on 7216
Date:   Mon,  9 Dec 2019 16:42:48 -0500
Message-Id: <20191209214249.41137-13-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209214249.41137-1-alcooperx@gmail.com>
References: <20191209214249.41137-1-alcooperx@gmail.com>
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


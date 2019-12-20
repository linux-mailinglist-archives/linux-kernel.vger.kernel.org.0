Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E155128224
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLTSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 13:21:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53187 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:21:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so9882110wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 10:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qTJ3cquW0XuyFYsbbi/ZSR/dYPKMLNEhqFQed36KyGg=;
        b=EA6bnQkN3I5mnUvyqfN6iuASBHNiU6FQUwTdf52zmWtFHnRCjgXLjjICWxHaPvei4k
         ZzNIU21yBTEdt/bKyWdkPVyRhWiHxGnN1PYKsuGWjr2U8MQ99ZLsQhxuIfxOZdwWbn0h
         idEpb7YhgYCNIitVFR+D+TMsbb5XTOv1KO99Q1FbEc2DjyL2AOLlyI3aIyTzqOM8dbtd
         m47841TOSNZakrgqUuQUJBsJXFJQowmkbeuYJdHStb0JG/WG4qLwmMEPOGCfH89ZUPBu
         J2oyvrC0B06Fa02cF3sqxXYLHS2qY9uwWsAfMtHlfdNwEkBsb7UJe3o9I3UgOQCwPg+M
         i3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qTJ3cquW0XuyFYsbbi/ZSR/dYPKMLNEhqFQed36KyGg=;
        b=OgvA1N7wh/54snnBFa98HsoshuhP8RuYE17BL7Nf9uDxFYkYIMHZzWuiFf1R1/nRZH
         uj9o7d/xDHrg6s0GlZ/lmL2RASK7I9bN13wtY5ThpaCE3nQLiOfpjyAF/kH4YTLV3uyd
         eUijz1gH+45ZZaJhXsOuP99e/qOr9tskK96d5DLr8IC2PI+WiPI6rWfDDW/5wy1iiZID
         dXTexre9ZaoA2Xs1tkXDNax7g82ylnmqtegN7DlwMHP3inwz805wqq4NRcCZcDHQNeh0
         eksaMHiX3HZByOdWZrJv+SGTp5TgqHJ6mu6xz32KecqPAOJEJ5XROFQFPjqQTrkxwcoC
         Qgfg==
X-Gm-Message-State: APjAAAUHw5QRW//uV7/ifa+h1zLCf8iRSeUYSqEDhOcW7HGCurhOX/qQ
        fPtvWVvBZlWaIo+tnCGN+eYn0aY1
X-Google-Smtp-Source: APXvYqxl3RwZSpdloklWw9dclz7/yBgJqHZrjgVEJH3o6o1OG/vc8E5tucTppdiLGSTGp0dayGZG1g==
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr17721850wmj.106.1576866080672;
        Fri, 20 Dec 2019 10:21:20 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s15sm11441520wrp.4.2019.12.20.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 10:21:20 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: bcm: Select ARM_AMBA for ARCH_BRCMSTB
Date:   Fri, 20 Dec 2019 10:21:15 -0800
Message-Id: <20191220182115.26318-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7211 uses a PL011 UART and is supported using ARCH_BRCMSTB, make sure
that we can enable that driver by selecting ARM_AMBA.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index e4e25f287ad7..fcfe2a0e8058 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -211,6 +211,7 @@ config ARCH_BRCMSTB
 	bool "Broadcom BCM7XXX based boards"
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_AMBA
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
-- 
2.17.1


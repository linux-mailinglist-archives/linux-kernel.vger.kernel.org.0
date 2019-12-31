Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03AA12D6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 07:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfLaGzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 01:55:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45468 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLaGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 01:55:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so19365619pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 22:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZRHufvw0O7nWhwpHOdeW2xncFsY6V7ai1BYdYAzaho=;
        b=MRsY3AMt4XIJfmKY4DSpuq3wacUrO4K8O24Ybj3SFY11sr0JfZqJ8pnmp+O/tYwFJJ
         SPrLILmpxnbR4mfl1UuV/5n3sqCqRy/rrblgngn95owSbI9h56R049N6zKwQPKCtltso
         gx7wMGtf843iQovlfCE3wLiuESqpbStb9gs+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZRHufvw0O7nWhwpHOdeW2xncFsY6V7ai1BYdYAzaho=;
        b=UjnsXQJY8JA3mmER2tdRF2ZR4C1k9pHYQt1vnaDoMgY8aULNkyQR0rqquaWv0z6PfN
         rZyeVQWRVIDcTZEukO/XPjrhcO9BJeQUwh0C1szFeoFWT6X08nTl0I5Y/ExoMumBlzIl
         s4sdQfAZSCuFHTRyQU8iJkyuKEl0HHoTudzNMRHOYTbZGV8B5y3ReDORelIY7AH3H9n5
         WcauqEC2WkuO1EYdr7uXeTtxtnvGXA1336DTj9tnMGEgovWSF3xPYbFySEBju+Ucy4gs
         96f047Wtd0uY1OYzwJpF07A4NnV75OvSbHN0gJhacvCcGaBbcSR6DwpKrfywOyUXj/2o
         iduA==
X-Gm-Message-State: APjAAAVEljAUf39pkVBvOLPVGsOwjDQ9xdJ2sq+S9j8lNiHvuXI8rC6d
        vRN0hH6+syqCQU+Q6hKvgcOcbQ==
X-Google-Smtp-Source: APXvYqyAxa6p0EPOabe3OQTYdhkONSPeiBnwM3ILST7SDRL0Lrr0UEJATAwrhqP3AzOpMFQEaFIUYQ==
X-Received: by 2002:a63:1666:: with SMTP id 38mr78918147pgw.325.1577775321566;
        Mon, 30 Dec 2019 22:55:21 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id c18sm29666552pfr.40.2019.12.30.22.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 22:55:20 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: defconfig: Enable DRM_SUN6I_DSI
Date:   Tue, 31 Dec 2019 12:25:08 +0530
Message-Id: <20191231065508.12649-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, Allwiner MIPI-DSI support is available for ARM64
Allwinner SoC like A64. So, let's build it as a module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a867ac32d4..8583bd3ac52c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -534,6 +534,7 @@ CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_SUN4I=m
+CONFIG_DRM_SUN6I_DSI=m
 CONFIG_DRM_SUN8I_DW_HDMI=m
 CONFIG_DRM_SUN8I_MIXER=m
 CONFIG_DRM_MSM=m
-- 
2.18.0.321.gffc6fa0e3


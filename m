Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE38F15D2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 08:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgBNHW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 02:22:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38490 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgBNHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:22:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so9430619wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wqp7FXZGdyNZMXzPT/HqC66/7r3iN6tDAgdf0Kj/EjQ=;
        b=Rb532p+vwGihI6II3tkcjZ1gonBh9PJCyL12qmcB9dEn4UaBk9AN77iNZdXUhyGeGg
         gKURtAPIBiLF8WTkD7vJ370EbPQqPt2qw2rt9X0kRUk6N+7w5pV9+p7hR+P8Pu3+EBey
         e2REsTC9h9Cb9+B5HaVOnBxJp/S4Ggc2476LVVF/QsVJVHF5d5q19LyfcesTuNdPI6Fu
         Qkilen70LUm1pHsrRFCh+6SvDQqd70hp7O45VtZoKdjk5FoP+xmHftmIlQCgE3OYf+kC
         JGbLFOcQG9V/RRRMbo+Atj/wSF3BX4AZQdV7444DVEUH/su6RbOq5YBG7DdPwiyP8kvH
         BbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wqp7FXZGdyNZMXzPT/HqC66/7r3iN6tDAgdf0Kj/EjQ=;
        b=hTKq5MJm1GMjSBH2iAmLyQbwNY1HfQCvj1vbOBcqDZIYD9069cL8J3KGRfgRnQOZ+X
         IDPBjNw0KSvDEEuWj06ZWuoFeiR33uvwZGVsrKxxAToGnn5TbqxdlAZ6lLT4gx5TJ34v
         mOrimEDG0PpO0C6H73j0ZcdRoxd3h6CrecWbsx3lCCCDvmW5L5hQ/v57N/EVhWyvX74e
         sPs4+Gnfasxmoj4GnxE9lwhFGKNV4Pwlv9cMrAVlLRQPp/xiKn2sfvh7yxclLYz4pK7N
         7dt3o1D82ihIqmn8mavt0OY/wN1ghD1bQNqSNKsYyng7obM6N/upoCUYsa5NTMJb90rG
         hM2g==
X-Gm-Message-State: APjAAAUEznyGwHSD+2m2jrdQNSrCF2dPJXx4PvRdNcdf3O3Ls6Dlqf+v
        UPGFYy2hk3ugsOom/e5MS795vyoHrQOVOg==
X-Google-Smtp-Source: APXvYqyJE23e/yYGTrQWJXpU5qwC9f+ZsEdab+u9F9YsHMjfTpVSPcnzVIZ/scZtt1AXR8MYN2nsSQ==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr2849733wmb.43.1581664973575;
        Thu, 13 Feb 2020 23:22:53 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id g15sm5677147wro.65.2020.02.13.23.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:22:52 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Joel Stanley <joel@jms.id.au>,
        Tony Lindgren <tony@atomide.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: multi_v7_defconfig: enable drm imx support
Date:   Fri, 14 Feb 2020 08:22:18 +0100
Message-Id: <20200214072237.16633-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes it possible to multi v7 defconfig for stm32 and imx based devices with
full drm support.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 017d65f86eba..c5ff91211947 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -640,6 +640,7 @@ CONFIG_CEC_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
 CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_ML86V7667=m
+CONFIG_IMX_IPUV3_CORE=m
 CONFIG_DRM=y
 # CONFIG_DRM_I2C_CH7006 is not set
 # CONFIG_DRM_I2C_SIL164 is not set
@@ -655,6 +656,11 @@ CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
+CONFIG_DRM_IMX=m
+CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
+CONFIG_DRM_IMX_TVE=m
+CONFIG_DRM_IMX_LDB=m
+CONFIG_DRM_IMX_HDMI=m
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_LVDS=y
-- 
2.24.1


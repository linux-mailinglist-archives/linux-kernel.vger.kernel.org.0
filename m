Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990B7192323
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 09:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCYIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 04:50:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52520 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgCYIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:50:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id z18so1395207wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEt0VLaSvhUT7nyu4RhagnuYQaTu9Oo49aJG5CKXEWA=;
        b=WNW1hxOUyik3KNX89dbIVqZHKUp+GeaU0mIGsx5AGcA2EuJud5J9sgmXPwNAJNWUhS
         3gzEx2ZwHgM7FY0xV6TiqFygdp+aX3qLpCLJBMSetYpCI4lRzi+S2qb+ybOQunU9lEcU
         W2wR6p9oXBw0yAnuBnGoEp2uKJhxhcwrREF99XjFNJf/mnsMXzF/Aw4pDRwtRyiBcfmq
         TuSriR6W1vjly0cRdJQy+MoZQnTDWqcHPRq69iku1IpaKT1oTWUavMfDQBxkdzc0lNWU
         t6tlAydLJYLQ4coxz3OqEOHlom5Hazdyz4wmZcST/jTrdm4ZVBilqsyYQCB5/mU/X9sO
         gGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEt0VLaSvhUT7nyu4RhagnuYQaTu9Oo49aJG5CKXEWA=;
        b=p97uXR928XyuvBfD4FeLExdtt3luorCESK6ssD9UYW6PmZkZGJCceKwbLYXxaXcwBv
         MY8awQCJ5xEHSSjxjDLq5aAJZUcKet47Zt7pdRYt+EZHIBQYMsOgqzbrVe7IESPlOcuh
         mrK7zZlP7d40S/BUPLb6PKr6kZAP3vKPFO6xd/sC4SB7DUvkWTTlHHHwmA1YikEpIAPm
         w+QkkuPTxYF1+sRyFqtxtzU0ditH+T4nEFynWnhIggAZ6OcoqxQqcvZ9TLPISuvy5Mle
         iMnds6WT7VuDgLVwZ/dJJbgbk8Rh5dZLprnYArk75D2RqWSSatOG4n/X5yRdVjKmX7CH
         +D0Q==
X-Gm-Message-State: ANhLgQ25ca/DjuMF4kIE8ga0RUcq3txe7XuDPuRCXXXlfSC5amlCGz9i
        ILlYCQzhWpOQModNWUC/HrgFqw==
X-Google-Smtp-Source: ADFU+vuaSMZ3OxlYUBsL4QVXZmKvzAkmgnAjbIq0Fo7kTd5yKttbT/uXfyWOqm/ruqBs2RU6wMv7IQ==
X-Received: by 2002:a05:600c:581:: with SMTP id o1mr2375592wmd.111.1585126231690;
        Wed, 25 Mar 2020 01:50:31 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o16sm33892229wrs.44.2020.03.25.01.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:50:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v4 2/8] drm/meson: add Amlogic Video FBC registers
Date:   Wed, 25 Mar 2020 09:50:19 +0100
Message-Id: <20200325085025.30631-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325085025.30631-1-narmstrong@baylibre.com>
References: <20200325085025.30631-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the registers of the VPU VD1 Amlogic FBC decoder module, and routing
register.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 8ea00546cd4e..08631fdfe4b9 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -144,10 +144,15 @@
 #define		VIU_SW_RESET_OSD1               BIT(0)
 #define VIU_MISC_CTRL0 0x1a06
 #define		VIU_CTRL0_VD1_AFBC_MASK         0x170000
+#define		VIU_CTRL0_AFBC_TO_VD1		BIT(20)
 #define VIU_MISC_CTRL1 0x1a07
 #define		MALI_AFBC_MISC			GENMASK(15, 8)
 #define D2D3_INTF_LENGTH 0x1a08
 #define D2D3_INTF_CTRL0 0x1a09
+#define VD1_AFBCD0_MISC_CTRL 0x1a0a
+#define		VD1_AXI_SEL_AFBC		(1 << 12)
+#define		AFBC_VD1_SEL			(1 << 10)
+#define VD2_AFBCD1_MISC_CTRL 0x1a0b
 #define VIU_OSD1_CTRL_STAT 0x1a10
 #define		VIU_OSD1_OSD_BLK_ENABLE         BIT(0)
 #define		VIU_OSD1_OSD_MEM_MODE_LINEAR	BIT(2)
@@ -365,6 +370,23 @@
 #define VIU_OSD1_OETF_LUT_ADDR_PORT 0x1add
 #define VIU_OSD1_OETF_LUT_DATA_PORT 0x1ade
 #define AFBC_ENABLE 0x1ae0
+#define AFBC_MODE 0x1ae1
+#define AFBC_SIZE_IN 0x1ae2
+#define AFBC_DEC_DEF_COLOR 0x1ae3
+#define AFBC_CONV_CTRL 0x1ae4
+#define AFBC_LBUF_DEPTH 0x1ae5
+#define AFBC_HEAD_BADDR 0x1ae6
+#define AFBC_BODY_BADDR 0x1ae7
+#define AFBC_SIZE_OUT 0x1ae8
+#define AFBC_OUT_YSCOPE 0x1ae9
+#define AFBC_STAT 0x1aea
+#define AFBC_VD_CFMT_CTRL 0x1aeb
+#define AFBC_VD_CFMT_W 0x1aec
+#define AFBC_MIF_HOR_SCOPE 0x1aed
+#define AFBC_MIF_VER_SCOPE 0x1aee
+#define AFBC_PIXEL_HOR_SCOPE 0x1aef
+#define AFBC_PIXEL_VER_SCOPE 0x1af0
+#define AFBC_VD_CFMT_H 0x1af1
 
 /* vpp */
 #define VPP_DUMMY_DATA 0x1d00
-- 
2.22.0


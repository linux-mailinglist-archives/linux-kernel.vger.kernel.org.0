Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A51912C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgCXOUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 10:20:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37854 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCXOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:20:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so21698567wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WyG+n8djNvIo3nOPxwWbAPG6RneB4WAm9wKQe+zHsY=;
        b=kgvsjSTRISrTA5t190/L3CdCx53KraHUPzxQJAdGOT+B+wo7Q++j7C4esQEoaZ7m9h
         lqxHe1yA3pKLxXcTcp1PZBy/RGQYypcaCqsD1do5Q5HE503nZClU6tjyBP2B+2+A3Bbl
         YrqdoRemrNhhrEP+Iwf/fd4QFc35y00KP3OxbGbUnMZVN+odWo1UrlH+wGIuxv1F2NSy
         30Fjn/Y8zBVVMHsDHd/L2UiwFCuDo34GQCisSPQ6D3S9iPjaF45260jNChtx78S0RlM4
         8jNTxmBnzt2nbGrv3cFc2u33hMfxJkXl2hz+cYC9bumk9LkB7atxovFX3Y6A6lxGneHw
         b3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WyG+n8djNvIo3nOPxwWbAPG6RneB4WAm9wKQe+zHsY=;
        b=QqRZ5NaKU+oBkrsgNqc48Vdj5rjjBFE8G9BqJU500RtD884SPAvXvrrxQxYMGvl87J
         qZivpYLIeTzsZ3Ezwyx8YZ59UaCqCWgHIG7yVfp0or8JVzrCOVy/u+5s8t9P4cwdYawP
         VWPIqiJsi26kBtHiishLN1/ldmM/soaj66eOL3Y/VzpXq6RTdAbf4UQG7krzihw7TSdf
         sEsIWlkSX72iR8w6mUmWbUUS6e4TuRfjTJt5G1N2P055V+LTu3gqFHS8+UKpdqb8p/f3
         SU5x2hUdE4T15i9qLASd9oxHNEUFtUiPz+SSwofuMzaAYoy3IhOgLVSaHlQuFlysa5vn
         nVRA==
X-Gm-Message-State: ANhLgQ3789NVQhmDmTMti2ZGzkZYDJZd6mkT/ixKzvEKctTVUsx9oKEY
        Z8PsTm336JrwpGOCLYCM+f3sRg==
X-Google-Smtp-Source: ADFU+vu2pPTHrxXiQqwlVpbFf/IYZjooPuR+f8p2vHH2AMc5SvS3CVLEsI6qLMJRtysQLUQ01BwuVA==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr36580657wrx.130.1585059630058;
        Tue, 24 Mar 2020 07:20:30 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o4sm28688472wrp.84.2020.03.24.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 07:20:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] drm/fourcc: amlogic: Add modifier definitions for Memory Saving option
Date:   Tue, 24 Mar 2020 15:20:14 +0100
Message-Id: <20200324142016.31824-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324142016.31824-1-narmstrong@baylibre.com>
References: <20200324142016.31824-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic uses a proprietary lossless image compression protocol and format
for their hardware video codec accelerators, either video decoders or
video input encoders.

An option exist changing the layout superblock size to save memory when
using 8bit components pixels size.

The layout options starts at the 8th bit, keeping the first 8bits of the
modifiers bits to define the layout.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/uapi/drm/drm_fourcc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 6564813d2f7a..84edc5d69613 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -819,6 +819,12 @@ extern "C" {
  * per component YCbCr 420, single plane :
  * - DRM_FORMAT_YUV420_8BIT
  * - DRM_FORMAT_YUV420_10BIT
+ *
+ * The first 8 bits of the mode defines the layout, then the following 8 bits
+ * defined the options changing the layout.
+ *
+ * Not all combinations are valid, and different SoCs may support different
+ * combinations of layout and options.
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC(__modes) fourcc_mod_code(AMLOGIC, __modes)
 
@@ -834,6 +840,22 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC		(1ULL << 0)
 
+/*
+ * Amlogic FBC Layout Options
+ */
+
+/*
+ * Amlogic FBC Memory Saving mode
+ *
+ * Indicates the storage is packed when pixel size is multiple of word
+ * boudaries, i.e. 8bit should be stored in this mode to save allocation
+ * memory.
+ *
+ * This mode reduces body layout to 3072 bytes per 64x32 superblock with
+ * the basic layout.
+ */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING	(1ULL << 8)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.22.0


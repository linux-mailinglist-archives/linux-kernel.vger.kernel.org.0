Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4245F135524
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 10:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgAIJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 04:07:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51137 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgAIJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:06:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so1996723wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kvdfo5p7rGw6kjZkh9zkMAcibuMahAFzCWtpfQCY54I=;
        b=Q7ic9Z2e9nve5H4Tkmw1sEa3snMzPEKbOpJC+93YR6BjyzubO6YRlLXrTNYQmv/Mfx
         KUrQKWtbAx3s/XgHEJwYz3q1lKgoy04GLeGJcoC0XfwozQuHczFKZyW6TMOS6yULtXol
         cA+hqjdYmRUAdM0aTcRIOpiSq+GllGzA+v8iKE54owjsx8hIiVHNU2HTWcECOc+je4PB
         CTm3bj7Xe5tJL/Bbp9OM0qffAd3e1ciM93jVuAwR48NDAGlR7rY9c5N6AUJNk9jnviN0
         /IaBe3F0gNYnU/rrJShNwOCK9/JM3l7tI/jha5wCzPdj1lzDtWpVcaxi8oHvjG6L584Y
         1cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kvdfo5p7rGw6kjZkh9zkMAcibuMahAFzCWtpfQCY54I=;
        b=D+F4EryYjnFVwS19g9Od4knYvNRv6jfEUUzsWHQrKJ7C6jCm16VhwQpK+lZ5usGBVi
         qO7Tu19PN0sprUqS1HSijDlE2zhu14zTY8arl17yB08tGMO9YLCDkD3bm5aEnLGNmCMO
         vAHTj4VZNTuRUPe2/gjYQx5KpkPiBbMRGZc/0KkRScXJ14D9k3c25TX/SWJqi1L90DIt
         9tSLzxy/l61sqmjGMP1jE1m/eFaMU3nufIZ0tL5MsbIVJ4/hA2uOPPmg0FzATixiTMUm
         cGmaBz40PW3RJJlVkEmzyWmDiJ7ui7HP29SVKgcIuO05s2dXz53ZRvOTvjMYZj1T1Dmd
         YrHQ==
X-Gm-Message-State: APjAAAXHMXvuPJlL8a6xBkys8fML4EgfPKaQAe4YB6uYeb5Ly4Fxaozv
        TwyKYyRAC6LAOkrZkiUvfoE=
X-Google-Smtp-Source: APXvYqwVuHDn92wUI+VKXs8iqgeYtS2XopG9hgSpBEVm6ExhW37DQkykMGyIQyid+gDpQ/m4FoqLEg==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr3393989wmb.73.1578560817414;
        Thu, 09 Jan 2020 01:06:57 -0800 (PST)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id i8sm8004734wro.47.2020.01.09.01.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:06:56 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/i915: conversion to new logging macros in i915/intel_csr.c
Date:   Thu,  9 Jan 2020 12:06:43 +0300
Message-Id: <0ea8e0f39013a73ed66052893a8f8abf8cc23ba6.1578560355.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578560355.git.wambui.karugax@gmail.com>
References: <cover.1578560355.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of printk and struct device based logging macros with
the new struct drm_device based logging macros in i915/intel_csr.c

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/i915/intel_csr.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_csr.c b/drivers/gpu/drm/i915/intel_csr.c
index 09870a31b4f0..85e41db7dc0e 100644
--- a/drivers/gpu/drm/i915/intel_csr.c
+++ b/drivers/gpu/drm/i915/intel_csr.c
@@ -298,12 +298,14 @@ void intel_csr_load_program(struct drm_i915_private *dev_priv)
 	u32 i, fw_size;
 
 	if (!HAS_CSR(dev_priv)) {
-		DRM_ERROR("No CSR support available for this platform\n");
+		drm_err(&dev_priv->drm,
+			"No CSR support available for this platform\n");
 		return;
 	}
 
 	if (!dev_priv->csr.dmc_payload) {
-		DRM_ERROR("Tried to program CSR with empty payload\n");
+		drm_err(&dev_priv->drm,
+			"Tried to program CSR with empty payload\n");
 		return;
 	}
 
@@ -636,16 +638,16 @@ static void csr_load_work_fn(struct work_struct *work)
 		intel_csr_load_program(dev_priv);
 		intel_csr_runtime_pm_put(dev_priv);
 
-		DRM_INFO("Finished loading DMC firmware %s (v%u.%u)\n",
-			 dev_priv->csr.fw_path,
-			 CSR_VERSION_MAJOR(csr->version),
+		drm_info(&dev_priv->drm,
+			 "Finished loading DMC firmware %s (v%u.%u)\n",
+			 dev_priv->csr.fw_path, CSR_VERSION_MAJOR(csr->version),
 			 CSR_VERSION_MINOR(csr->version));
 	} else {
-		dev_notice(dev_priv->drm.dev,
+		drm_notice(&dev_priv->drm,
 			   "Failed to load DMC firmware %s."
 			   " Disabling runtime power management.\n",
 			   csr->fw_path);
-		dev_notice(dev_priv->drm.dev, "DMC firmware homepage: %s",
+		drm_notice(&dev_priv->drm, "DMC firmware homepage: %s",
 			   INTEL_UC_FIRMWARE_URL);
 	}
 
@@ -712,7 +714,8 @@ void intel_csr_ucode_init(struct drm_i915_private *dev_priv)
 	if (i915_modparams.dmc_firmware_path) {
 		if (strlen(i915_modparams.dmc_firmware_path) == 0) {
 			csr->fw_path = NULL;
-			DRM_INFO("Disabling CSR firmware and runtime PM\n");
+			drm_info(&dev_priv->drm,
+				 "Disabling CSR firmware and runtime PM\n");
 			return;
 		}
 
@@ -722,11 +725,12 @@ void intel_csr_ucode_init(struct drm_i915_private *dev_priv)
 	}
 
 	if (csr->fw_path == NULL) {
-		DRM_DEBUG_KMS("No known CSR firmware for platform, disabling runtime PM\n");
+		drm_dbg_kms(&dev_priv->drm,
+			    "No known CSR firmware for platform, disabling runtime PM\n");
 		return;
 	}
 
-	DRM_DEBUG_KMS("Loading %s\n", csr->fw_path);
+	drm_dbg_kms(&dev_priv->drm, "Loading %s\n", csr->fw_path);
 	schedule_work(&dev_priv->csr.work);
 }
 
-- 
2.24.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 696E4DD28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfD2Hww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 03:52:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43904 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfD2Hwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:52:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id a12so14496519wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/mDQvnk0IIQmAZwrlmB/+Qs1VqQjgXmR4mQ6Zr5vLM=;
        b=yQrh7BIMJoH3/0jqWWCbu4c5tIODo9kRVw4r/nYa/1whLzbcUc1wNYNh1Tp2htcv15
         N1OCNf+l5RfcKPlwwPFnMuFCNCFZEnBOZ/f49lmWKh+Q+SL4alibk2iIwd9mf1qnG8DH
         /FdnrIWiZMalpBQA95V51+ih2cs2YrnTuEQwcMQZjDQjTfqTfmrZ7iNPdu5s0l672Nlz
         r62AxhqskACBze3lX6TT5TsGeaO93NfHqDpLR7XSZvy6nyXr2TaWJROc5Y7+9Im6M4gU
         kE7azJ1NPScSgDQqUiv2w2KNaq3DAOS4hl4chBYZY5rtytIKxkP7I/YbJL4mV2Yi2l6z
         Nqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/mDQvnk0IIQmAZwrlmB/+Qs1VqQjgXmR4mQ6Zr5vLM=;
        b=LZSVp4pWNFkktPPm2ak1Ep1U8q8dMTEUCnPlwBapz7JuDqCo4lH6qxO7tdWi9nWJTh
         u32OJXM2u1zDCnCygYlIO8y9DOGgVhjBWHR6Q7hHTaASvhW50IWGxoB0KQg1BywFOtIB
         Vx2PyQCKvOLRNyDz6DoozYjxnIwjgTPxyKTxH+jX+g9UcMuYKtSr4ccMUuhzflTxa28a
         mxpFf0C3t+bfN66sU0CPh4/IlRy+q8xBwVe1bflmNSsSSizKR4i5tkpwmtmAMkxkDE2C
         QOxpS1dkfwQ3aPO2+DCBbGr5MInpjPDN3k4lr8DcIKjOlq/IyYHyni2hgjPyb//PdE2i
         wy9g==
X-Gm-Message-State: APjAAAXMbfwgI8+2okWgi+F95KxiefNRHH4ozrRD44HGoN7S08tSoinp
        6fhfs3gAP3/47tbgnrTs9Uq2Fw==
X-Google-Smtp-Source: APXvYqxK8h9fP1diY34GCvdYZ01wJZXC1DSL1FPL3mMAddWYdgRZE3NVRKvJYj+rs35MKDeUPkEHfA==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr7015881wrs.52.1556524369379;
        Mon, 29 Apr 2019 00:52:49 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x84sm40099073wmg.13.2019.04.29.00.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 00:52:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: Add zpos immutable property to planes
Date:   Mon, 29 Apr 2019 09:52:47 +0200
Message-Id: <20190429075247.7946-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add immutable zpos property to primary and overlay planes to specify
the current fixed zpos position.

Fixes: f9a2348196d1 ("drm/meson: Support Overlay plane for video rendering")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_overlay.c | 3 +++
 drivers/gpu/drm/meson/meson_plane.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index bdbf925ff3e8..dceb3df5e652 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -578,6 +578,9 @@ int meson_overlay_create(struct meson_drm *priv)
 
 	drm_plane_helper_add(plane, &meson_overlay_helper_funcs);
 
+	/* For now, VD Overlay plane is always on the back */
+	drm_plane_create_zpos_immutable_property(plane, 0);
+
 	priv->overlay_plane = plane;
 
 	DRM_DEBUG_DRIVER("\n");
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index b8f6b08a89a6..2f7f4dfce45b 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -399,6 +399,9 @@ int meson_plane_create(struct meson_drm *priv)
 
 	drm_plane_helper_add(plane, &meson_plane_helper_funcs);
 
+	/* For now, OSD Primary plane is always on the front */
+	drm_plane_create_zpos_immutable_property(plane, 1);
+
 	priv->primary_plane = plane;
 
 	return 0;
-- 
2.21.0


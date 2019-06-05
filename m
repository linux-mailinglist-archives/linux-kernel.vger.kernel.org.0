Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB635ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfFEONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 10:13:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55898 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfFEOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:12:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id 16so2420657wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CiicJKseqdKOg5DHKMcjVCBzkcBVtZ2N776bahkz4d8=;
        b=Asrc1pFrwP/vms/HaF6ahudawkZj7r6MSdAFZiQNwE+2rIPqYk39LYibggrg3PpASb
         Lxs45FxLnqC1K6Z/+7Qt29IjRcH8V0USApXqVIJh4XCCSi2Z/V/mSNnpJyrDyuj0XZz4
         qEF5f/ioRukigieqF0HWRUSDmdzxjPElHcPTn9y/2MPWUrxqfLK2lPsPJf0QpQjgrQ/V
         ZDzG5+XmDVDVT/CVqrOlrt0/1cB3v8Hp6w19zCN0YcksRErl4ZCUJcJaoMFkrkvOlwji
         SfSmivfvh6n+9o7pF6OSRL9rtTFVHzKJ3hcycaKKwx/ELndMtA0+ufNTmh2jnAMtY6RL
         UbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CiicJKseqdKOg5DHKMcjVCBzkcBVtZ2N776bahkz4d8=;
        b=Mps3NO6OobTFoKzr65opGhKxk0gBGF/7Q4kUs2c7IHdffm3jstAmSczw04gCcenxR4
         EvQzpwaXyAfn8YB5LOeHEbQ9FmKsStteVugwSFsGIeFZY+RZIuc30+N/fdmUuiZqxQL+
         aU/I4xNNhC7wscQTTUtbxjSIJtRbqIxuE0vn6mcoSNoBc55/iFrbDa3HkqOIqMxZR/fu
         bTOORxQ8eUnLgYe8m8kBy4KbSeso62mDrur/Ze9ldKAeMlkOcB7AEZHF5zgaQaS15kTV
         NpKkY6t13LndJXmNCDiA2MuP+labFmZUegzmhN8yyCcl2Y5tpeM4IrcJ/R8L0/uMzEHZ
         07VA==
X-Gm-Message-State: APjAAAWGHL8Ac5ZxYKV16wA5Rvphy0lzWUElhov0AzOUgYQTSDD6gfTu
        h5rvddOT/f4gPuSv0J9rIQyISw==
X-Google-Smtp-Source: APXvYqzI3IVVjrCS/CpME4PJLgA844fWjiI4G6tQsgpnScJPfDZYOVtvDPHviInkIWlgQ7OFwSUOYQ==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr21902049wma.175.1559743976973;
        Wed, 05 Jun 2019 07:12:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s8sm36292546wra.55.2019.06.05.07.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 07:12:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] drm/meson: fix primary plane disabling
Date:   Wed,  5 Jun 2019 16:12:52 +0200
Message-Id: <20190605141253.24165-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605141253.24165-1-narmstrong@baylibre.com>
References: <20190605141253.24165-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary plane disable logic is flawed, when the primary plane is
disabled, it is re-enabled in the vsync irq when another plane is updated.

Handle the plane disabling correctly by handling the primary plane
enable flag in the primary plane update & disable callbacks.

Fixes: 490f50c109d1 ("drm/meson: Add G12A support for OSD1 Plane")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_crtc.c  | 4 ----
 drivers/gpu/drm/meson/meson_plane.c | 4 +++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 685715144156..50a9a96720b9 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -107,8 +107,6 @@ static void meson_g12a_crtc_atomic_enable(struct drm_crtc *crtc,
 			priv->io_base + _REG(VPP_OUT_H_V_SIZE));
 
 	drm_crtc_vblank_on(crtc);
-
-	priv->viu.osd1_enabled = true;
 }
 
 static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -137,8 +135,6 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
 			    priv->io_base + _REG(VPP_MISC));
 
 	drm_crtc_vblank_on(crtc);
-
-	priv->viu.osd1_enabled = true;
 }
 
 static void meson_g12a_crtc_atomic_disable(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 22490047932e..b788280895c6 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -305,6 +305,8 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 		meson_plane->enabled = true;
 	}
 
+	priv->viu.osd1_enabled = true;
+
 	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
 }
 
@@ -323,7 +325,7 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
 				    priv->io_base + _REG(VPP_MISC));
 
 	meson_plane->enabled = false;
-
+	priv->viu.osd1_enabled = false;
 }
 
 static const struct drm_plane_helper_funcs meson_plane_helper_funcs = {
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C8863F31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 04:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfGJCRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 22:17:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35343 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfGJCRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:17:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so384010plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxC6cpJeD3A10tWWsNE37FjIALjzLREnlwwa6KDygFo=;
        b=cOH8q2NXyovDSMUi7Xd+oHt9KadYcDoTUvRMkD/0Uf41BGCgaVcf7ZDlhSjXFXm6Lu
         ESTtRPTKtFghn8CC6QIqS7fRiHEAAJ+mCfoZNe3O8zcvXAT3weo6V4fimDAF1Z3n145Z
         2ghQAYXOmiz9HHA0Iybxqrs5iV+2A4uq9ZIHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxC6cpJeD3A10tWWsNE37FjIALjzLREnlwwa6KDygFo=;
        b=DW33QyMzFZtK4xLRM/pjVXnAnNtBSeBhCniuSpXlzLWuB5RjdNYpORm0ObNggUNsxs
         vTlOyFDy3EwuGdKbxWxs9FVQaMV087Kyh0gbV8pWsX3lMToAS/iZ6X2EYUlFNy1lXyve
         CKVgXC0CVUEZyDJkLy/rn9cvTKigXz75Uu4i9rp35Hr6B2ZhkY+zHB8ZXNvGKJfAMSBS
         CiB059msN0QJeJKFHeqwKimNxd+Lf9LPnkECfL8/nCbSzZkzk5iRgr64+TjJbF8GLQxw
         htalgxwwpjIj5tyY0EzboBoQay1Qnd/FZp9GA+EZOW37WY/kqeprJ94zXf29umTWwpVU
         aubg==
X-Gm-Message-State: APjAAAUfji+Cs0Gt06e+FyJPHD99HibvJjxEpFGJPUuGtbbZq3Jfnaha
        xcCdmaJ7HOuYZbKH0q2wy1NxMV6lcjw=
X-Google-Smtp-Source: APXvYqyqOasWPK4ZpeQARWIZEdPGz1HraSAZfsyOpQz9qUNv7Z9acXIyi2h1oPo/iq/+u18NZCadrQ==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr35190007pla.338.1562725028674;
        Tue, 09 Jul 2019 19:17:08 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id f17sm326296pgv.16.2019.07.09.19.17.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 19:17:08 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v7 4/4] drm/mtk: add panel orientation property
Date:   Tue,  9 Jul 2019 19:16:59 -0700
Message-Id: <20190710021659.177950-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190710021659.177950-1-dbasehore@chromium.org>
References: <20190710021659.177950-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This inits the panel orientation property for the mediatek dsi driver
if the panel orientation (connector.display_info.panel_orientation) is
not DRM_MODE_PANEL_ORIENTATION_UNKNOWN.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b91c4616644a..2920458ae2fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -790,10 +790,18 @@ static int mtk_dsi_create_connector(struct drm_device *drm, struct mtk_dsi *dsi)
 			DRM_ERROR("Failed to attach panel to drm\n");
 			goto err_connector_cleanup;
 		}
+
+		ret = drm_connector_init_panel_orientation_property(&dsi->conn);
+		if (ret) {
+			DRM_ERROR("Failed to init panel orientation\n");
+			goto err_panel_detach;
+		}
 	}
 
 	return 0;
 
+err_panel_detach:
+	drm_panel_detach(dsi->panel);
 err_connector_cleanup:
 	drm_connector_cleanup(&dsi->conn);
 	return ret;
-- 
2.22.0.410.gd8fdbe21b5-goog


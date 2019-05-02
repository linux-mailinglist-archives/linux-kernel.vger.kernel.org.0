Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C360C124A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 00:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEBWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 18:38:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36756 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:38:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so1717145pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBFW9ct9L9kxaMD7soK1MmMiGB02h+kun9/xHdLdz90=;
        b=T2KhVqVdwh/tHXA/wuJoYTbXZFKGkASbAuQ7K5ZNHDkBqe7WFxueRi4ZQzm45gLf4R
         Eprg1hoU+uGGZPCaZsQ10mK8879RYaj1HzX7E6Gkx+D50IZ2JbFyfHeg0wUOiVob+Vuq
         GJ/ylfxE9UI2yU1NYWDMzrpIvzCZQxrMahzGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBFW9ct9L9kxaMD7soK1MmMiGB02h+kun9/xHdLdz90=;
        b=OcGGwCzViQVEgOzBQyVTQbNasqD2k7gH0sBFP2g4bJ+bbHKNwUnkBzU4CEARHJeAH9
         svS4vtdg+D4LxSOLxkKoUniXjw0eDO22Sedi3pyyu2H2gfpWRWgJXEig1w60AH9j/l3S
         bzi0FrHkVJ4xuY+tClybNavYTQTmNIv61DTNUW+5yQH6/FsoY8DR+UQYKh3gmJFuIcCJ
         cBiDW1Q/t8Ud0ghsGuHXePc1lY5Cq8H10EeM2I6/3rLokEzz+J9sCqjgbFTOLWNiqeQd
         dx032zaFWAVoDFfBiE3Ern3xc2cFkYTVu+f67WE8VBoYUuWTHorxNeqbBGN1KqeYMcLH
         GtEw==
X-Gm-Message-State: APjAAAXcc4pg9j+KAVMcEKKDiCqUQ1EwS/SBIC7WiNpdXsRFH8DEwBrz
        l9BeosE/v9HaUZxtPrCvwJHOSA==
X-Google-Smtp-Source: APXvYqzq5JvWDWnU2WBxay5i7m7nGGZ4xrgcUbqlp6Nq6J2U3j8kQ26AAp/Vh8DDfS/M+iUafD66nQ==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr6416756pgd.91.1556836712382;
        Thu, 02 May 2019 15:38:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id k186sm244151pfc.137.2019.05.02.15.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:38:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
Date:   Thu,  2 May 2019 15:38:08 -0700
Message-Id: <20190502223808.185180-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190502223808.185180-1-dianders@chromium.org>
References: <20190502223808.185180-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Rockchip rk3288-based Chromebooks when you do a suspend/resume
cycle:

1. You lose the ability to detect an HDMI device being plugged in.

2. If you're using the i2c bus built in to dw_hdmi then it stops
working.

Let's call the core dw-hdmi's suspend/resume functions to restore
things.

NOTE: in downstream Chrome OS (based on kernel 3.14) we used the
"late/early" versions of suspend/resume because we found that the VOP
was sometimes resuming before dw_hdmi and then calling into us before
we were fully resumed.  For now I have gone back to the normal
suspend/resume because I can't reproduce the problems.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 4cdc9f86c2e5..deb0e8c30c03 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -542,11 +542,31 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused dw_hdmi_rockchip_suspend(struct device *dev)
+{
+	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
+
+	return dw_hdmi_suspend(hdmi->hdmi);
+}
+
+static int __maybe_unused dw_hdmi_rockchip_resume(struct device *dev)
+{
+	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
+
+	return dw_hdmi_resume(hdmi->hdmi);
+}
+
+const struct dev_pm_ops dw_hdmi_rockchip_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(dw_hdmi_rockchip_suspend,
+				dw_hdmi_rockchip_resume)
+};
+
 struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
 	.probe  = dw_hdmi_rockchip_probe,
 	.remove = dw_hdmi_rockchip_remove,
 	.driver = {
 		.name = "dwhdmi-rockchip",
+		.pm = &dw_hdmi_rockchip_pm,
 		.of_match_table = dw_hdmi_rockchip_dt_ids,
 	},
 };
-- 
2.21.0.1020.gf2820cf01a-goog


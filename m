Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F651256EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 23:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLRWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 17:36:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45513 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfLRWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:36:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so1607024pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mydBqKv+d6SpAVkQY6i0eU5oOuSS/A7UC42Xzyq9TQ4=;
        b=gcUlYSvEZPV/3S4bjdwO/pxZ9DP28l2E5G5DdHMt+gWwBXLsXkw/yCyicrKYtJ6gvV
         5J/hHixTsbTiA+0pi8suV/4T0p6SWo8qVb7yBYg3v/1jcnyjJ8qS3jKmHLUHqEv+9kNR
         EBgcnVSnvaSfZClAr3cmHU4zoaw2Q2c5aR6Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mydBqKv+d6SpAVkQY6i0eU5oOuSS/A7UC42Xzyq9TQ4=;
        b=eovfbOZNrGUKg1L+ITqvXkKCZyrjt+VOfAPfwh6fyy0eeMLEiiDIg79isN+m6GbMDk
         s/TpqkFhStl9+FlsYcjcfivzWowRg1Hn10FgXepJwtVK8fDFOviYffp4PMJiOHe+mgTd
         jgQWFAJjTPbjjDeNa92ucj2LK6HDIp8KFFIqiR2dN2oJssyqdkCbzAn5aD2CipJ5vATy
         hFyB1gEwxercZBpAn1q35n7sEU0ofsUUcugSUXY7OMdiKVy1F9LAB8+2t84hMdwJL6Z5
         85YGBY0HHUDTHlp+raFo4gL3eFCM3D0O7tiWEfC4AWiqA+aDQpWnTgiZi4HpneO79HTv
         UxBw==
X-Gm-Message-State: APjAAAW59KR+weTYlksMjhgW4wkFEf0FJPTmZ/+IJ6/7AJG/kS+hLQRP
        vDDNt/X95FJrjWXX2a+d3glZDQ==
X-Google-Smtp-Source: APXvYqytYmEANX8XvabXMuuaru+HmPQyXLQG10CIvV/yFjJRgYu/bO+Hw0bEQJUY8SgUc+JnXpm0FQ==
X-Received: by 2002:a17:90a:1f8e:: with SMTP id x14mr5818571pja.29.1576708562330;
        Wed, 18 Dec 2019 14:36:02 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i9sm4709919pfk.24.2019.12.18.14.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:36:01 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, seanpaul@chromium.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH v3 4/9] drm/bridge: ti-sn65dsi86: Config number of DP lanes Mo' Betta
Date:   Wed, 18 Dec 2019 14:35:25 -0800
Message-Id: <20191218143416.v3.4.If3e2d0493e7b6e8b510ea90d8724ff760379b3ba@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191218223530.253106-1-dianders@chromium.org>
References: <20191218223530.253106-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver used to say that the value to program into bridge register
0x93 was dp_lanes - 1.  Looking at the datasheet for the bridge, this
is wrong.  The data sheet says:
* 1 = 1 lane
* 2 = 2 lanes
* 3 = 4 lanes

A more proper way to express this encoding is min(dp_lanes, 3).

At the moment this change has zero effect because we've hardcoded the
number of DP lanes to 4.  ...and (4 - 1) == min(4, 3).  How fortunate!
...but soon we'll stop hardcoding the number of lanes.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index ab644baaf90c..d55d19759796 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -523,7 +523,7 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 			   CHA_DSI_LANES_MASK, val);
 
 	/* DP lane config */
-	val = DP_NUM_LANES(pdata->dp_lanes - 1);
+	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
 	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
 			   val);
 
-- 
2.24.1.735.g03f4e72817-goog


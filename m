Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF20134F84
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 23:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgAHWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 17:43:17 -0500
Received: from mail.manjaro.org ([176.9.38.148]:60208 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgAHWnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:43:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 8683336E4DE5;
        Wed,  8 Jan 2020 23:43:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bqW6UVg2x1jr; Wed,  8 Jan 2020 23:43:13 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/1] drm/rockchip: fix integer type used for storing dp data rate and lane count
Date:   Wed,  8 Jan 2020 23:39:49 +0100
Message-Id: <20200108223949.355975-2-t.schramm@manjaro.org>
In-Reply-To: <20200108223949.355975-1-t.schramm@manjaro.org>
References: <20200108223949.355975-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2589c4025f13 ("drm/rockchip: Avoid drm_dp_link helpers") changes
the type of variables used to store the display port data rate and
number of lanes to u8. However u8 is not sufficient to store the link
data rate of the display port.
This commit reverts the type of both the number of lanes and the data
rate to unsigned int.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 83c4586665b4..806cb0b08982 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -94,8 +94,8 @@ struct cdn_dp_device {
 	struct video_info video_info;
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
-	u8 max_lanes;
-	u8 max_rate;
+	unsigned int max_lanes;
+	unsigned int max_rate;
 	u8 lanes;
 	int active_port;
 
-- 
2.24.1


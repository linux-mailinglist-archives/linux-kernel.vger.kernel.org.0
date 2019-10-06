Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80761CD360
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfJFQEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 12:04:51 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47405 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJFQEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 12:04:51 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 1475B8289D;
        Sun,  6 Oct 2019 16:04:45 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 3/3] drm/sun4i: sun6i_mipi_dsi: fix DCS long write packet length
Date:   Mon,  7 Oct 2019 00:03:02 +0800
Message-Id: <20191006160303.24413-4-icenowy@aosc.io>
In-Reply-To: <20191006160303.24413-1-icenowy@aosc.io>
References: <20191006160303.24413-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The packet length of DCS long write packet should not be added with 1
when constructing long write packet.

Fix this.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8fe8051c34e6..c958ca9bae63 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -832,8 +832,8 @@ static u32 sun6i_dsi_dcs_build_pkt_hdr(struct sun6i_dsi *dsi,
 	u32 pkt = msg->type;
 
 	if (msg->type == MIPI_DSI_DCS_LONG_WRITE) {
-		pkt |= ((msg->tx_len + 1) & 0xffff) << 8;
-		pkt |= (((msg->tx_len + 1) >> 8) & 0xffff) << 16;
+		pkt |= ((msg->tx_len) & 0xffff) << 8;
+		pkt |= (((msg->tx_len) >> 8) & 0xffff) << 16;
 	} else {
 		pkt |= (((u8 *)msg->tx_buf)[0] << 8);
 		if (msg->tx_len > 1)
-- 
2.21.0


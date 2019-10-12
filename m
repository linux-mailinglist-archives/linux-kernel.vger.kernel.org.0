Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE57D4C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 05:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfJLDIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 23:08:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12294 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728259AbfJLDIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:08:11 -0400
X-UUID: 54c2f0a3d5644b70a36fdbcfc4daadc9-20191012
X-UUID: 54c2f0a3d5644b70a36fdbcfc4daadc9-20191012
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 364434644; Sat, 12 Oct 2019 11:08:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Oct
 2019 11:08:04 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sat, 12 Oct 2019 11:08:03 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 8/8] drm/panel: support for auo,b101uan08.3 wuxga dsi video mode panel
Date:   Sat, 12 Oct 2019 11:07:20 +0800
Message-ID: <20191012030720.27127-9-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012030720.27127-1-jitao.shi@mediatek.com>
References: <20191012030720.27127-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24970.000
X-TM-AS-Result: No-4.454300-8.000000-10
X-TMASE-MatchedRID: EVs8mp2+703QIwAe9yDqC/3HILfxLV/9NV9S7O+u3KYBqgK2otzLQvDR
        cRAxsuj7oODj/ed0fo3GVaDBoTrnxixppiUy9o4cGjzBgnFZvQ7gXnxE81iysY5JUK9UdYknKKq
        yc9Qq8XoheBVUjnjCL4RjXy3Ro697sx/x3O663xdJkkUW0nPbN4iuaoNXJrK/rE4sEA01Jmn71G
        pSv+DMDC5Oh8YnEjIhgDLqnrRlXrZ8nn9tnqel2MZW5ai5WKlyfvfWIOIOReAvQUAvxRoIc1Ily
        ofhlFGqt1AsXGB1Oo9+/5H10DkP9/YLSq9KVORy7ZYS8ohwyHLD/8sPERd/m8UMBmUZEDya+F1u
        QrHm3kVAHJVliJsXGmmscOV/NgBtJ4Kg2QL3UZ5Qb0W4rFkT0Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.454300-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24970.000
X-TM-SNTS-SMTP: 6209DB2CA8B971A409A3F37904A7B71790A4D62E4B46137F4B78B181A30C48142000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auo,auo,b101uan08.3's connector is same as boe,tv101wum-nl6.
The most codes can be reuse.
So auo,b101uan08.3 and boe,tv101wum-nl6 use one driver file.
Add the different parts in driver data.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 7b47619675f5..e2496a334ab6 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -382,6 +382,53 @@ static const struct panel_init_cmd auo_kd101n80_45na_init_cmd[] = {
 	{},
 };
 
+static const struct panel_init_cmd auo_b101uan08_3_init_cmd[] = {
+	_INIT_DELAY_CMD(24),
+	_INIT_DCS_CMD(0xB0, 0x01),
+	_INIT_DCS_CMD(0xC0, 0x48),
+	_INIT_DCS_CMD(0xC1, 0x48),
+	_INIT_DCS_CMD(0xC2, 0x47),
+	_INIT_DCS_CMD(0xC3, 0x47),
+	_INIT_DCS_CMD(0xC4, 0x46),
+	_INIT_DCS_CMD(0xC5, 0x46),
+	_INIT_DCS_CMD(0xC6, 0x45),
+	_INIT_DCS_CMD(0xC7, 0x45),
+	_INIT_DCS_CMD(0xC8, 0x64),
+	_INIT_DCS_CMD(0xC9, 0x64),
+	_INIT_DCS_CMD(0xCA, 0x4F),
+	_INIT_DCS_CMD(0xCB, 0x4F),
+	_INIT_DCS_CMD(0xCC, 0x40),
+	_INIT_DCS_CMD(0xCD, 0x40),
+	_INIT_DCS_CMD(0xCE, 0x66),
+	_INIT_DCS_CMD(0xCF, 0x66),
+	_INIT_DCS_CMD(0xD0, 0x4F),
+	_INIT_DCS_CMD(0xD1, 0x4F),
+	_INIT_DCS_CMD(0xD2, 0x41),
+	_INIT_DCS_CMD(0xD3, 0x41),
+	_INIT_DCS_CMD(0xD4, 0x48),
+	_INIT_DCS_CMD(0xD5, 0x48),
+	_INIT_DCS_CMD(0xD6, 0x47),
+	_INIT_DCS_CMD(0xD7, 0x47),
+	_INIT_DCS_CMD(0xD8, 0x46),
+	_INIT_DCS_CMD(0xD9, 0x46),
+	_INIT_DCS_CMD(0xDA, 0x45),
+	_INIT_DCS_CMD(0xDB, 0x45),
+	_INIT_DCS_CMD(0xDC, 0x64),
+	_INIT_DCS_CMD(0xDD, 0x64),
+	_INIT_DCS_CMD(0xDE, 0x4F),
+	_INIT_DCS_CMD(0xDF, 0x4F),
+	_INIT_DCS_CMD(0xE0, 0x40),
+	_INIT_DCS_CMD(0xE1, 0x40),
+	_INIT_DCS_CMD(0xE2, 0x66),
+	_INIT_DCS_CMD(0xE3, 0x66),
+	_INIT_DCS_CMD(0xE4, 0x4F),
+	_INIT_DCS_CMD(0xE5, 0x4F),
+	_INIT_DCS_CMD(0xE6, 0x41),
+	_INIT_DCS_CMD(0xE7, 0x41),
+	_INIT_DELAY_CMD(150),
+	{},
+};
+
 static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
 {
 	return container_of(panel, struct boe_panel, base);
@@ -652,6 +699,34 @@ static const struct panel_desc boe_tv101wum_n53_desc = {
 	.init_cmds = boe_init_cmd,
 };
 
+static const struct drm_display_mode auo_b101uan08_3_default_mode = {
+	.clock = 159667,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 60,
+	.hsync_end = 1200 + 60 + 4,
+	.htotal = 1200 + 60 + 4 + 80,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 34,
+	.vsync_end = 1920 + 34 + 2,
+	.vtotal = 1920 + 34 + 2 + 24,
+	.vrefresh = 60,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct panel_desc auo_b101uan08_3_desc = {
+	.modes = &auo_b101uan08_3_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 135,
+		.height_mm = 216,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init_cmds = auo_b101uan08_3_init_cmd,
+};
+
 static int boe_panel_get_modes(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
@@ -782,6 +857,9 @@ static const struct of_device_id boe_of_match[] = {
 	{ .compatible = "boe,tv101wum-n53",
 	  .data = &boe_tv101wum_n53_desc
 	},
+	{ .compatible = "auo,b101uan08.3",
+	  .data = &auo_b101uan08_3_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_of_match);
-- 
2.21.0


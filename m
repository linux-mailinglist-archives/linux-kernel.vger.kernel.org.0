Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8981F826
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEOQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 12:06:34 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:56107 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfEOQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:06:33 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 453zvC5gQHz1rYWk;
        Wed, 15 May 2019 18:06:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 453zvC4xNQz1qqkL;
        Wed, 15 May 2019 18:06:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id rCQpMR94fjUi; Wed, 15 May 2019 18:06:28 +0200 (CEST)
X-Auth-Info: iebjVXC79l8TiIzH4UC9D4oTSAg4lZ2Ww7N8E4Jdsqk=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 15 May 2019 18:06:28 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v4 2/2] drm/panel: simple: Add KOE tx14d24vm1bpa display support (320x240)
Date:   Wed, 15 May 2019 18:06:12 +0200
Message-Id: <20190515160612.6529-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412143715.6828-1-lukma@denx.de>
References: <20180412143715.6828-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for KOE's 5.7" display.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Previous discussion (and Rob's Reviewed-by) about this patch
https://patchwork.kernel.org/patch/10339595/

It must have been lost during the development process, so
I do resend it now.

Changes for v4:
- Rebase on top of newest mainline (no functional changes)
SHA1: 5ac94332248ee017964ba368cdda4ce647e3aba7

Changes for v3 :
- Rebase this patch on top of newest kernel (5.1-rc3):
  SHA1: 145f47c7381d43c789cbad55d4dbfd28fc6c46a4
- Split this patch to have separate Documentation entry
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 569be4efd8d1..c3e5900b04fa 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1549,6 +1549,29 @@ static const struct panel_desc innolux_zj070na_01p = {
 	},
 };
 
+static const struct display_timing koe_tx14d24vm1bpa_timing = {
+	.pixelclock = { 5580000, 5850000, 6200000 },
+	.hactive = { 320, 320, 320 },
+	.hfront_porch = { 30, 30, 30 },
+	.hback_porch = { 30, 30, 30 },
+	.hsync_len = { 1, 5, 17 },
+	.vactive = { 240, 240, 240 },
+	.vfront_porch = { 6, 6, 6 },
+	.vback_porch = { 5, 5, 5 },
+	.vsync_len = { 1, 2, 11 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc koe_tx14d24vm1bpa = {
+	.timings = &koe_tx14d24vm1bpa_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 115,
+		.height = 86,
+	},
+};
+
 static const struct display_timing koe_tx31d200vm0baa_timing = {
 	.pixelclock = { 39600000, 43200000, 48000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -2706,6 +2729,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "innolux,zj070na-01p",
 		.data = &innolux_zj070na_01p,
 	}, {
+		.compatible = "koe,tx14d24vm1bpa",
+		.data = &koe_tx14d24vm1bpa,
+	}, {
 		.compatible = "koe,tx31d200vm0baa",
 		.data = &koe_tx31d200vm0baa,
 	}, {
-- 
2.11.0


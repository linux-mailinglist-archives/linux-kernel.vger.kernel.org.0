Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C316ADB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBXRja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 12:39:30 -0500
Received: from mailoutvs31.siol.net ([185.57.226.222]:51345 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727689AbgBXRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:39:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0BDC95236BE;
        Mon, 24 Feb 2020 18:39:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qrI97RRppLXN; Mon, 24 Feb 2020 18:39:25 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C40A35236B9;
        Mon, 24 Feb 2020 18:39:25 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 863285236E8;
        Mon, 24 Feb 2020 18:39:23 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] drm/sun4i: Sort includes in VI and UI layer code
Date:   Mon, 24 Feb 2020 18:39:01 +0100
Message-Id: <20200224173901.174016-8-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224173901.174016-1-jernej.skrabec@siol.net>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sun8i_mixer.h include is misplaced. Move it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
index a64aaea1ba74..54f937a7d5e7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -19,8 +19,8 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
=20
-#include "sun8i_ui_layer.h"
 #include "sun8i_mixer.h"
+#include "sun8i_ui_layer.h"
 #include "sun8i_ui_scaler.h"
=20
 static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int channel=
,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index b1e1ba2da663..22c8c5375d0d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -13,8 +13,8 @@
 #include <drm/drm_probe_helper.h>
=20
 #include "sun8i_csc.h"
-#include "sun8i_vi_layer.h"
 #include "sun8i_mixer.h"
+#include "sun8i_vi_layer.h"
 #include "sun8i_vi_scaler.h"
=20
 static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel=
,
--=20
2.25.1


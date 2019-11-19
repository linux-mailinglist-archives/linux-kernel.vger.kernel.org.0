Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1855E10266C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfKSOS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 09:18:28 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50502 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfKSOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574173076; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2UrhUYbsD3pMOWmt9KIawFCqDt6dwZ+tLHQeK8ZQBjg=;
        b=gIxkZEYi0V3r2rGBs93YvAPBXiDzGaTirC7WlymA6PdIjhBsacsRLpZG0e0FCCtW9qgDt9
        Z49FfMP17i3mebExiAN8I8C2CbJMQypOjeaMe8QZx2gjHYg1TXDA7EKDE1W0yuG6OwQ6vv
        Iuwu5ENUpaLQWkIW7zCZkZftePkfUWc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/6] gpu/drm: ingenic: Add support for the JZ4770
Date:   Tue, 19 Nov 2019 15:17:36 +0100
Message-Id: <20191119141736.74607-6-paul@crapouillou.net>
In-Reply-To: <20191119141736.74607-1-paul@crapouillou.net>
References: <20191119141736.74607-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD controller in the JZ4770 supports up to 720p. While there has
been many new features added since the old JZ4740, which are not yet
handled here, this driver still works fine.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index d578c4cb6009..46d3ce763bb9 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -829,9 +829,16 @@ static const struct jz_soc_info jz4725b_soc_info = {
 	.max_height = 600,
 };
 
+static const struct jz_soc_info jz4770_soc_info = {
+	.needs_dev_clk = false,
+	.max_width = 1280,
+	.max_height = 720,
+};
+
 static const struct of_device_id ingenic_drm_of_match[] = {
 	{ .compatible = "ingenic,jz4740-lcd", .data = &jz4740_soc_info },
 	{ .compatible = "ingenic,jz4725b-lcd", .data = &jz4725b_soc_info },
+	{ .compatible = "ingenic,jz4770-lcd", .data = &jz4770_soc_info },
 	{ /* sentinel */ },
 };
 
-- 
2.24.0


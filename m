Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F53118B55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 15:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLJOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 09:42:35 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50160 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfLJOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575988922; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ct6x/c5rkTUxi54wAdiOM0BKwMYRUVAzFMyBHA8scYE=;
        b=Ms8qtb5nO8W6T25IvMuAu7YENqQ/rshQ8QTSvys8DcAADm1WbCSmaSdgnbpWrvdLaUH5OI
        yITr2olwjO4IlT+lHeiHJTQbZidtb3X/8SSFICIP1UA+o4gT5VuQBV5/QoOHX+QqpHjd7o
        kzS6SeWlkyDE2RHF5jBqL3ITX3R4jgU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/6] gpu/drm: ingenic: Add support for the JZ4770
Date:   Tue, 10 Dec 2019 15:41:42 +0100
Message-Id: <20191210144142.33143-6-paul@crapouillou.net>
In-Reply-To: <20191210144142.33143-1-paul@crapouillou.net>
References: <20191210144142.33143-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD controller in the JZ4770 supports up to 720p. While there has
been many new features added since the old JZ4740, which are not yet
handled here, this driver still works fine.

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index da681214d0b6..daa3dbeb736b 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -830,9 +830,16 @@ static const struct jz_soc_info jz4725b_soc_info = {
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


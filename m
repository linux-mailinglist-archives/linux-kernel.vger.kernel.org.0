Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70815520A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 06:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgBGF1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 00:27:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50217 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgBGF1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:27:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so434454pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 21:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OPawnjFjdppk48OdmcnT2/7I2TyhqjSstM3nsHqEyQ=;
        b=leq9iVWFFwWc9SzvLj2OAYbrGFc+oehb6yV09Pzq1ffNBybAnHS5RyCURmnyFsX0im
         YaWhNs+Nl6tLggbvcAWNUCDzNlX5w06vGsu5yjYtf3DlLPTZoJsvQlAbq2Zxlqv3EFxL
         1QJBK5hAfU+PS0NW8uNLYDPFvg60Kt9nVRxiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OPawnjFjdppk48OdmcnT2/7I2TyhqjSstM3nsHqEyQ=;
        b=AT5db2QviNtYFFIyt84CisNUQCrdN2mI4zwWmseKHHz6rXaoZ73zn6H0gqmWFD4nhe
         YfFNYuMXh5Xj7dxYIbHdaMSKllBATs1SE9jy7EnHTNXAA1ygUyKrPhZFMo0QyC+BjPA4
         37YCTuKg+YXAD+6/kpykC6pN5VAl8zOzvNduoSJ4q7qeEZHYzUseYXGLwmZrtf6dHmTH
         rzk7Q1VteUGI79wfU0i4Pkxok1nY1AKdVsHxWlgjdJnPw2lPObsBBRiJPQ7LelwuCwmj
         jqMmQgb4o5faro6vYnGy1kiKxPlQagQrqESV67vh4nBIXdDz1yYMbJcpwghUbNkZPYRG
         ch8g==
X-Gm-Message-State: APjAAAUTgsU/vMXFpqMt5GayVLPsmle73SIvXWDnt6+PfHwrHa/mduNf
        +ibJH8iv2iMlxeyzJ6JbOSeZWQ==
X-Google-Smtp-Source: APXvYqxjKyDt1CleJdBxolsoRem+PmuvkMQG1Lq12fr6aeZNGLxW0nPVgS7A8TQfu34JJoOQ5pUshQ==
X-Received: by 2002:a17:90a:36af:: with SMTP id t44mr1758975pjb.25.1581053229151;
        Thu, 06 Feb 2020 21:27:09 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id i66sm1174485pfg.85.2020.02.06.21.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 21:27:08 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
Subject: [PATCH v4 6/7] RFC: drm/panfrost: Add mt8183-mali compatible string
Date:   Fri,  7 Feb 2020 13:26:26 +0800
Message-Id: <20200207052627.130118-7-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207052627.130118-1-drinkcat@chromium.org>
References: <20200207052627.130118-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing only, the driver doesn't really work yet, AFAICT.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

v4:
 - Add power domain names.
v3:
 - Match mt8183-mali instead of bifrost, as we require special
   handling for the 2 regulators and 3 power domains.

 drivers/gpu/drm/panfrost/panfrost_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index a6e162236d67fdf..497c375932ad589 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -667,6 +667,15 @@ static const struct panfrost_compatible default_data = {
 	.pm_domain_names = NULL,
 };
 
+const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
+const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "2d" };
+static const struct panfrost_compatible mediatek_mt8183_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
+	.supply_names = mediatek_mt8183_supplies,
+	.num_pm_domains = 3,
+	.pm_domain_names = mediatek_mt8183_pm_domains,
+};
+
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t604", .data = &default_data, },
 	{ .compatible = "arm,mali-t624", .data = &default_data, },
@@ -677,6 +686,8 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t830", .data = &default_data, },
 	{ .compatible = "arm,mali-t860", .data = &default_data, },
 	{ .compatible = "arm,mali-t880", .data = &default_data, },
+	{ .compatible = "mediatek,mt8183-mali",
+		.data = &mediatek_mt8183_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.25.0.341.g760bfbb309-goog


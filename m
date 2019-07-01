Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F6F419E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 03:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408312AbfFLBRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 21:17:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38980 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408290AbfFLBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:17:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so8557659pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UeBUMK8zne5r7f1B94AFloQ1yKIBEwqxYhdWNW1rcVE=;
        b=Mc/O/i/G8dA9XR5Z2xuOdd78Q3EZA8MUm/uNTtjjqL7M9eg6OoaPGsm3+vX5liu8Eu
         OjaofnIGVXtsD846o0FACmuimMFXHM7GW8NNtNXbQkJuGLHCEAoHFxvY3cPW3eHif7mv
         rCh7+o9qUbJdHA63GM4lKNQXVZWl6FF6gUIwkYE+apHfaUJIm7rhwH99Tcc805aAf8Ad
         Wmm9UBPe0z9REZ10l5vmksImiWRxacTHAIOrYR7rU5KPpOc6DmNfO75z0k/g/gJWEJmB
         tcZiNGiayqBoTJd1l81xwR5dqG1SP0w0UVDu8/iYmV8+FEMWBYSNuT1/JCxkjuVqJ//n
         RS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UeBUMK8zne5r7f1B94AFloQ1yKIBEwqxYhdWNW1rcVE=;
        b=HoFCnUd1rkOiUz1YSXHq4hVQDiF8KpvJtqnWC+pGCpDZFlVJFt7i04Q+HuxdyRvBxx
         vS8iWps0WK1KkVG5M92jzTSX5k90d1+HJi/xQc6FVYrvQcvooPI7MeX0ffQ7bd4qZns9
         1o2j3CcAxNvJ0yWQrVu73KnhdAaYxtxCVb5ERrkWn9c2/YgfXCbWfhrA34cW/MUo92y9
         yVHkEN4EzIPbi7MuRNcFScm9/wFyZ0HdNpKNyb+jzjFKD+2F3DTkjMp4rTYqsDcEb2VR
         V76zv4Hy16J0T3wUnqcoK6m47kwb1JihatOJVA3l5vfD2mJ3LFw3sCR7l0MWzsw+R1p+
         8hmQ==
X-Gm-Message-State: APjAAAUrwQ5C3dcsdV0CenNr2rnEinzNZUJW8v0qymUuISEVU3Bp05eT
        51iuitNsMq0cn4nA1PFG7lk=
X-Google-Smtp-Source: APXvYqyntFmaxAJbB17U4xr3GVjEA8ueDHeFxsQX18ZK8YIFTCP+Ma8Wk0S8hW5kzNdVIgLGkWK4ew==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr9058636pji.136.1560302226962;
        Tue, 11 Jun 2019 18:17:06 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-107-3-185-39.hsd1.ca.comcast.net. [107.3.185.39])
        by smtp.gmail.com with ESMTPSA id y22sm13257015pgj.38.2019.06.11.18.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:17:06 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] gpu: ipu-v3: image-convert: Fix image downsize coefficients
Date:   Tue, 11 Jun 2019 18:16:57 -0700
Message-Id: <20190612011657.12119-3-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612011657.12119-1-slongerbeam@gmail.com>
References: <20190612011657.12119-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of the IC downsizer unit in both dimensions must be <= 1024
before being passed to the IC resizer unit. This was causing corrupted
images when:

input_dim > 1024, and
input_dim / 2 < output_dim < input_dim

Some broken examples were 1920x1080 -> 1024x768 and 1920x1080 ->
1280x1080.

Fixes: 70b9b6b3bcb21 ("gpu: ipu-v3: image-convert: calculate per-tile
resize coefficients")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 4dfdbd1adf0d..e744f3527ce1 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -400,12 +400,14 @@ static int calc_image_resize_coefficients(struct ipu_image_convert_ctx *ctx,
 	if (WARN_ON(resized_width == 0 || resized_height == 0))
 		return -EINVAL;
 
-	while (downsized_width >= resized_width * 2) {
+	while (downsized_width > 1024 ||
+	       downsized_width >= resized_width * 2) {
 		downsized_width >>= 1;
 		downsize_coeff_h++;
 	}
 
-	while (downsized_height >= resized_height * 2) {
+	while (downsized_height > 1024 ||
+	       downsized_height >= resized_height * 2) {
 		downsized_height >>= 1;
 		downsize_coeff_v++;
 	}
-- 
2.17.1


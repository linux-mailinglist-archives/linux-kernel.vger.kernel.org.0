Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0A4D0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfFTOrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 10:47:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45981 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfFTOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:47:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so3290302wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyyHT2lwIblI7pqbXaGA8lthaH3RzK0tbWj+O93TtPs=;
        b=Oit0hFLJiNyL9EMSEqexEcPXKgySrpANwU0lVIrg7hHPpm+tC6du8Xwa0nqH+37qDB
         kVnMVGC2CbL6Xo8bWlAAVR7wzML9t8QatRqDQ9OFvVXs8Ko1+a2DqPqv5O4Ae9CpT+VH
         CbZvW0Kzy524h244pqvDUS9FQfHcOgiejizU+DFkR3HOW4UPSp9Oy74e8/nSVk/+vl+E
         zqte5zaoEnGWau1/BoAmgAm3CQ1P1GfPd1/gkdEKfe3BGnWbyX0Fr5oitGvMIrPOVtvf
         0K5V1191mLtxlfVEZTgf3fAhq9Kj5m5n6y8+WbvdikSJNUNP5cceEUwEbjc+YrwUl9oe
         8vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyyHT2lwIblI7pqbXaGA8lthaH3RzK0tbWj+O93TtPs=;
        b=Ybhd0JwTUTf4SaQzlQaVxIl8DlICT9SEqzj+f79v8wxbYCtlKrshexgU5dypMq47b+
         uHjI1VFUd+RUteq7xsz/x2n5x+kYT+VrKmXOWZ4p8Twwj2yAbJhKYTc/kqHcOwHgYjAA
         lh6v6rc142MZoaIgPbgvhXEFfeLzhj9nCVQ4+YhNVl1B5Cw++lkSvOOqFPoJ+n+9E6Qn
         LHtBDAbISx95L6g/bjL8FtnnFH2n8TIqt4CAOWqFC/nC8p3l+X3l12OGPkcFOQRfRK7W
         0S6p/2g1YpN/33kYnd4lt2MDVyMIe9ZCfg3Bt7HCc4ld0PTAmPZMGaHN5qX5wQvKFCiR
         AT+Q==
X-Gm-Message-State: APjAAAWs4bAxh5Hgb9Y8aaA8JnbbY/8HnbiqVd7n1HL9c7oznh+Al/Th
        TodWwOC90h908V5ZN9Im0+EGVQ==
X-Google-Smtp-Source: APXvYqw3Z7uKmbYj8tHPoxZ0pdtdU567UPfWnhCzUL9GENblV9yERFF+nmh7LNw95ZafmmZ9x2hYuA==
X-Received: by 2002:adf:e442:: with SMTP id t2mr17566195wrm.286.1561042018342;
        Thu, 20 Jun 2019 07:46:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i25sm11297806wrc.91.2019.06.20.07.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 07:46:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH] pwm: meson: fix the G12A AO clock parents order
Date:   Thu, 20 Jun 2019 16:46:55 +0200
Message-Id: <20190620144655.2142-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A and G12B Documentation is wrong, the AO xtal and clk81
clock source order is reversed, and validated when adding DVFS support by
using the PWM AO D output to control the CPU supply voltage.

The vendor tree also uses the reversed xtal and clk81 order at [1].

[1] https://github.com/hardkernel/linux/blob/odroidn2-4.9.y/drivers/amlogic/pwm/pwm_meson.c#L462

Fixes: f41efceb46e6 ("pwm: meson: Add clock source configuration for Meson G12A")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5e65b042c240..e15d045947bb 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -453,8 +453,17 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.num_parents = ARRAY_SIZE(pwm_axg_ao_parent_names),
 };
 
+static const char * const pwm_g12a_ao_ab_parent_names[] = {
+	"xtal", "aoclk81", "fclk_div4", "fclk_div5"
+};
+
+static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
+	.parent_names = pwm_g12a_ao_ab_parent_names,
+	.num_parents = ARRAY_SIZE(pwm_g12a_ao_ab_parent_names),
+};
+
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"aoclk81", "xtal",
+	"xtal", "aoclk81",
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
@@ -498,7 +507,7 @@ static const struct of_device_id meson_pwm_matches[] = {
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-ab",
-		.data = &pwm_axg_ao_data
+		.data = &pwm_g12a_ao_ab_data
 	},
 	{
 		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
-- 
2.21.0


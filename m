Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF21128E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 14:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLVN3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 08:29:51 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33992 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVN3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:29:50 -0500
Received: by mail-pj1-f65.google.com with SMTP id s94so5038935pjc.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXOcwXSpTDZpb+/TcTbfTiplV6hYObjzRW1vf2xFZRA=;
        b=I3PQ33U14EAolLLj8jlrmUJ/O9DIkC6SXNrRVAoW9isHRRLbh0z685MsUAAtjr60en
         UzggneMmXWh6Sdorq0YMf2qD+5Zi4RnYC350HCHCRJPy4evKsI1sZcsdE2rXY2dTYvT7
         1PQ9gScLj5oAiJ/wwt8CJTwOu416Ss5/Im9YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXOcwXSpTDZpb+/TcTbfTiplV6hYObjzRW1vf2xFZRA=;
        b=HiNdFJFDEqvzECArfKhsM4A5KzqBv2ZH11+KrpkJW6GZQJ/LLOBulBnaZG+Zn8mrom
         eFM98u0ENtKfPcGzxxwYxRqNhTYm6RD41H126/1nSInQYcqdg/iPjD1pwfwy7D280l2s
         afkThKElewybi9WVtF66Vowbie6YB4OTFm73UKXFNCUJZawBv/UtRtlk2IpFWtOo7+x/
         PKilF4Db2Q08NDY1j4sXxYb+eEpiO9DvYNJXytnubVuKH4b9EfUWQHePr3K57T2W7u2S
         DzP9HD8XByiH55oE0wOjyGniJ7ijzy0ZNwNxk/ttoJZptT2roa4RHr+z4YeLQA2Lg8Vd
         /qQQ==
X-Gm-Message-State: APjAAAURCCCWNre4TT+4a3OM8f/MWUYWXyLP/TYObfRtk9/hAJjenK7e
        v7N1g58PMCMavvYvwPl7grE5jAZO60A=
X-Google-Smtp-Source: APXvYqyIL1psXc/olK/QSRgQqBxtxjvsmTJrG5PZsaaCso/VKkCbYbl+cm8ubF+spBhD1JmKttrayw==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr25655198pla.182.1577021390160;
        Sun, 22 Dec 2019 05:29:50 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.16])
        by smtp.gmail.com with ESMTPSA id o2sm12073058pjo.26.2019.12.22.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:29:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v14 5/7] drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
Date:   Sun, 22 Dec 2019 18:52:27 +0530
Message-Id: <20191222132229.30276-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191222132229.30276-1-jagan@amarulasolutions.com>
References: <20191222132229.30276-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so add compatible
for Allwinner A64 with uninitialized has_mod_clk driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
Changes for v14:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 2577b237d06a..4a024951aa11 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1256,6 +1256,7 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
 
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{ .compatible = "allwinner,sun6i-a31-mipi-dsi" },
+	{ .compatible = "allwinner,sun50i-a64-mipi-dsi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.18.0.321.gffc6fa0e3


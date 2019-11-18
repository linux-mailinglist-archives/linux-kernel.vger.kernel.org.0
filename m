Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553BD10046C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKRLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:40:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46412 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfKRLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:40:13 -0500
Received: by mail-pj1-f68.google.com with SMTP id a16so1415932pjs.13;
        Mon, 18 Nov 2019 03:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKlXFmsyCCcDDwPIPUpIzSPGgE4nu5epjuY/dy6jNM4=;
        b=ROuGzm4jkxrXQOcqLXKOOHwYgxDKwtdPl3VFO5rmmHsV1yBi4P8YFqizjyeHwzceSm
         NTwkx2EPcWAlt2MSDtu17OAdb9h1kHTZ2fFPvUFN3W+rvpe1WKWpC/YvImORx4Lx3UfP
         +zvyMSMsSqHOJhHMxRmHZT+A5r9rvh+R36tPkhcC86rtI9t7T00B2X5ftPl0q/uk9dTG
         9tGWjvKyI0dNVhq8TBFPW3wSqvoU9FiyDXk81jWxks+VNiz8/bvtINGEwtZMFGUliW6E
         MmRoh/81FIXROovu5KFBZF1PaD7Y0i4NZTpMOQ6AfJo8pAwK5xYlYPfXylyBF3coPa5q
         JEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKlXFmsyCCcDDwPIPUpIzSPGgE4nu5epjuY/dy6jNM4=;
        b=NC/sjbw8MmZ1FwH1yJSUu8ycgsQlgjPIPNxbW4uUqekoA3XTpiOgxKbxBy3csBzr/c
         9EX3kt+ol2/u86cm90U1Y9Umtuk7zHafwBbuyTlwhueryqIZlDA1mwHE8WS8q/LKs/Nj
         NWLj7DAsuKGgcIm5n8c6Q4d7UyGoJQKU+dMt8f46/knpT0jpGCZQHC6vUmwiqUpA7kII
         D22kg992Hft6XnZvCddCBCSGej5n8HNy5P/RZP0PJRArkrNdEOt8FHJNqt60GyCtEg92
         SwutBo3KkT79sUQ0oi58UOT9HAV2FSqnk6FpHxwBYLPetUX/DdQPrXhnxg58NMk2tWkb
         lFyA==
X-Gm-Message-State: APjAAAVRQoxwnT4SAF8fX+lLGcn8fkTGAD2PDNxvjnExkfDd7RVpT2TZ
        jFx5EnXRi2dG2DcK1UPLT44=
X-Google-Smtp-Source: APXvYqyn0Lsr2kVbd6T3MWbNxpcGTpsIQ/Ohr+Rq2gUm+qBRKnowv1C9yHHyvWVJjkkaPpH71dqLLw==
X-Received: by 2002:a17:90a:9741:: with SMTP id i1mr39483570pjw.41.1574077211147;
        Mon, 18 Nov 2019 03:40:11 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id l21sm17515128pjt.28.2019.11.18.03.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:40:10 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/exynos: gsc: add missed component_del
Date:   Mon, 18 Nov 2019 19:39:55 +0800
Message-Id: <20191118113955.25373-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call component_del in remove to match component_add
in probe.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 7ae087b0504d..88b6fcaa20be 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1313,6 +1313,7 @@ static int gsc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
+	component_del(dev, &gsc_component_ops);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 
-- 
2.24.0


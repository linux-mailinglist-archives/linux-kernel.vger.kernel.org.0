Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60A291BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 06:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfHSEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 00:06:38 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41630 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSEGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:06:38 -0400
Received: by mail-yb1-f196.google.com with SMTP id n7so148923ybd.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PPbQdYyCeikWXeCzzJyCalBEj0GFXKEGI6wDSmoOtt0=;
        b=TuMbiSJ+LiR196k85BhnGwrkna3ZbNm3rLphguZJlMWsqOLNO9QHlrXiwwjZPmHW6P
         vrfSxzL04JlSPiC/yOL4/TgNJ7kPMygpJf7oYI15WRFYWVUH28fftR0d0ci1jtTJRoZ3
         bVtx+/Z5dPvpsNVDsFnqJPr4ZUhoGnEcfFttPaMpxANHqaK60XGPbs3V0gPjltJD0Ljm
         gt7K27sTdgk2r6UFG0IaDT24EMZnINBDh7a9qazmV9ZL2nzW1AFWlYHtdsbcl8A98bjR
         1qPr2aKsoyZAHeXRmvoBlWuFSCdoJ3OuXt6Lm1GUZQ5xDwFswnUZwGEFHVeG260lDRXe
         7Dpg==
X-Gm-Message-State: APjAAAXYKwWidVGinznhVDkGJyNyKnbNTIBaecVQLispuCoZssz4wqvx
        uv4mPkywCZqGhGA4+Zx7xeo=
X-Google-Smtp-Source: APXvYqwcvjZFzcZF38VQD30/+EabzvCtJOhM3mSDUJSUUmo/bvyIyKyY9r562Bj79wYPEekrUx0VhQ==
X-Received: by 2002:a25:c603:: with SMTP id k3mr15008655ybf.409.1566187596936;
        Sun, 18 Aug 2019 21:06:36 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id l82sm2939148ywb.64.2019.08.18.21.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 21:06:36 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/gma500: fix memory/resource leaks
Date:   Sun, 18 Aug 2019 23:06:17 -0500
Message-Id: <1566187591-8263-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In psb_driver_load(), if gma_backlight_init() fails, no cleanup is
executed, leading to memory/resource leaks. To fix this issue, go to the
'out_err' label to perform the cleanup work.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 7005f8f..8d264ad 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -383,7 +383,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	}
 
 	if (ret)
-		return ret;
+		goto out_err;
 	psb_intel_opregion_enable_asle(dev);
 #if 0
 	/* Enable runtime pm at last */
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF11F2AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbfKGJ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:29:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46619 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfKGJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:29:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so2105910wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=O+PJ1ZZn/46Tl9iY76CTFXkJGMuUClMcIKHPnfX67PU=;
        b=ExSSkNBMRaqpENwcyHoUMKVHRx3ERHMBPqqA7vNtUGEM8uyNE+q89FAIx4p/bXQ80y
         xuuu2alYaeIc/YDffYAgPI/VkJ9LWRJrTxHFGX8VWQwysDcT+y1iZ0LXPGqx00A3yVUI
         0VXzjUXBPH0RN7eascN/a8xn9B+qwMneU0yD8OKnU5gMKBaaBfvomqid6hshuXeTbDMB
         +VXKMjc2+5O0+iCl8fM083zJgKxW+htnmS36fEw+vt+5jfq6OYKIEJ8ddX6lXd5Y3pPY
         EWUw/neg7duyc37aqN/EAe7EW/YXhUU08xGynlny2LoQgwIOXX6phgXUqroQbuYk/JGa
         eZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=O+PJ1ZZn/46Tl9iY76CTFXkJGMuUClMcIKHPnfX67PU=;
        b=iofLSzA2QnfBJJEAEzo1754I9NYB8r+fIlzTcmK62svptBiPLp3DbZ3pmv2Yy49tuf
         QghEwpEO1tUHtM8RXcA6cnFAQN7ZAlGeEh+8+8yE5DTU159JmkgkCQ0mJPN4IDr0L2n9
         112zdtotv1DeTKp5LmWSnbrhcSjEGvHFpzT77StoGK5CuzY+VHCKdvk7TxVuTXTRbfCp
         jo7aKaAEbNcG/9oJB59R5zfaCmMSmx0LciW53QOnim0/n/F8Bpy4U7tC6F8Sep/jf2An
         gmmBYsp+xsRMaFvd3VG8dOrE19PPJDwzMJ+gNXCz0KB4oDfsMjt3axa10FleJQmuCoZt
         B7qA==
X-Gm-Message-State: APjAAAX/n4+P+w+THX7t3x0n3yFGrTgVP8sKe8kLzO90guZ3KxELl/cm
        dOfDkJNBgseeeY24ICyaUXc=
X-Google-Smtp-Source: APXvYqwiYbI6O8+aUPp6Ep2W/Inr6Kp4MKn0CHA3p1g484JYEvk7zEomTG0WmL9mVQ81Yz5M61a3fA==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr1829599wre.11.1573118995612;
        Thu, 07 Nov 2019 01:29:55 -0800 (PST)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id v8sm2323607wra.79.2019.11.07.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 01:29:54 -0800 (PST)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
Date:   Thu,  7 Nov 2019 12:29:45 +0300
Message-Id: <20191107092945.15513-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of the dev_err macro with the DRM_DEV_ERROR
DRM helper macro.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index bc073ec5c183..5f23cf702cb4 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -916,7 +916,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	}
 
 	if (!dsi->cdata) {
-		dev_err(dev, "no dsi-config for %s node\n", np->name);
+		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
 		return -EINVAL;
 	}
 
-- 
2.17.1


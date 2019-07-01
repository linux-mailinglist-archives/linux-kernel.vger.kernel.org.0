Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C334ED14
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFUQVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 12:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfFUQVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:21:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8272921537;
        Fri, 21 Jun 2019 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561134093;
        bh=pCt3wsZcryFCye2Z01SjWL3uA/rMoy9d+YZMP7FdH/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AG3vTmqUB07tvd9tDJps6NreYgpS4FmRwd5ZVKS6Ck0hLbr7zv6VZewpafvivoOPp
         LDU3tmkha4JItwU5YPkm1OzYuyDWbpWu0FOsnZxHY2ZXNxDVHTkoIEETm8KW/xhDqx
         ddQhqPZkFjS7okW+cNBkLirj+I8z8JtiTMNfgGI0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/4] drm/lima: Reduce number of PTR_ERR() calls
Date:   Fri, 21 Jun 2019 18:21:16 +0200
Message-Id: <20190621162117.22533-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621162117.22533-1-krzk@kernel.org>
References: <20190621162117.22533-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the PTR_ERR() result in local variable in clock init error path.
This makes the code consistent with similar section in regulator init
code.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 drivers/gpu/drm/lima/lima_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index bb2eaa4f370e..9a6cd879bcb1 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -83,14 +83,16 @@ static int lima_clk_init(struct lima_device *dev)
 
 	dev->clk_bus = devm_clk_get(dev->dev, "bus");
 	if (IS_ERR(dev->clk_bus)) {
-		dev_err(dev->dev, "get bus clk failed %ld\n", PTR_ERR(dev->clk_bus));
-		return PTR_ERR(dev->clk_bus);
+		err = PTR_ERR(dev->clk_bus);
+		dev_err(dev->dev, "get bus clk failed %d\n", err);
+		return err;
 	}
 
 	dev->clk_gpu = devm_clk_get(dev->dev, "core");
 	if (IS_ERR(dev->clk_gpu)) {
-		dev_err(dev->dev, "get core clk failed %ld\n", PTR_ERR(dev->clk_gpu));
-		return PTR_ERR(dev->clk_gpu);
+		err = PTR_ERR(dev->clk_gpu);
+		dev_err(dev->dev, "get core clk failed %d\n", err);
+		return err;
 	}
 
 	err = clk_prepare_enable(dev->clk_bus);
-- 
2.17.1


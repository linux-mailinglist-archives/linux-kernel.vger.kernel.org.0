Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFB9E928
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfH0NXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 09:23:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52960 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0NXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:23:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id o4so3089246wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TbeTaGGWYk6FIBTAg4Q/ZaK7rk4CVve/t9kmNBDtugE=;
        b=wq02lPcezSrbkTymEC7WovVRByb559YaQN7GHqXzcdfQgrfNed1VHwZ3WUcQ/99dXh
         JcS3ZK5swJ7YDJ6b2MKh5iSzcByO41XpiCN5UZbe3MMe/3ZNxmdM8GfrNYI5JvvBNThr
         E0R4pRM1za8jBVlzncubC3EWQcybUZWWnrPfWirNc7hfzz9jVT4b3jsDzTI6l42gnGBX
         skrE3ypIZnePEmp8gZCTUVXYp2bIZmit5hBhMOp7hljcllsBxr+SIHswBZ1K7PeaIjEU
         67Bvw3bSLCDasCRed6dskrjNXiIlx2jPGg9IQ4rc4y3y1+iNWXSJd8LsSP+kYhtZfckw
         Zb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TbeTaGGWYk6FIBTAg4Q/ZaK7rk4CVve/t9kmNBDtugE=;
        b=fKS+Kw5/YmX5fCahpHEz3D+zQ1eO+jD5BMDuDb8Vsk9ODt5wX0f6o0P/A+e+P/WBU2
         gTY2eiMebkjykZgcm45qNbUOSdwNAf5IZKHjugSpRbnmc2zbtKYBzygdXYQOkckYWFth
         ZNZEY17HSSNMMT6bjgEOExn6ZOyZl2WokDMbe5YcxLZalix4xBAXvdsbaNx4ixgs4SJm
         kG6cx0bhWnZxQlAZUTLP9EdeBTQ59Tv1thihZHEfDVh5JsjKOJTgjbELbnY7Wqe9+Y1n
         SLGPP8MPHGhLq9u/z6SPWNxCY57fnMMevE02FASaBkzQYMEAq8dzggynJF7ZFzzD9ONn
         VLIw==
X-Gm-Message-State: APjAAAXjxlVac2R2cmly5jYbDvYxhz4FWXtoHKhctvJ3/IIU8b7NOcwO
        e854HrL06e8/F7kF/72+fzoS1Q==
X-Google-Smtp-Source: APXvYqzC+0C4X5drnwFV1SZJ1aMV88RFfx4cY+/vp9O6WxCp+QNUmnpY+qWDNNLZRPftbGBE1Qvmig==
X-Received: by 2002:a1c:a008:: with SMTP id j8mr28626762wme.57.1566912186112;
        Tue, 27 Aug 2019 06:23:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.174])
        by smtp.gmail.com with ESMTPSA id l62sm4678345wml.13.2019.08.27.06.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 06:23:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] mfd: rk808: Make PM function declaration static
Date:   Tue, 27 Aug 2019 14:22:56 +0100
Message-Id: <20190827132256.26807-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids:
  ../drivers/mfd/rk808.c:771:1: warning: symbol 'rk8xx_pm_ops' \
    was not declared. Should it be static?

Fixes: 5752bc4373b2 ("mfd: rk808: Mark pm functions __maybe_unused")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/rk808.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 9a9e6315ba46..050478cabc95 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -768,7 +768,7 @@ static int __maybe_unused rk8xx_resume(struct device *dev)
 
 	return ret;
 }
-SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
+static SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
 
 static struct i2c_driver rk808_i2c_driver = {
 	.driver = {
-- 
2.17.1


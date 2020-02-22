Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4B169047
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 17:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBVQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 11:25:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36617 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgBVQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:25:08 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so2142353pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VcbN+zbqnNuxs1Y+XpjZhKj62zQGe5VKHxFInvYNzhY=;
        b=XkrY8yO4wKTo1Ip/tvQeTKJ6BzqMkJdo09DcPnZHfMbhF8ykoejeQh+siDxQLdIimL
         qn5Sz4uupzVNkVPjXrEYXgm101KJVUF3dB5wABhKDecayZ7Zn3BtMJtPGlE9aVQAqGnG
         kwiUp7nlyF+uhreEYdaZZpvI57blTv9VB8HN2ZT+ndjzpEyk2hPHvCvM03ZP64ZMs7ky
         /Zu4yfinheyLwFBGvn3vLSu33X6gSq6brXGxMjNVcSxGVdKT4Z03s9SMCBzHef3g6VhD
         mhuHW/BSrvmEUJ7PUF3ICazyTYRHdRhWPwuPklGPwwrzfeT0y6hn0/95iIGSYjy/maaT
         h//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VcbN+zbqnNuxs1Y+XpjZhKj62zQGe5VKHxFInvYNzhY=;
        b=lx8CRtSBitJCyAOOgfvDbCEcl/7LQFjjYmyS5krfpvMuf9eJym1PMxGU+TAxERs1Fy
         Xc8ZZNBU8lK4TRShYAaoMCgGGshGrqplDNUGg4Tyv8agstGKxT96AzLSFi+GYpsqAmk/
         ZFRP0OVYQSzSTVAnHKRYZx3dVeYUXRDscUQSA5w0GzGTTAlC68k4JzvnW++Yj1MiXMqv
         JRf5Z4t0aDCXOmg235U342SvQD9uLY2NvChgW6x7kfj4Sa9ddHEBvr9FOM4yDAobCmNl
         BV/zuzWFim+atrma+NYcPycT22bcwUBRVROhQs4Lw+5ft5LFGyD07YBgvYi0FETjL44g
         TzTw==
X-Gm-Message-State: APjAAAWgJG4hMo50udshjvZliwCRnIHep05qOQsvt3UBDSRsXz6SVb0k
        c5MTwiM48qd5JnBo1v3YCnxg
X-Google-Smtp-Source: APXvYqx/LFN4kFjlJlu5S7c+YgXjlHWaEEHF6Jx72iqDrj6XzazM2iceQO8QQj3BejL48ZDwDwQ9dg==
X-Received: by 2002:a17:902:b409:: with SMTP id x9mr42518281plr.218.1582388706985;
        Sat, 22 Feb 2020 08:25:06 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:801:b38c:89e8:305c:23c4:b77f])
        by smtp.gmail.com with ESMTPSA id q17sm6851296pfg.123.2020.02.22.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:25:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        adamboardman@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/4] dt-bindings: i2c: Document I2C controller binding for MT6797 SoC
Date:   Sat, 22 Feb 2020 21:54:41 +0530
Message-Id: <20200222162444.11590-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
References: <20200222162444.11590-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C controller driver for MT6577 SoC is reused for MT6797 SoC. Hence,
document that in DT binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
index 68f6d73a8b73..88b71c1b32c9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
@@ -8,6 +8,7 @@ Required properties:
       "mediatek,mt2712-i2c": for MediaTek MT2712
       "mediatek,mt6577-i2c": for MediaTek MT6577
       "mediatek,mt6589-i2c": for MediaTek MT6589
+      "mediatek,mt6797-i2c", "mediatek,mt6577-i2c": for MediaTek MT6797
       "mediatek,mt7622-i2c": for MediaTek MT7622
       "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
       "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
-- 
2.17.1


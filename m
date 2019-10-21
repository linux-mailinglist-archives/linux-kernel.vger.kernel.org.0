Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10AB9DE2D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfJUD4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 23:56:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45199 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfJUD4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 23:56:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so6892603pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 20:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzN6sUwiXsGiG0QstYd2dvfeg6/B1PwWJvQoun4TY3w=;
        b=x2DVwu8hxWO/tIGOY+mw63ppGx1pqI/eZFZwCc4QdjzK87vadub6fctBWh8VqjgJ/o
         5fHfeKOKt1y8Mr9FuqAH/YznIJFYx/ZWwodC+oCkaKcP4cdsupYCE9WxRmzyBJ5QHUFM
         2ZtT/m+nVjlvMsaAiVil0s77A7AIZVNBqseSHcVcNHmJHAKz5ncfbRyiNOoLSA6JFiUs
         HVh2lk9CcQeEXtZ3y7WLJFeV4S39T7NDxg7u8MDELtVwoAL8r59vKZGSZHf+6fa4+UMl
         gn95cPMDGSwgS+YKpdVbYpwWIuNSsQON+qVRdu7W0WWDJ+/QD0A5b7I1pDpgyQhFui/c
         NEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzN6sUwiXsGiG0QstYd2dvfeg6/B1PwWJvQoun4TY3w=;
        b=uP9o1Q8x6fadkqhMmr2dHRFdhymrTy4elT0IIzz3MTdiBiDnfuZ6VCXnFRF1HAEvyh
         VTX+97iHM/HGZ1tJAbBFst0zzVBU+8+qpUiEoLDHWGC9pt+ww8Wf5XaY2ld2EkNMnCmP
         EFk4BqXXaU7KK98rAv2BNI4xxOmxfmooqilBh0TBPvpgWNMYtkRw+z7Ri7qA0ilaUw8P
         QrCUzCe9aOd8MtnhsFNorEmeksnxWJWmOKOYX3T3rpBBje0jz/qKO3wMTsOamJINPc96
         +s+c1LF6fLBN5c2d0NNkEILu5VuCIQV4el8iw/+LZeDX9xNwKXRfRPHOO0JZTvaUHLLo
         42sg==
X-Gm-Message-State: APjAAAWmI8n4rIXNOqMKa+6qzRGJeP0Gt1bGB1z/FX3DjGQC6S+aBGia
        T6CMP9zAGkfY4sj4d7rg2+TuZQ==
X-Google-Smtp-Source: APXvYqz91vILzKwCwMpXw4c4MDum21nEhzA0IzWpvQxk5Xjbqxh2R6MjJYT42v2BMZwkh3wIlyC3CQ==
X-Received: by 2002:a17:90a:3702:: with SMTP id u2mr26313063pjb.57.1571630167781;
        Sun, 20 Oct 2019 20:56:07 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o185sm18760540pfg.136.2019.10.20.20.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 20:56:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm watchdog driver
Date:   Sun, 20 Oct 2019 20:56:03 -0700
Message-Id: <20191021035603.4186317-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the driver for the watchdog found in the application processor
subsystem on most modern Qualcomm platforms.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4591bf1303da..f3d95f77fb0d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -463,6 +463,7 @@ CONFIG_IMX2_WDT=y
 CONFIG_IMX_SC_WDT=m
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
+CONFIG_QCOM_WDT=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
-- 
2.23.0


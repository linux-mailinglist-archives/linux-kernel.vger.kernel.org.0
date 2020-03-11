Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B511825E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 00:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgCKXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 19:32:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33241 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbgCKXcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:32:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id m5so2057715pgg.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAFxnU3NgpJMRLveB1Jihkaz6R/8FOdMPSF2gijKBWE=;
        b=RQnJ/B/XeSshmnos7GbXMEoonGg2/3cDqgKr1Pp8lC9PlWN7SkhRbcX7KTF7i3dkkZ
         ZnNwYPwTVpxTdi1m9i21YZACZzEdehahf5C8jse8o0DAIa0WHeJ2Cuodt8MExVHa7XC5
         hvOPCnF7rT6SrSdz29jq4rBXUyc8wLhQTEYfIFfJq6cwKWIHEofYDSv5Tpcjc5f3oK5C
         6koZQsAjIwMgnVps0Q6exeHjuc1D/DRvax8MqIe8Ll47uX3X1C/GHUPd/BlhDE6eLSlm
         pNQ3D3PmRgVmJ01pXu8eWHSgXt4CLXsqRlUefG6iN7PZ/Erk/VlsSVC35pJxlmpY1Wyt
         lwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAFxnU3NgpJMRLveB1Jihkaz6R/8FOdMPSF2gijKBWE=;
        b=gkr2/E124TKOuPa5GiLOgnpbb/HrjP665b9MZOiKHPgbkg4UPDkOY2aZ+T4TZz3cMC
         mb8rLn9UXRlQFdFDEC7PMRt2MLnPYJk6kJfw/If9Fzoi8J8xMPnrq3SVKFJXXA1272qf
         hhAgiT1/MnpeXI4/21jUJY+ziGnD2428iaruW+HWSw7sq179thTqs96NjwSax8fQgRJj
         ms/S2WzaIdwEUIvU8wNaP57BCE13+yg5jNi1Ds4u5OFaiAbGkxhoVEkFdXCo0a9vwLbL
         5HWNqTMd2uQQgh9cWe+eF2QadW1p0hFRF2vFK8JWwhYn+YcsUkAl3V/eo30X7dzsWd9n
         otCQ==
X-Gm-Message-State: ANhLgQ15gkRz6RzYApct9xx5ukIkNtUc2Gfnmg1bDa3n/U+UFntaOaTP
        UzT4Y48KEzqFThnna2BaVRgUEg==
X-Google-Smtp-Source: ADFU+vssJZbi4+8lRsENa/Dx4wELabrI5tBFSOR/chzDO+9tWUirfJxgeaXL9W7NYjIV1v7Tyvfs1Q==
X-Received: by 2002:a63:441e:: with SMTP id r30mr4888212pga.51.1583969532339;
        Wed, 11 Mar 2020 16:32:12 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d77sm40505835pfd.109.2020.03.11.16.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:32:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Olof Johansson <olof@lixom.net>,
        Anson Huang <Anson.Huang@nxp.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Truly NT35597 WQXGA panel
Date:   Wed, 11 Mar 2020 16:30:39 -0700
Message-Id: <20200311233039.928605-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Truly NT35597 WQXGA panel is found on the Qualcomm SDM845 MTP,
enable the driver for it.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e8be14b93b40..07b57510394b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -573,6 +573,7 @@ CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_DUMB_VGA_DAC=m
+CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
-- 
2.24.0


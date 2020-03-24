Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF27A191588
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgCXP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:59:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46536 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgCXP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:59:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so18734492wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMq/EEyYYz6HWydBGjI4fuaJGHB5g+sKYV8/ecTsfnw=;
        b=Cbo4qeBnndE69etkLuKizylOxVcCmcdaFqQ8/ct9sDJJikWNyXNk8ZZ6zLf4hRPrMW
         l56jslKnUGo83vKTVAvhBIxzyrrH/9UvzP8GGTkw269WE/tUp1c5vHiI3guPOPFx+2jU
         otpKMEXqs7w3tXsYyzTrwAL1f6ht3I7RTewqEhEXXRtrQzXmOIhfZ6BZtuNaDtX/QGhF
         d8uR2xGZ+x+amFl+Pc1YODdzgdpqURlYziqetHbkrNP+k9GzC8A+XSTszxlNST78rD5I
         N+YlxU5l68N9n294cQoT7qG53b102vbtwQluMbmo2KHjKF2Aq6dijxo1T53f39+1yEEf
         G90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMq/EEyYYz6HWydBGjI4fuaJGHB5g+sKYV8/ecTsfnw=;
        b=siWRtwHC9SpK5IjWH+Em+7ryiYUStd8xTeNtCm6EKrpdLBv8xRVRxX1wOPmpbJeDvJ
         jLGRtdTsLVNQ5jamBw6X0to0htwYAfTZ7CBhZ2Bs33sNZRoSQ3ingk8zil5oe17npDYj
         RllVX6mF87gCAxeN6Bf11p5LX74Hpe+IADvbGLyjaCJZQpbM1eaxigmSK0430KfijTvc
         bNcf1J9sLZS+eEkcPjRe8C3owcGoabppIWwcTBK3KmlmdkvKbjtcJZDjE6ny2VJB6LD5
         GwFHRcLaAnsSwf7UkezvoqEIMtvXVchs2tZLPoBgpJUiZv1EsLYdwF0F9lojHFg2HBxT
         5J3Q==
X-Gm-Message-State: ANhLgQ0mlnhThDPUOi6/o5YkBahB7vHS4aKzEXL5RvY8qRpbnsDsCmKR
        rnSdQe19eBPpDckQWhHF10RYLw==
X-Google-Smtp-Source: ADFU+vubkYQyMAvXnpVSqfNhDN699hpGdG7F6l9ggO5EBX7SXW1DGYqomCS6qxOHeD7C5nHYtfLhYg==
X-Received: by 2002:adf:db02:: with SMTP id s2mr29329992wri.273.1585065537393;
        Tue, 24 Mar 2020 08:58:57 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:e15d:2127:89a:e5dc])
        by smtp.gmail.com with ESMTPSA id t124sm4993321wmg.13.2020.03.24.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:58:56 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v3 6/6] arm64: defconfig: Enable QCOM CAMCC, CAMSS and CCI drivers
Date:   Tue, 24 Mar 2020 16:58:42 +0100
Message-Id: <20200324155843.10719-7-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324155843.10719-1-robert.foss@linaro.org>
References: <20200324155843.10719-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build camera clock, isp and controller drivers as modules.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
 - Removed duplicated CONFIG_SDM_CAMCC_845 defconfig

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4db223dbc549..676bb53fb8cc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -376,6 +376,7 @@ CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_OWL=y
 CONFIG_I2C_PXA=y
+CONFIG_I2C_QCOM_CCI=m
 CONFIG_I2C_QCOM_GENI=m
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
@@ -530,6 +531,7 @@ CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
+CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_DRM=m
 CONFIG_DRM_I2C_NXP_TDA998X=m
 CONFIG_DRM_NOUVEAU=m
@@ -732,6 +734,7 @@ CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
+CONFIG_SDM_CAMCC_845=m
 CONFIG_SDM_GCC_845=y
 CONFIG_SM_GCC_8150=y
 CONFIG_QCOM_HFPLL=y
-- 
2.25.1


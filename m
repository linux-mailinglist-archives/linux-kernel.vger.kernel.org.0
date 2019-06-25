Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8F554EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfFYQsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 12:48:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33995 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbfFYQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:48:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so18709941wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcbl8ChfwpCVGld5/sK0LNsZGkcTLX971dUfy4ZOQ3A=;
        b=MhhfRXFC/O4fApCrRU+UEPBMIO4zXJaa+B3xH3DSICHRtsJb3L5oZfoEIPsOkVsPoB
         r5xeKRk3PBP/nAjnpFIKYZ4RpM11XPXdNXIf6XXaWscJ4rE9gEWZwUzYhsESRsplQNvL
         lzwoNk1MMiEJocRE9guRM0JPjihHU8FVkKvGrTH7aPQ0RxNJd3iDAa7DcUb1/WgZpmA1
         NYW5UijBJGQR5XznxvPx/5GS2BTRwQXUrGY/7FOkwIV31Ew1ryaufTkxuLQzrSo8ALB5
         QJFGVqkjBEP+DSe/fAD8rRt/+yqqqwZz/F8BJTTjor8sBtWRpfgtdvxeSSKuuuetzAqF
         55xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcbl8ChfwpCVGld5/sK0LNsZGkcTLX971dUfy4ZOQ3A=;
        b=aoe3iZTnl583IpLoMNgC29L5JUDMWGSMV1Lw4MyZ/IO7wueYJGBF+DYdFRyxsFnC0L
         zwiBlU6kDLoYYatNlX8CA9o3s9yf+wTXuEB3veifD5PPEPzZE986dUn7fk44f6WjSYz9
         TiZclwu2QPzG44CU/apA/a9mctH+CtLugo/q3cVtAF5/qbbLsTpj7/LpPbyGaJLqdWDr
         +sNfCIzjm2zXogtf7CClcYd+MDH49cHY0ty7454Fp6EdOeLQNuZWp+AQCAHpZ2vIDW9q
         zBXXgWC5NHx4JwCF34/Cs1BvJjzRqszfNvXnFrlwDTX3Zrrjd9sppCL67n+zFlXAxLJB
         9B8g==
X-Gm-Message-State: APjAAAVvecWlZ8FxsqL0+a+hz6nJG8GFI4O0FeOYAbHdIl2dy4spdh1N
        jwb6Uogl/r8LyFjDT2sIf+9q8w==
X-Google-Smtp-Source: APXvYqzk/SlZFnVg1i5AlDDcb2Y/Ye+X1ZjtLvnMkVoWgF38mO8kaeTHl7o94EwdajPxHKthmfprrg==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr5872000wrw.10.1561481281384;
        Tue, 25 Jun 2019 09:48:01 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id d18sm42594476wrb.90.2019.06.25.09.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:48:00 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v3 14/14] arm64: defconfig: Enable HFPLL
Date:   Tue, 25 Jun 2019 18:47:33 +0200
Message-Id: <20190625164733.11091-15-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll is required on compatible Qualcomm SoCs to
support the CPU frequency scaling feature.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fbbc065415d4..7cc4ad24dfe5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -671,6 +671,7 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.21.0


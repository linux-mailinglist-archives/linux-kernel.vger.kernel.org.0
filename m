Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589BF14A803
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgA0QZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:25:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37747 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0QZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:25:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so5140770pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AETTwMBW1K6QIrQVON3rToRwyIKW9SZw4dAWXXfxxIQ=;
        b=SSPGMkhcg/9PUEynqidYuSP3yImPLsIF0VEkjnYfGxegxHZYeafBU/aC87Hn79uJC9
         EBVXL8aVbo+SfESMN5nfxwDx102EQIGK/SYxSIzGYcn3sBiIo8fGtdst1wuCOuOR0RXI
         jKkgzLl91xKXawlXJkk/ZclgLnsYths3wEGQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AETTwMBW1K6QIrQVON3rToRwyIKW9SZw4dAWXXfxxIQ=;
        b=DB1hekKkojgQwPA2Dox2VuXrjqE7E7AYMS1puKipHwwoImoeS2DBOH8Aifunt9Bf6m
         9C8mSJNb1uXItAktjDDDDPt19TJLCrAJfoLRjgrGvBkFkmwaNPJUTCg/sRVIcdhUW2L2
         KUda9Q746+XMc2st2dz3h6UXTQ3v995LY3LXb1yCbfxkqYRvraxu3zbx84xoPMdxC88y
         VIp4MgEBMUsXXec5rWeEfAhyKHd355eFhNd1lFrX35kh8VNGb19GxiT/tiKDjSR19Tcc
         uKpv/oTSm6jf32aTRoxVoUHbrOGIkeCvo/CNc8GAbWEnoNhnaSObkFekPnDCy7tdL7/E
         hxoQ==
X-Gm-Message-State: APjAAAVdW/gWZ8abdgcOmQSVwasCRxMEmfo6yeDpO9d0MKn2DR/YTQ0u
        vq4/MlSYp4YdgqDeLJ7SAbhzcQ==
X-Google-Smtp-Source: APXvYqxlebiuUFEHjfubvnlKDauUXcLhX/iKJ6unhIbyMgvVa8vTxmVSqa4anG4aFFAUBvpxV2N5AQ==
X-Received: by 2002:a63:3196:: with SMTP id x144mr19921682pgx.319.1580142341192;
        Mon, 27 Jan 2020 08:25:41 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r14sm16133264pfh.10.2020.01.27.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 08:25:40 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     mka@chromium.org, vbadigan@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: qcom: qcs404: Fix sdhci compat string
Date:   Mon, 27 Jan 2020 08:23:48 -0800
Message-Id: <20200127082331.1.I402470e4a162d69fde47ee2ea708b15bde9751f9@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the bindings, the SDHCI controller should have a SoC-specific
compatible string in addition to the generic version-based one.  Add
it.

Fixes: 7241ab944da3 ("arm64: dts: qcom: qcs404: Add sdcc1 node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 4ee1e3d5f123..1eea06435779 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -685,7 +685,7 @@ pcie_phy: phy@7786000 {
 		};
 
 		sdcc1: sdcc@7804000 {
-			compatible = "qcom,sdhci-msm-v5";
+			compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
 			reg-names = "hc_mem", "cmdq_mem";
 
-- 
2.25.0.341.g760bfbb309-goog


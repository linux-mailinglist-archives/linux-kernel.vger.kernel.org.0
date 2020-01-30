Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59FF14E49D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 22:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgA3VNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 16:13:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42022 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgA3VNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:13:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so1814955plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hdWC3RQmqbqeEYneGWU8AA2fWnLGYvTK7uGX6EESI4I=;
        b=dy/9ETdzg2IbK5MHT6jzlfGoU65H981Bgza6oumaV2dvTW7WTD77C+7h450M+iIWG1
         frkj33KT7yrQ36Ltw7P3SKdZOsWRKWFowFU/X5e7C9Lk3ymX/hw31CTNdHl3u+JD80Kk
         fq/0dG4QyBkNXq4+c3RN+kXkwoIZhHvdlRtSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hdWC3RQmqbqeEYneGWU8AA2fWnLGYvTK7uGX6EESI4I=;
        b=p8kdPaqkkUN4DMAHcbQvbcZF8X4xpAJcpWJ/7GpGBMJOGckf8o0kcZDUhpslzpaVoZ
         w/15k5Pug9nhtRcceyQnABwc5j2EOvVNTdk4ccJwZDe6gyJaLvtJGUGOWqhZraB82EjC
         +gcRwEseOgJaNOVRNrNmj/GUbNiX7egAf9FeF1HrHoZ5QDrTkzrY9W0H/2HcV2qjY5WV
         zKv5jPEUOM5X3iamz19vSbTySd1cHXfEwC+imLsqUUZJv8AGIDKcJXRxKTVt1n/fQ7kS
         rlXbfrxDA+2QvQ1P6VCj3c79PhKWYeczyHK9ADBkKTBLkICJoubyg0bfQb66tb2sRFxq
         Vh8g==
X-Gm-Message-State: APjAAAXCQOZmld1Cn88qNCIFz5B9YElW7TIYIupNOHQHynBlyqJTaQJ2
        bitFtSEHh2rnI0pdh3QEv18SPA==
X-Google-Smtp-Source: APXvYqzgj3qg6+ijNWRHM27hvrG2XLl3NbrODk5PrDiJH+sgQRp3aGWygTi6vlVx1xdxxUa8jCdRkA==
X-Received: by 2002:a17:90a:9c1:: with SMTP id 59mr8088935pjo.65.1580418778610;
        Thu, 30 Jan 2020 13:12:58 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id ci5sm4343871pjb.5.2020.01.30.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 13:12:58 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 08/15] arm64: dts: qcom: sdm845: Add missing clocks / fix names on the gpucc
Date:   Thu, 30 Jan 2020 13:12:24 -0800
Message-Id: <20200130131220.v3.8.If8596faf02408cef4bb9f52296b911eb9ba49287@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130211231.224656-1-dianders@chromium.org>
References: <20200130211231.224656-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're transitioning over to requiring the Qualcomm GPU Clock
Controller to specify all the input clocks.  Let's add them for
sdm845.

As part of this we've decided that the xo clock should be referred to
in the bindings as "bi_tcxo".  Change the dts.

NOTE: Until the Linux driver for sdm845's gpucc is updated, these
clocks will not actually be used in Linux.  It will continue to use
global clock names to match things up.  Of course, Linux didn't use
the old "xo" clock anyway.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Unlike in v2, use internal name instead of purist name.

Changes in v2:
- Patch ("arm64: dts: qcom: sdm845: Add...gpucc") new for v2.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0985813fee50..35d7fcbda43c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1903,8 +1903,12 @@ gpucc: clock-controller@5090000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			clocks = <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "xo";
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
 		};
 
 		stm@6002000 {
-- 
2.25.0.341.g760bfbb309-goog


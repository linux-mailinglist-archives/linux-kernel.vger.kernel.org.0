Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29D715502B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 02:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBGB7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 20:59:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgBGB7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so803955wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUSoU/XhVbuFFL332MrsGCHzak9+7MGgmls9JTYC/Cw=;
        b=NZFwMO0AjjXnAtKJTeYXg+7JyJWk6M3Xx1+E+Gxe0UvQsjreytd1e8ZFGPGCDToSBi
         ZEGUZYzMJjmOv/zKNHDfm4vmaQNpi0BRbSBzyyWMDKebkjoq05SloquYZdJzx/5VgmiH
         TriA78m8ALHBtBLygsIXZxivWR23EZKkVgSZsULpiJZgYbWH4DN5IzEbhe83N72wEGy0
         /KjFG5PI6Zrme9lG0GWYJHGi8QO8XPMLND8l+Ou1XFb4oGvkheb+Dbhf4R564fXbt9WC
         A05rVcygJMewovrMSkStlFnLSbO6qnlInXvaVZItkJTZiMPFbjedvBw7OUff9TT+JSOt
         HI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUSoU/XhVbuFFL332MrsGCHzak9+7MGgmls9JTYC/Cw=;
        b=K2zkEAf9eSKUGVwrZ3LUPDZowvWQHSxMpucC02YULDSqBnp+uNhaLh81ViPKKBl4rl
         Z8XpILBuSurzzQoNCTN/SuIUZCFp86DbO0EjFaJ0JDua2BDVyZvGvd3wJOY/Nx03cjk9
         Svb+kNSP/q1epNZzSXfp7PC7OPiWkG8KSTc55sTw+U24cFSspzhsWy+TMGGDwqwi+Pf1
         LenZsBT8tUVGq9JNQ3hixSjI9PpLqVhHMiei3eciZXc0Jk6oC+74x2pKYzZtKbUkRW/P
         rIZpIg2oiKWVJuZa7sA1gO0Rj4+ZIvcHp5+q/C1wNbA/dKNefhrIma5KRPbRay2tuTU2
         p6YA==
X-Gm-Message-State: APjAAAU9K747mPLmntJhiGzcsHGrcUnC5yNoIgHFAeNVtDBc0sujLJay
        xJhobLMe2kHmtKKzeC1VIZMHpQ==
X-Google-Smtp-Source: APXvYqx9k8vSTqZE5r0G0oq1QVrGBT7fuDHDt2/yymaqOWZbgbcWKJP7b1QvIEK34Axqs7U/wHb4Ow==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr1135081wrr.183.1581040768413;
        Thu, 06 Feb 2020 17:59:28 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a62sm1490095wmh.33.2020.02.06.17.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 17:59:27 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 17/18] arm64: dts: qcom: qcs404-evb: Enable secondary USB controller
Date:   Fri,  7 Feb 2020 01:59:06 +0000
Message-Id: <20200207015907.242991-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the second DWC3 controller which has one USB Hi-Speed
PHY attached to it.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 0fff50f755ef..07d6d793a922 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -318,6 +318,17 @@ pinconf {
 	};
 };
 
+&usb2 {
+	status = "okay";
+};
+
+&usb2_phy_sec {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
 &wifi {
 	status = "okay";
 	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
-- 
2.25.0


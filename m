Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2CA142FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgATQbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:31:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35842 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgATQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:31:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so117471wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUSoU/XhVbuFFL332MrsGCHzak9+7MGgmls9JTYC/Cw=;
        b=LhOTSKfyxGu3QzNqPFlliI+E+JTZs7hl2ag76/1M4qOSHfq42vXcYje+r3VACQUqrv
         OA14VXRHnGA6xSd8TH/hySb60jJHoKlVYDrGuHwkfE8yV07+BfZx9/+7WEdoeZksxg32
         IVZrSp6tkYItg31aYaLazuFk1KpjXqwYIlZkHWRGiNi36Oj7E+PBFpZBc/NMohFfxwcE
         CNmLEi2YVRpEA7IvbWqNdltO29jS+7z+Vp4MuYahgS37ZpKb7mBMfD7Lsi5lcut5J2Ne
         PFlESpL04Dst9VVWkPKKgm2IzDYm6aqm1wvH5jj9MFQAr+1MMjoTWdJZ+u6I/xxgEWR8
         EKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUSoU/XhVbuFFL332MrsGCHzak9+7MGgmls9JTYC/Cw=;
        b=LxxVXTurNpyNgOsqVrYFPnG7Tze58qBSRFKAyfKg9pklHTl2OL092I59TKozImIr+X
         rgLfriiSzbgo2dFJtgzrJozhL73ycxmsWXZ8ho0z4KNJx6j/X5oeW23mJZ5cWFw2o+Z1
         mRVIsODU8ZkqqEBlvSH8ION4nLHS46NwWNTY1ZMIN6pgz6k0/R0icSXJXYaOmcsCZ6J3
         npYwjF3FteSP7qSMpo2wW7Jx/BsHh55iPfDhnm+qCNfwD7S6my7VkB0Glr/xm2MWGqXW
         Q9DvgB+BcPEl9WyiC5j/Poym8ZyfmUFUxeCevOQATUyyJDZxPhJvy80LdyOuJ903CEh8
         UNhg==
X-Gm-Message-State: APjAAAW/APihJT3yoHWstNvZtJpyvdGvhkHtTrR577b2wBhh8Fh5/zOj
        1oJ8CnFQwRuE/7pv0V579E/PKw==
X-Google-Smtp-Source: APXvYqzh7+KwjH0AIYADBk8ipLPpoqsbpCKHss8cKke6kclzqR1hmQ5ry7k/jdlbdpit8NlVbn8tew==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr289882wrj.261.1579537868525;
        Mon, 20 Jan 2020 08:31:08 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:31:07 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 18/19] arm64: dts: qcom: qcs404-evb: Enable secondary USB controller
Date:   Mon, 20 Jan 2020 16:31:15 +0000
Message-Id: <20200120163116.1197682-19-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
References: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
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


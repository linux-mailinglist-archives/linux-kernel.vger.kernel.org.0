Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2913C53B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgAOONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:13:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33794 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgAOON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so15912760wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6kruRPkzy9lVUH/jwLgwsWhMI5CPdJk0wrirvWcE1I=;
        b=XmC1dJuO81CGqj/1DjpnBnet4KWs+DmVLk0IceBrNH8qWCQTOEr2Nkf57H5Q14EQhV
         i4bB9tyC/0+OD6WEYz+vOo/eusiY3zjJZVzHv0l0JaN0+dSZsOJI9Pi8/kTDRvYAdEWn
         EsKl9sD/GRwZ/UAPez95HVEsSR1ZW/n2X+cRs/la9bARu/lddlNj9NOUVXntWMn52jgx
         PM5XB0fKhlvqpTKJiGv3XNIR9fUGhfDxNWhRjRHaL5b3nkiTy9NY2uf3cx1joPRTl8V2
         mMKO3dEATrbvFMkVz360LJvZyG4/9mQAqbekxw/CKOBQjg31PvP3edJRClwF3RQB3piH
         KmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6kruRPkzy9lVUH/jwLgwsWhMI5CPdJk0wrirvWcE1I=;
        b=kNZEaxkobOPo9kaCyEXg36xS11E8OFTm+kxhgMS2bXVKYLeB4yXhq2bPdURpGMRjqi
         qxn2YoELnEqKSbn7IljVQVJJVRjPcvUCGsnNAKNuLcvzLAWP5B3fH4tERiglHqX+ZSzY
         XE/oReRmmI6RtIkegEwn/s1iWNVAiyPk8m1nWvmWOMZZQbkQ9tJE4XPZMFIL7NyORdFB
         vXh7g8MSQNKnI57166F115s0nRvLXPJJ29p/jOS51WqO3QUd71Pm22v5mrlItheDvTeH
         2aXx33RU4R/iq3BqFlWAm2iSnFTU9clzr+UYO93VAq/q2BdzNikLeC7IOdaNQug449zg
         J6/A==
X-Gm-Message-State: APjAAAWRMpYTcXlMhG/LBr3124BvLHeVUuuvZfLuLtsFuVhm3iLxWEpW
        dMa1vYUnpZjqGFDA1dxdeVSMGw==
X-Google-Smtp-Source: APXvYqwobBcHZcRU3dqh7kWlkczK59C7gnida7SLcEdxJmjxzH20IAc+sKhPA2AJrfd823TrJbaNBw==
X-Received: by 2002:adf:f484:: with SMTP id l4mr31382687wro.207.1579097605667;
        Wed, 15 Jan 2020 06:13:25 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:25 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 15/19] arm64: dts: qcom: qcs404-evb: Define USB ID pin
Date:   Wed, 15 Jan 2020 14:13:29 +0000
Message-Id: <20200115141333.1222676-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB ID pin is used to tell if a system is a Host or a Device. For our
purposes we will bind this pin into gpio-usb-conn later.

For now define the pin with its pinmux.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index b6147b5ab5cb..abfb2a9a37e9 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -270,6 +270,20 @@ rclk {
 			bias-pull-down;
 		};
 	};
+
+	usb3_id_pin: usb3-id-pin {
+		pinmux {
+			pins = "gpio116";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio116";
+			drive-strength = <2>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
 };
 
 &pms405_gpios {
-- 
2.24.0


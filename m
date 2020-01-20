Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7D142FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgATQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:31:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgATQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:31:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so100486wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jS7AtcyDtrs+6cLov2M3M67k09AnqIN5nOTMIVW4oM=;
        b=ZLzmT+7G1QN2Kl52lracr4oWkYEPK8VZDgUoaX+8kglatJZ6qSTJZTGfqjjZc8sMqH
         HSEFXPwiLDj/K3rPp1aNqHHMoWNati381iodNxhdYSONqgxEkFt2cPRwxJFqbwvX69vz
         41iUrrHUkJ1AVlw5TOONlRp+yy5YVnlSg43Xa+31g8UzsIB9aBYuOTDVio6l23wtRb0i
         6i7DGHKTgBz+HObpdXH36jpNhIPHQlXrC0bvTD6rxvJroz+rRlHKasPgPzLEMd+8ctJ3
         mGzWiAEneMOJ+G9Px7+1NmjiDR4x/NsAWde5SFLF8Y9OBTh/IwmWhQvIynLaIVcGQngC
         d6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jS7AtcyDtrs+6cLov2M3M67k09AnqIN5nOTMIVW4oM=;
        b=lCC1v+45Ej9dUfCezLhsue8Gc4HQiH8MKwfKp4j7jiMwAkAgXPKpT8twx74DS2hkVQ
         A1MxrwxucC5m9XCPfQlGw7gQBFj0drUSWqJ9yL0MEJLR7bn/gDK02dliTKQ7Jwlvkq9a
         9/8YoPnseAwYv1l41OA+vrSeMU1qnR1UccUEfMXT0EhpvB/WPA+JYJbBuiZGtfq+nlwY
         fxTHacyRvjjQozGCDU1kKP0X/oiVEx8gcpuvqNqY8YNc3w8SvW/3FXMQ3tR5iQvpH7pt
         uxEaMH2kuIXfVGRKQbjHDzBLL7O8nQKxjPjnSskV+xwxAMlZe+ZGTEvTdToPjI5WVRQt
         Sjsw==
X-Gm-Message-State: APjAAAUJeN/Spmqiaofkli17eb3n8QHs9LqgTpsO2R0HG3KI3w7CEE5g
        4Xf0YH+hc0DVJ3MCJ4cg7r6xMw==
X-Google-Smtp-Source: APXvYqwsxlu9k7l6Uw+nDOZ0lR9INBaTqDEMiEHikJEgxASKQmp85XSc4MCElCe4yAI8hCM4Y4FHWQ==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr283291wrw.289.1579537865228;
        Mon, 20 Jan 2020 08:31:05 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:31:04 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 15/19] arm64: dts: qcom: qcs404-evb: Define USB ID pin
Date:   Mon, 20 Jan 2020 16:31:12 +0000
Message-Id: <20200120163116.1197682-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
References: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
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
2.25.0


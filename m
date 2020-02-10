Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0E157402
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 13:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJMIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 07:08:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41852 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgBJMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so7356620wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jS7AtcyDtrs+6cLov2M3M67k09AnqIN5nOTMIVW4oM=;
        b=px+DpFJlrCF3XkAO7JeVfvOvn9wvoJh1AVMMbqRzO55pJqim3Zp1YpnLBTtCjSSOCT
         XhrNaz9fXXryRZ0wnlhMPodAzcRuRYE9oB0miRPR9EeUCRR61Ql+r16MVZ+WrhaPL7at
         3ROSBx+ciU3NrDkhNxLoaVNz7mhrH0FFk8vqq3+sppGKECSshe7ao4IgorzskSwzoccU
         bOr2gHwEK2aP/BWp/df5yG1WDkKyxV5ptuUEDGh5ZzgVr5gQ6YieN79gDggu3wajz7id
         CXxDkWJqKBGoQM+6UCaQ6j8xi2+nAs8X6eZk/TXoFsRB5yd04ndJxAzqikoWj5tiPaOy
         IBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jS7AtcyDtrs+6cLov2M3M67k09AnqIN5nOTMIVW4oM=;
        b=OFC+e0I0yPpXqXqKV7LH8doO6ewsxUleuJqAJXDQoq8x9LI1UDHdqPexKIWMAQ71p5
         IAeY1esoTH9cVkzvSyEz/+NsEE5i6kJV2i5kReruDSLvb3dg9Wz7+G6rNa1R4yEO5XpI
         Jn8NFVJGYEksXfyUdHS1U1im0qX2/zTR0DYWKsBiU79IbNTKSJEnkYAlnLttuUtR+mcz
         fIdDS5BcoAGkZvJrujI6vHyUBXjfzIQ+eaEelkei6tllLcCTBlE1yjfOkn3tkNFqtPi4
         LeapmnrTucNWwwNwZin88IKHVyi1ElYvQJQ5C192FzyWcMPP3jC8zsxqYv+Is6n2yVjb
         K/gw==
X-Gm-Message-State: APjAAAXgOEYbVXh9KER77FSMuDztPn6DETfASTV/h9E88lztEV65+3lO
        ef9pU35rhdagWIMD6NAvaH1Isw==
X-Google-Smtp-Source: APXvYqz7hWldIQRJ5dcfzSP/g8ugSVgOzTalYGWKdCoryuvtGnH0/IDxQxOV8MnjiX4pI8Idy7KPew==
X-Received: by 2002:a05:6000:108e:: with SMTP id y14mr1715498wrw.338.1581336459167;
        Mon, 10 Feb 2020 04:07:39 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i204sm293124wma.44.2020.02.10.04.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:07:38 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v6 15/18] arm64: dts: qcom: qcs404-evb: Define USB ID pin
Date:   Mon, 10 Feb 2020 12:07:20 +0000
Message-Id: <20200210120723.91794-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
References: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
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


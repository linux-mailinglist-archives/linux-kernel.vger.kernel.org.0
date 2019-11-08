Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FE9F3D1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 01:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfKHA5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 19:57:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKHA5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:57:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so3540546pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 16:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GYRc8Evk3wu8EUiuELp77RSTyUut+SJabJSgyybQCKc=;
        b=IG/WqwKZ2wj070Ivn9cX57KoAHKqmal5mE3JH+W8mKSon9hw52loHkmdZbFDPSY2jQ
         ys//zHpsG8iMG1uowgXBTGA6cMxirTsWQbwgo8PxEn2jzNTyxFLfM36y1EIle/CQRs+7
         /KWVfR0o3Ux8s96ccSNEaM0VutEx10G0bdWYpi0I2p2daN3OI9L5FR5gX9kM5PI7ITtd
         STXZXrQttfyRbiihP4ut0CDumS0MZn7lzPNLc0wTwX7PXm1yHkRzjqUttYkybqHkKawH
         DR67xXkD9kukt9EXFs2jfpIxVTAYZkY7vkYf7EtJpSPf6OSJv+R5de6XfRc6woF0fc0J
         244Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GYRc8Evk3wu8EUiuELp77RSTyUut+SJabJSgyybQCKc=;
        b=FdtUzAGb0w4++2HX4gwxBlgkcqe2KgmpAmQk2NFD6KCLFKPp28OvvPUVPCaSC2BKGT
         ZAw+RZ13wKUFyvi4guC8pWbjsgfDAWmJrePx+U8Rn1K3hMJVNQ5RNomwkOIYoQ45jvF6
         qo2i5FOJLH8SWzLCB+9nrFWRexWl8zr5C3Wg0mf9Zy/gtSSMQEs7htZQrgHdorQjRCuy
         oWJsrQzaITJDtIymLpDi1vJRvO5YoMH+ixb1YzTGTtQXpOtMbBANxW4O7FLctvDHgdmN
         p2UR1I9C4DVDAgcWySF5pDXW13M43MlI/7vETFLE34kRvn8TSYOzttr8rMB6HAeQoXvq
         oXqA==
X-Gm-Message-State: APjAAAXXRYTo7fjVJFXdrUll1yDRkYovoiXeuV2efaudUTk4JyW6wsRO
        6VAV0cUnXvyFUnZ5RmUXbmHdUbXqAAQ=
X-Google-Smtp-Source: APXvYqxPGuXcyQs3WEAMRMpy19Q/rGB2EPMqpq/E5qQg+lPEgnZi1NCqdVAh1vI3toPeT3a4iri5yA==
X-Received: by 2002:a63:ae02:: with SMTP id q2mr8519964pgf.210.1573174622801;
        Thu, 07 Nov 2019 16:57:02 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j14sm3527477pje.17.2019.11.07.16.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:57:02 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RESEND][PATCH] dt-bindings: usb: rt1711h: Add connector bindings
Date:   Fri,  8 Nov 2019 00:56:57 +0000
Message-Id: <20191108005657.31464-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add connector binding documentation for Richtek RT1711H Type-C
chip driver

It was noted by Rob Herring that the rt1711h binding docs
doesn't include the connector binding.

Thus this patch adds such documentation following the details
in Documentation/devicetree/bindings/usb/typec-tcpci.txt

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../bindings/usb/richtek,rt1711h.txt          | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
index d4cf53c071d9..e3fc57e605ed 100644
--- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
@@ -6,10 +6,39 @@ Required properties:
  - interrupts : <a b> where a is the interrupt number and b represents an
    encoding of the sense and level information for the interrupt.
 
+Required sub-node:
+- connector: The "usb-c-connector" attached to the tcpci chip, the bindings
+  of connector node are specified in
+  Documentation/devicetree/bindings/connector/usb-connector.txt
+
 Example :
 rt1711h@4e {
 	compatible = "richtek,rt1711h";
 	reg = <0x4e>;
 	interrupt-parent = <&gpio26>;
 	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		data-role = "dual";
+		power-role = "dual";
+		try-power-role = "sink";
+		source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+		sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(5000, 12000, 2000)>;
+		op-sink-microwatt = <10000000>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <1>;
+				usb_con_ss: endpoint {
+					remote-endpoint = <&usb3_data_ss>;
+				};
+			};
+		};
+	};
 };
-- 
2.17.1


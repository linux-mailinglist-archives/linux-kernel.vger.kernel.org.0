Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA099FCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfH1IV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 04:21:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfH1IVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:21:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so1231513pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kznkhzmN9JbxPn8XUCQRZKmUtSzS9jvDsbj/mMs4NBw=;
        b=V/w56ls6Ay3QOsjzTzGMPhv5Vyszl4x1jFxXn9EJH/k56sAYTvaFi10tNPzVtMJSbH
         /gRA3fNGWlxLv54fYDaWsHXL1FNteIaSVyG7vptX6wPRDbK3MP567XC2Mt6eaSZ83eZ7
         baYS0udHyP0c38OrnkQzU1Vn1pP/iczxU/Q+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kznkhzmN9JbxPn8XUCQRZKmUtSzS9jvDsbj/mMs4NBw=;
        b=U2w4xbH4hQrTvJcK1k31ZEly4G58Uzs5L5xAR+riFAzmDt9jDopMnf3sfTqadgzvAh
         VdogXhY0Cx2i7j/6L84E81KTTMBlG0D4BzD/Fpm/nM3bufuHi9zfjaLw41l+eebvcMpB
         4hr6CAjSnwsDnw1Hi/82b9Zla4nEB9EjejIgyT83s2mAS13STfjobSvx6oyvVv5jlqel
         Hl4tpMku8xVmsODFIUomX6IXxMW3JmuNrWp+R2z2zHVKkPolRE0kuIJSk3qtUNFN4zJv
         vyz7a20gIKPnYZCVSE0lITeWTHNfjAU3PANIrAOYOZb1nyEKREOJL6sMUWlBij5q7Yxz
         KiIw==
X-Gm-Message-State: APjAAAWDNFfiC31DySZ2RqXjny/rOBVRIs0PkNIeg2JxDkpCX78irrHG
        kOyFbhxnhGYy8gtpHqUTkm1IJg==
X-Google-Smtp-Source: APXvYqxWNOyFreSUkBxhGLUQ4zpSt5YnnHrl0WCgaMOGDT4bhiCpMhx0tCx5KBolsLoPKxdcz8/NNg==
X-Received: by 2002:a63:2043:: with SMTP id r3mr2397965pgm.311.1566980512951;
        Wed, 28 Aug 2019 01:21:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y10sm1296959pjp.27.2019.08.28.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:21:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: tpm: document properties for cr50
Date:   Wed, 28 Aug 2019 01:21:47 -0700
Message-Id: <20190828082150.42194-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828082150.42194-1-swboyd@chromium.org>
References: <20190828082150.42194-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
firmware.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
new file mode 100644
index 000000000000..cd69c2efdd37
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
@@ -0,0 +1,19 @@
+* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
+
+H1 Secure Microcontroller running Cr50 firmware provides several
+functions, including TPM-like functionality. It communicates over
+SPI using the FIFO protocol described in the PTP Spec, section 6.
+
+Required properties:
+- compatible: Should be "google,cr50".
+- spi-max-frequency: Maximum SPI frequency.
+
+Example:
+
+&spi0 {
+	tpm@0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		spi-max-frequency = <800000>;
+	};
+};
-- 
Sent by a computer through tubes


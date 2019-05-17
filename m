Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2927E212BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfEQEGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 00:06:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfEQEGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:06:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so2965017pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 21:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6yVenyf0a0qIZedfKSCtttpa0WMwEDTZq8Yud/8Uytg=;
        b=kCiLjC1owHy+UsjeF60cBtcatNacrggyR9r2TuoTOmaWEe3JT5GGpL6NQCaDV36Umb
         y/uBj3UO2rVyb7LmO0nPT1LDJ13jKkSjsa+1zBQ8ueyJ9FmLUfe5S/lk0Om0Rfr0OqhB
         udBzRgih+ZPFfi/pgEjD43225Heo+dB1r0fyB8XDYOUslZvLWhrEHS68MQPN4itx5QCF
         5G2Si0cxb+SIySRKcJ89o6NK+bzeiKjUPq+YcDJWlujIPilrDaYpFLTrbyPSXFh2hj+S
         mx9VVpsW1bVQZmZ2Ze6IzHvT3dT9kfO2aRLIUQ1PQFdbLc/kn+Ctg79zCJGwc4LhM4IF
         pBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6yVenyf0a0qIZedfKSCtttpa0WMwEDTZq8Yud/8Uytg=;
        b=OOfc6iuRyKtHsc/S4MQuJhPMW+EIAVzDgCR/NLRibmswDONG/rlTcSXjyxYAfQFMF/
         WtTlYYWuz5EDgSg1/54kDakGkMh1LHSEKrFCBAO6rNqekLJ+vjJEgQ7y99I1zmRDHTte
         va2+2NxcBOfSEdD1QzXffS701QmF6qGgiu/3D7eWTGEDMJ8hatm1A+AnugM9usBJhevO
         WPtSJu2dzZdTINMcdLcnPOsN4BxhJqR6d+Td79RkKVbotjU+DSdSmE2vmYgFmbHMKw5k
         HOtEaSenT/kypIDkA+/GbG174aX+lPccNL1XQZQNwrWYxYm94gT4lEU7iJSGOKodKoNV
         eY+Q==
X-Gm-Message-State: APjAAAXusqwvTRwjl4jCS/IT/zQXD1gRzXPoUgC4TyIGNw/JPQVwEkgt
        yoEmVcBCd6dokAF2OK1K4wWn
X-Google-Smtp-Source: APXvYqyVaMd+FX1grTr8/UOs0JxoMs+1pdWe8hTBQCYVIxmgR63mOxmsGCZ0sfjQ08bGQHR+ZiNFjw==
X-Received: by 2002:a62:e718:: with SMTP id s24mr58695777pfh.247.1558066004331;
        Thu, 16 May 2019 21:06:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6390:5018:b478:7b0e:49e:16a3])
        by smtp.gmail.com with ESMTPSA id d3sm8628927pfn.113.2019.05.16.21.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 21:06:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Enable SPI1 on Ficus
Date:   Fri, 17 May 2019 09:36:25 +0530
Message-Id: <20190517040625.14607-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517040625.14607-1-manivannan.sadhasivam@linaro.org>
References: <20190517040625.14607-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SPI1 exposed on both Low and High speed expansion connectors
of Ficus. SPI1 has 3 different chip selects wired as below:

CS0 - Serial Flash (unpopulated)
CS1 - Low Speed expansion
CS2 - High Speed expansion

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Used pin constants instead of hardcoding cs-gpios

 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 027d428917b8..9af02d859dcd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -146,6 +146,12 @@
 	};
 };
 
+&spi1 {
+	/* On both Low speed and High speed expansion */
+	cs-gpios = <0>, <&gpio4 RK_PA6 0>, <&gpio4 RK_PA7 0>;
+	status = "okay";
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "host";
 };
-- 
2.17.1


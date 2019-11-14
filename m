Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843C6FBC79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 00:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKMXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 18:22:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35061 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKMXWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:22:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so1744731plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 15:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnC2EnZ/9yWW959Hh/k8Fx1oMGg10XdljJMPZj6JnUY=;
        b=Hf1Z5gez82r+oTd6ydC+ZjLQx1uQl/epkoQZOi2UWsUxtnC7vz6UbgVzXACvVguET8
         B1r439ENlYw3ydKrZCF7LY3jQwp5xwpYB71unyWWJ4w630L+BZ/3X7WheMhfVi572N/4
         yw7GZbzAXep8sNhNt2fNGHAOeRJ7vEDZ8dAXt4j4xlCbUDTJH52frakbBd+RZ4E67JmH
         jv8zcL+wUIQP9wDH/Q323MQnDsjklM8emprm1gBjYMADfrolCEr7JYdlJPz1M8eK6mQJ
         YEbodCDy9QsAUuo8eRXoU4oDr+I6FZgvOyW4RiKVW97hdxqx5ipxHC2B6U7SdpaR76XR
         3sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnC2EnZ/9yWW959Hh/k8Fx1oMGg10XdljJMPZj6JnUY=;
        b=gFlPCoobT1ZOhu+y5y9bbwKK6g66DR1fWnGigCbwlE0ITM3CZL7GMCIbSt5LlAaY5x
         Nd19BNEf4Jlo9rSP5+qRBlLjTTTtrweWWAOCN9OTJ5Sd+j3bDeEKiqTERqxrFsJUdkvO
         s10AcOZm5a5szhLBmC5LFAVE66he6ReMIWlFZo5oqdu50RT5DWyuoExY5vpzCPuEhitF
         oPuavThsbzIPm5GRuxEky3tkukTDB+uJl0U7+ao6S0/3KAs/yRbsRMC90Qg6kdi1IXIE
         hGbPEN+5l/NR/9LWTwDoFavGjRyoJlHvsTfiiYX7DiPVDbFIa3wWpr6F2b844wM6rUA+
         prdg==
X-Gm-Message-State: APjAAAX8RElN+ReLthq0jGPCNKXRQd/f8KqcERvVPDiTfM2fftUt9uu0
        /u8Kk5RRVMaAkiMEzRjbLoepJg==
X-Google-Smtp-Source: APXvYqwkCHtk+kWBYG2xS1z0RatDyIgpKCCiE9mnyxr59SsymXOXeGmdTvY41JCjZ3co01GD2gLLCw==
X-Received: by 2002:a17:902:d901:: with SMTP id c1mr6362694plz.93.1573687369645;
        Wed, 13 Nov 2019 15:22:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 12sm4427369pfv.92.2019.11.13.15.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 15:22:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: db845c: Enable ath10k 8bit host-cap quirk
Date:   Wed, 13 Nov 2019 15:22:45 -0800
Message-Id: <20191113232245.4039932-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi firmware used on db845c implements the 8bit host-capability
message, so enable the quirk for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 12f5f14ada5c..7ec7b90ab83e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -625,6 +625,8 @@
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	qcom,snoc-host-cap-8bit-quirk;
 };
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
-- 
2.23.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B739733FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfFDHUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:20:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44310 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfFDHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:20:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so7972729pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbYhG2IuSKiELmsG7X1sFgDmhYmR01xHFlPBc4Rg+WY=;
        b=TyAq2VbaGgul2cYABt4qMWYSUDODaZK9Ip6g+GuxTxEUbFvrxrfTSxlVN2hCfD9QUy
         IWd3h8THlWspb++nEXiB0oyQxxe5PO9+wWHxyxS9OgJHt5CuWKfZhoeRQ++YZT4SW7VX
         zt8ilbOjYdjyCjr/kSwtRGErLi0MGl5NVQ6yvEX/HoZSzQ6Fl9gsfK9PC+bf7ifWE7v1
         0JUfDgzYcJUo5DOUSvbOtJbBRT4lvNvVcC/1ACUZRT+vp9qFHeuxgshuz1HYfI/jyt6k
         vGb2sHjLQaobG18OSqhaOrNqobFkfkMXnz2E2HaDwEzr3k+ddOj5ZRgn0kepYzTDeWm6
         fbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lbYhG2IuSKiELmsG7X1sFgDmhYmR01xHFlPBc4Rg+WY=;
        b=r3jtKLJYQs/XuLNX4vrDfyXKk6EMYFPeAKyxK4QruY3vvD5qqv/s+qxaNH+8KFHS4t
         FNnKiAw0po1cmeqU19DKmQuqOAdiO/6SusCh6ZWobTiO9vTkSKGShvj5bxAII/say7RW
         Xk9gX0zcdya4L8Ovt3ttJ73m+11Xy8Y0FQsCl+qdY28DB7s4qPGsFLvzk85Iq4UZZ6R8
         /rPlWIC3IeT3x+N3yeOKTSoRwKRAUunNVIXYto0ZdPRSTj6yrhZnb4xCcOZAXpB+hkbb
         5C4QlkLCTR/PTDhhVpryRg1yoi9bHh/oNn4fpDLW2hs82jncHpIUOE0fYr7I1oj5iXkg
         mnfA==
X-Gm-Message-State: APjAAAWdCZyILA5ftsUhUS+g1R9eEJSQI/tqU+wO11XJcwjAjIivlyRB
        uWC3Z8jPyBgtnP+EZ0pFzGppJQ==
X-Google-Smtp-Source: APXvYqwuduypUPwxFGsMyc5LSMguOHIO06/P46IPWcXnuuwx7EkUWP0+5LJTNqgrRVQQxdMrnHrFHw==
X-Received: by 2002:a17:902:a582:: with SMTP id az2mr34517864plb.110.1559632807726;
        Tue, 04 Jun 2019 00:20:07 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d6sm17747446pgv.4.2019.06.04.00.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 00:20:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO
Date:   Tue,  4 Jun 2019 00:20:01 -0700
Message-Id: <20190604072001.9288-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190604072001.9288-1-bjorn.andersson@linaro.org>
References: <20190604072001.9288-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the UFS device-reset gpio, so that the controller will issue a
reset of the UFS device.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 2e78638eb73b..d116a0956a9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -388,6 +388,8 @@
 &ufs_mem_hc {
 	status = "okay";
 
+	device-reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
 	vcc-supply = <&vreg_l20a_2p95>;
 	vcc-max-microamp = <600000>;
 };
-- 
2.18.0


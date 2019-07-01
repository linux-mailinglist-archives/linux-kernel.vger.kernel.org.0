Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64319798
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 06:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfEJEed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 00:34:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40856 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfEJEea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:34:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so2350790pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 21:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrYyI34a2DrOth+hiWVN5F0vACg7lAzQS8qPwj8GUmo=;
        b=ZRVaUHLNPW6p1FLWaGVN/da/ZjxPgu+rw7RcTq3l/7O/33OhV8thgylQga3AuS+a6f
         3z/PHJoE/5j4bkpbyXoGaGFwvgdNlIrSVfCXGQGwQDVS2O70mOh0MNv8uHTsVWYpLZLz
         TToRHI2AMmNh60wkrZi3rwL+vv8gh7KHoa/ElmWJbRdlxKoJIa7+6jk1+xigXYHuOKV2
         BFEEz7XWHPhYdBqWqrS+c/pzM+0Wxkz1YYClOSkCB4oluGcmjVx+sQyEPWiVdkZmpyth
         qWZAhYR00AGSYrpjriIyJpL56prX03ls+3oV56ZVrT5YtqyeT52ZHpMXZbcA6SyGR8JJ
         NOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrYyI34a2DrOth+hiWVN5F0vACg7lAzQS8qPwj8GUmo=;
        b=kBATGrwAfEuqThbYxjBxuFMEa88tSZu/ITuhuiB6u/99wVe3VBDtrkCErbYk0pnL0M
         RLZnk82fqCvJA/EAkfHrLubpoqcMuGCPFTtd1ZPtvW+nKWjVyKYwQeFhdhK5Wop8zNgt
         3vgCYZDuZ0QP9n69yZJX9a8saYJSLdwUA+KUU6RoJiedfDJK2zXSDW2yAgHGUBM1t2IM
         cJkzGQBMfKE4t0epS3fYtk2EAFJjk0FmnotlBR0vgSylQZB60r+tqSpDoKSQlZ4T7COs
         jn6DelWTLzmAh5jhOamUD4tnlc3u0+5WNOIUCb6aEy9e+78L5t2y43Ir1Z6q06QfAql+
         s40g==
X-Gm-Message-State: APjAAAVmkG1+oJHIvnipc3+lgHCliQJrX/H0MskfmDB2tSw5bXdbGr+A
        JVYdCiGao8Ny2P+f2HUytN4vkQ==
X-Google-Smtp-Source: APXvYqyjjoPe7gUUS/QT2WUtTGcp1ndcYSKOtt1syIFKigoedIyXn+ou54hhkdpEMGwDHX+LNMbfPA==
X-Received: by 2002:a63:e417:: with SMTP id a23mr10743392pgi.224.1557462869465;
        Thu, 09 May 2019 21:34:29 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s17sm4785317pfm.149.2019.05.09.21.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 21:34:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] arm64: dts: qcom: qcs404: Add TCSR node
Date:   Thu,  9 May 2019 21:34:17 -0700
Message-Id: <20190510043421.31393-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190510043421.31393-1-bjorn.andersson@linaro.org>
References: <20190510043421.31393-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus halt registers in TCSR are referenced as a syscon device, add
these so that we can reference them from the remoteproc nodes.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index f422d6e9cb3a..3eb6089c8024 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -415,6 +415,11 @@
 			reg = <0x01905000 0x20000>;
 		};
 
+		tcsr: syscon@1937000 {
+			compatible = "syscon";
+			reg = <0x01937000 0x25000>;
+		};
+
 		spmi_bus: spmi@200f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0200f000 0x001000>,
-- 
2.18.0


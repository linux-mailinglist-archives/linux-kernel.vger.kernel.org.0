Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BF33B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 00:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfFCWX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 18:23:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33073 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfFCWX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:23:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so1608024pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KV1yP4xPKIyp1RKqHB+nD6QgQGfk1bw32PIxxNzkN7U=;
        b=L7aCm9arW0EF/yMO3AoxQuQPqIWFqHn2McPj1Pnb6jxxV/O6Z+hFMVddo7AdkGjYdI
         lfIf2RBJi2sqof8W3HPbnDqO3drzS9kN0Xge9AxFf4QV8PzZwxVu5rzY31FVbp7Gwae9
         SrzeyAOdcv1FP2JGidBa2fUl+2fKzKS2uMdkAFd5OBfsLvewktfT69k0OPQxJEZ6XEpA
         H3AU6JfQM0sx1XFk+ujk4bKOHXnkD8KsYffAgz46z17K6zIgyySAvNFWMX7S0+ea2zmC
         D2s1znTbmO9wraSLLyBAZnxrTIyM0OSurxT1G9O9GWYImS8XFrSrd8174uxxP8d8zTAP
         30fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KV1yP4xPKIyp1RKqHB+nD6QgQGfk1bw32PIxxNzkN7U=;
        b=N7OysOkAiPr9admmlrkYHC6vpiFLi8azEJDjeM9CgWYOIYUNBCf+ZS5Z/L9wm0kV7P
         A4/ri1/6xjSvjolR6ZlAYT5feHOZFJ3s13y4ugnjHStU4aP+j6VhWQtn+yvf4bcqKuUu
         SPm55GPlDyGsB9bwf2p1gVw4zMC/RaH61lqtkwm5RmnM1ORh8/YkhryRrjMEISrisigf
         UxJBz/5UGKwk6bnpvKtnimBET6Ar2PgWfv54nqzCWf2N7s8In5fnb1OPSgDVNbVybiCm
         7DV8qW8RthAdbRLb2MY8eOeWJpKJgPp/uXnZJ7qekDIZQC2j0DZV865SOEHECU7dCEfd
         Nzpg==
X-Gm-Message-State: APjAAAX28J9u8ySPIBgZuy3DGW+0SHei51JcZace3yk54O5upLm+zBNu
        JFjhMpBP5Jxo3M9Frez97XjZYmHVyvM=
X-Google-Smtp-Source: APXvYqxeAhg/5hJQWcCD51pc6wcjvauGAvorr2NlhrqLCJn4zUoNyePOZR4JRwhRVRZWzvatY8yVxg==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr11712996pfc.103.1559600605383;
        Mon, 03 Jun 2019 15:23:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id g8sm14320588pjp.17.2019.06.03.15.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:23:24 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/3 v2] arm64: dts: qcom: pm8998: Use qcom,pm8998-pon binding for second gen pon
Date:   Mon,  3 Jun 2019 22:23:19 +0000
Message-Id: <20190603222319.62842-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603222319.62842-1-john.stultz@linaro.org>
References: <20190603222319.62842-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes pm8998 to use the new qcom,pm8998-pon compatible
string for the pon in order to support the gen2 pon
functionality properly.

Cc: Andy Gross <agross@kernel.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index d3ca35a940fb6..051a52df80f9e 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -39,7 +39,7 @@
 		#size-cells = <0>;
 
 		pm8998_pon: pon@800 {
-			compatible = "qcom,pm8916-pon";
+			compatible = "qcom,pm8998-pon";
 
 			reg = <0x800>;
 			mode-bootloader = <0x2>;
-- 
2.17.1


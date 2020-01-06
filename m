Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAF130E88
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 09:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAFITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 03:19:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45912 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAFITF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:19:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so21570329pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 00:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3c7L4+P+KiTl5tu9QNPNeI3xGfEuVyvirkdna1ncDeQ=;
        b=MiJJa9aTGcE29pvnKrA5AJUejDy8AiXq+jhSvAX86tRL9+rlYI6xDPakCVsHzLt5nY
         6HL32CAaaWhSt/i0RY4ASz6uwFpgzjYf8N7coi9x9FS39qjrAbN1oorGLhFVwRzJXXrn
         1q1reb5I+niM+ht3RU0ONQQEx/aT+OP4edDSxYkvJQsdVyQw3iSEyp+lKMNHX5V9lAvM
         tiegUNVTA3qL+5/ZtOH2C6WjLbFlnN9ewOpsHDPHWORxdDrdPqPF9C6DdiC8VgUNwJhk
         bx1ppSIbZVW3K0nfMq+1pO2CdDeqjRd03bOPgrTarxHrllQkM7ej4H1fsIHr3GHMawo8
         zTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3c7L4+P+KiTl5tu9QNPNeI3xGfEuVyvirkdna1ncDeQ=;
        b=caTX+gdkeebLGQX8gsPkegrIqnz2hVzXXleR2y79H4Md6/smYX7acb0C8en2d1BCf4
         u33xSZuyaMukQrMvWjEuy6Fm8pMWDk71EYjpvFUAMpoKZxx+Kc5G0F/bG3rgRzGfkuGs
         +cRQynJQhdsbgzLkehCWSYZFs2DQy7LZw0rDKwPRThw7JVBrf1lkCOiPs/BpMJ2BXU2f
         5MgMCp4s51BEkG3GRXltoc4S4PqroAiovKbzqw8Aql5XV5W3E1/KeAt1EQKBIcFcqxHR
         n/Dx4H7nfjbw8Qq7stCdWASmgrF82/CGX+BGnycjooI8uxnajwCednri9FXwxLMstUyq
         p3/g==
X-Gm-Message-State: APjAAAWOXze3SEYaAzSuQFjQAEGKhjcU3n2jNxws1DAzqWkcD0O1ly+k
        A+Nb1yV/hujx2DBqF8/gStSpuA==
X-Google-Smtp-Source: APXvYqzWvuInNvjhrJK52TKqJKaDaLfOyfYA+v5qPrum+lAHZzj6mn/QgSbzlmQ5/RIyNYwm5Jj08g==
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr42182747pjr.17.1578298744955;
        Mon, 06 Jan 2020 00:19:04 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h7sm82343457pfq.36.2020.01.06.00.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 00:19:04 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: phy-qcom-qmp: Add SDM845 PCIe to binding
Date:   Mon,  6 Jan 2020 00:18:19 -0800
Message-Id: <20200106081821.3192922-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106081821.3192922-1-bjorn.andersson@linaro.org>
References: <20200106081821.3192922-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible and define necessary clocks and resets for the SDM845
GEN2 QMP PCIe phy and GEN3 QHP PCIe phy.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Rebased patch

 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index eac9ad3cbbc8..a214ce6d0db2 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -12,6 +12,8 @@ Required properties:
 	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
 	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
 	       "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
+	       "qcom,sdm845-qhp-pcie-phy" for QHP PCIe phy on sdm845,
+	       "qcom,sdm845-qmp-pcie-phy" for QMP PCIe phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
 	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
 	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845,
@@ -52,6 +54,10 @@ Required properties:
 			"ref", "ref_aux".
 		For "qcom,msm8998-qmp-pcie-phy" must contain:
 			"aux", "cfg_ahb", "ref".
+		For "qcom,sdm845-qhp-pcie-phy" must contain:
+			"aux", "cfg_ahb", "ref", "refgen".
+		For "qcom,sdm845-qmp-pcie-phy" must contain:
+			"aux", "cfg_ahb", "ref", "refgen".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"aux", "cfg_ahb", "ref", "com_aux".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
@@ -80,6 +86,10 @@ Required properties:
 			"ufsphy".
 		For "qcom,msm8998-qmp-pcie-phy" must contain:
 			"phy", "common".
+		For "qcom,sdm845-qhp-pcie-phy" must contain:
+			"phy".
+		For "qcom,sdm845-qmp-pcie-phy" must contain:
+			"phy".
 		For "qcom,sdm845-qmp-usb3-phy" must contain:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
-- 
2.24.0


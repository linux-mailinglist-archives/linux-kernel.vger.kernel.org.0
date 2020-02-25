Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7816BAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 08:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgBYHbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 02:31:43 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36386 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgBYHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:31:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so899340pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MeNT2LBtvvWRJ8skAFje3DzrXRMuYy+VgIgQTPNC+Q=;
        b=rHquTiE8TUja3dt4Mjut7qSrPx8UbwPjZAQBsFOjEe81TYZcG1QzVdDP5cPVCiNSRr
         UtdvehGce5clYBhp3qyoLcr/SjcGnOr9Y1mN3MlCj+dcXvHGpQAJmtyqsoPWxResXyLd
         g0zlZeB16O/TTvlRcfD/4aQb1MwwVBF8pMBeQIc7rBmQUUKJyR6tKt5joehB6IJKWjwh
         x1GFw/mfJuZelPLVtq5tRMkF8kf0zqkyvJsUBPS7mx1QA/BP7fB58BYjX0enTUZFVZ23
         IZY+7r+MOOVqzY6kL9hD6kmviGRGQZxjcZvijNMMcI8fWJVY2feHH5Uv7C3FANoNTlVa
         E5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MeNT2LBtvvWRJ8skAFje3DzrXRMuYy+VgIgQTPNC+Q=;
        b=aMJV9VXOWiUmWe3vaPUVUzC9D8Ys6f8cwsIbBXUzN8Nd1oQR9XTHUaCzwEWAkwdPIZ
         tzx92q+mP2kjFsOTN/2sZrMkTz4U8GKnmcyc4RuK82ekpoEC5/2eVULemcqMUrH12lEP
         3+p1b57Ho2IPDbm7jmSJ8BG0DvpxmCzzUjSaQsqURSapRT+eIEji2FyNAaPEo4oJfjfe
         qL0DMHcS8X4KoPdSd3ZmPQmUsfPMLzTE4UCbCxU5dB9wc5CFLZgWpulQw6rqsNFr5gu+
         ajcfbC75VVN5znH/VQu9wPVa3649kQXM79jFUEvn5/CNsGquX8Nekt1ZXvIHMPV3OXQC
         oa3Q==
X-Gm-Message-State: APjAAAU4haOhKKm/UkGoHc+CzpTGIJG8QEWwn23S7DS6FczCPbJcQbWv
        K1BQidnZ0I8egZpLoyQg2zBqxFHX14o=
X-Google-Smtp-Source: APXvYqzJsp59Rs0HcueeuzygtiN8ttUYqfXk8tRf9Kt50g+PItQ8Lj0vSK/QmgfO/K2DCrAwmNc1Sg==
X-Received: by 2002:a17:90b:3c9:: with SMTP id go9mr3647591pjb.7.1582615899920;
        Mon, 24 Feb 2020 23:31:39 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id a17sm9056906pgv.11.2020.02.24.23.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:31:39 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 3/3] dt-bindings: thermal: tsens: Make dtbs_check pass for msm8996 tsens
Date:   Tue, 25 Feb 2020 13:01:22 +0530
Message-Id: <7b7291509e02c3100cb765cc846c6df4b5540037.1582615616.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582615616.git.amit.kucheria@linaro.org>
References: <cover.1582615616.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible: ['qcom,msm8996-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4a9000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']

/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is not valid
under any of the given schemas (Possible causes of the failure):
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible: ['qcom,msm8996-tsens'] is too short
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
/home/amit/work/builds/build-aarch64/arch/arm64/boot/dts/qcom/msm8996-mtp.dt.yaml:
thermal-sensor@4ad000: compatible:0: 'qcom,msm8996-tsens' is not one of
['qcom,msm8976-tsens', 'qcom,qcs404-tsens']

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 7ae082ea14ea..f157cd4f53b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -446,7 +446,7 @@
 		};
 
 		tsens0: thermal-sensor@4a9000 {
-			compatible = "qcom,msm8996-tsens";
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
 			reg = <0x004a9000 0x1000>, /* TM */
 			      <0x004a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
@@ -457,7 +457,7 @@
 		};
 
 		tsens1: thermal-sensor@4ad000 {
-			compatible = "qcom,msm8996-tsens";
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
 			reg = <0x004ad000 0x1000>, /* TM */
 			      <0x004ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-- 
2.20.1


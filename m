Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCCF180C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 00:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCJXQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 19:16:52 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38948 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:16:51 -0400
Received: by mail-pj1-f67.google.com with SMTP id d8so1097825pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXg9Gj7QTUwpYvOhGlvMrbNF6i7eg/pUYIjVoM9j78w=;
        b=m1sTUdtz0IBH4T58S0Qp8F887lOMFeQ6E3LwhmSyto0/XicAZGMKH/OdcvxBS/gioj
         hpdgTy+8k2waNEDrL7V93U+BcQrXkOtW7w1AYTphgWutJGFtTIY3zpT15dtk3Y+co1p9
         dCqpvzXMboOTnI8q3DAmcjPcZiP2ChNuhzxOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXg9Gj7QTUwpYvOhGlvMrbNF6i7eg/pUYIjVoM9j78w=;
        b=N6nJCQ9UCN/+sl58qG2vSoQizC+IFcQ/Vq2Gy5iS2jS58kCALx77XP61pTsFQF5JC3
         djeN9a51247222e7G09fEgml2PRooLezF/Fbsk84kf/hcJy9MjL1n+qhyefJ9Jrv3+LH
         NTkCzFgf0P7nY3Z9V6dsVpbm+KBTQ0w0+IpD0JIq5Pn15DpAIxoDeOk/znAseOQ6X4Vh
         IwBqMRPoGN3jbysu6deh5Y/6S/QWDkMVuUbWsLqvVygslfHa4ZWIXnokK4T31XhLqRbN
         sfTULcM7vz9E/ImCqW0bvRVGUukeaA9qm5MQiss9C6r7v+Mp7dduSheQwca+fT7Zz2MO
         W9Fw==
X-Gm-Message-State: ANhLgQ1OlB/8iHEb/erM8uYSupy8fg24RG+pVY+KYY+vomSXjNHvtYPR
        NTVsy4jLSB+dZAewPa+RzeRvDA==
X-Google-Smtp-Source: ADFU+vua2DRqzHPDCg1h0WaWa5jUQRYxfdS9IEm3qlPlei+YNlP5TOn8cJF3gz2OQRyZ5zwlg/XAUQ==
X-Received: by 2002:a17:90b:438d:: with SMTP id in13mr333664pjb.114.1583882210644;
        Tue, 10 Mar 2020 16:16:50 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 15sm43071797pfp.125.2020.03.10.16.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2020 16:16:50 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Evan Green <evgreen@chromium.org>, Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sc7180: Include interconnect definitions
Date:   Tue, 10 Mar 2020 16:16:29 -0700
Message-Id: <20200310161502.1.Ia2884ed3c8826f52fbd5dcfa7a376a2fac4f31e6@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-introduce the include of the sc7180 interconnect node name
definitions. Though this was part of v5 of the interconnect provider
series [1], it was dropped because the DT changes went through a
different tree than the header. Re-add that now.

Interconnect clients being introduced can reference this patch as a
dependency, rather than racing each other to add the include.

[1] https://patchwork.kernel.org/patch/11417989/

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 89ba01246f95b..eb5a527da685a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,gpucc-sc7180.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sc7180.h>
+#include <dt-bindings/interconnect/qcom,sc7180.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/power/qcom-aoss-qmp.h>
-- 
2.24.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4724AC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 23:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfFRVFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 17:05:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41227 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfFRVFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:05:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so976932wrm.8;
        Tue, 18 Jun 2019 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Owfnfi210bHG1KCwxED8o2q5fezVlInfI5jl0eNKEeI=;
        b=tXd4wZnAEtzG4ZCi51jSRC5yJgInu58CiLl+5O15+09xhtHxypQT/Imiq+WzTDyEjm
         zvcz8EcTQjHl0gIguBkTqXOPx7pzy12CArANSNhjbWiQKzwpU6x2rq6QwiN8Zup/zmbu
         y+L5WbDuSvQ/gj4+uA7H0XEjoOG26XMxIBCAYIf6buwDzg/1Di5Vqdv0ElixvmD18fhY
         PtZmkzlpAZpYDxotPNXTzDT1UCiRnEqKQvJfePHNUeM7dXz4lMLWzfd5ZWYnbkfpB5nV
         mTDSiWbbANfAWDMw/jY2JetRSDmZoe8C68VvhQkZzhKHlxXWddGxUwQlt2qYWKChocls
         /yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Owfnfi210bHG1KCwxED8o2q5fezVlInfI5jl0eNKEeI=;
        b=Xqi4wSrEuN3BBHk0AULYOEGy+uzQAxtZVIDBXjVOUttGH4upZuupHMr+JEniwfxM65
         6znZj+CWGzdvPJ7ED6S4vG0SAH0+tssRcdGMYWQwxkrjkvxMS26nbqAfVsMD6Lv14QQJ
         TFjFlciOHLxRUVxASFUKjtcw8qBvoigtz3MNjoz2ydNRSdjevnOMMbU/44i1rVYQEWk0
         zOQ5tO6zoLC/i/F3trH4ONzYMjupUQX4gKmiDI4M3xOVGobeu6lMoD8feJNpKilkw6SU
         d76sY+iuKB0VFuRThadZn4z0c2t6FcTnCMbeikPECwJuJyxpNuINCT8P0nmxBdfNtqYl
         zAyw==
X-Gm-Message-State: APjAAAXCI3AC36Ms4PhF5b0hsO2u+WhFZZ8ELEhd00j+13s3ZLsV0j60
        dRyyJyZqhNsbzwfYDyr/4Z4=
X-Google-Smtp-Source: APXvYqzuuLGELMPFkAg7k0kkbez3Tn1R9vAHVUTeupwHe3hO4aYZSehvzMHMRdchUTaBQrP0/ZOduw==
X-Received: by 2002:adf:edcd:: with SMTP id v13mr4292343wro.210.1560891931820;
        Tue, 18 Jun 2019 14:05:31 -0700 (PDT)
Received: from localhost.localdomain ([188.27.67.107])
        by smtp.gmail.com with ESMTPSA id v27sm31492545wrv.45.2019.06.18.14.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 14:05:31 -0700 (PDT)
From:   Daniel Baluta <daniel.baluta@gmail.com>
X-Google-Original-From: Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, anson.huang@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] arm64: dts: imx8qxp: Add lsio_mu13 node
Date:   Wed, 19 Jun 2019 00:05:16 +0300
Message-Id: <20190618210516.28866-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lsio_mu13 node is used to communicate with DSP.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index b2cb818c76c6..dcdbd86897ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -448,6 +448,14 @@
 			status = "disabled";
 		};
 
+		lsio_mu13: mailbox@5d280000 {
+			compatible = "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
+			reg = <0x5d280000 0x10000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+			power-domains = <&pd IMX_SC_R_MU_13A>;
+		};
+
 		lsio_gpio0: gpio@5d080000 {
 			compatible = "fsl,imx8qxp-gpio", "fsl,imx35-gpio";
 			reg = <0x5d080000 0x10000>;
-- 
2.17.1


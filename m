Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00254196C94
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgC2KnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 06:43:08 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:59016 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgC2KnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 06:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GvIf4+eUNL1gbmmlGGdEoiRCzJ2FSgngRS1uiMDz0y8=; b=OSu5Ou+wMQoaATVtW/sNGEV0ri
        ZMP0h6BdAqR+gpykFasX+sK1ESSQPPgG+6/1WeCbNqBi0DuYOXNdJlKfnbbTlruq91fp6QROEGs+1
        PElH/opcIkEEYFXeFbrKXDuXoJm61ctGCR46x9gzq6KhYteY9rbs5995XBSJwQG3Lr4c=;
Received: from p200300ccff499f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff49:9f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jIVPE-0006ng-Rt; Sun, 29 Mar 2020 12:43:05 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jIVPE-0003xz-Ao; Sun, 29 Mar 2020 12:43:04 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] dts: ARM: e60k02: add interrupt for PMIC
Date:   Sun, 29 Mar 2020 12:42:50 +0200
Message-Id: <20200329104250.15194-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PMIC driver now has IRQ handling, add the GPIO to
listen to things like RTC alarm or ADC conversion completion.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
The corresponding property is added to the bindings documentation in
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-iio-rtc-5.7
 arch/arm/boot/dts/e60k02.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index ce50c4dc6f2a..3af1ab4458ef 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -117,6 +117,8 @@
 	ricoh619: pmic@32 {
 		compatible = "ricoh,rc5t619";
 		reg = <0x32>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		system-power-controller;
 
 		regulators {
-- 
2.20.1


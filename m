Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B0181C73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgCKPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:37:29 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:55378 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729521AbgCKPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:37:28 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D4C92C0F6A;
        Wed, 11 Mar 2020 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583941048; bh=3I5ra8dGipfbdGLcndVTjdZugHQr9qywD7CxZqjwkjw=;
        h=From:To:Cc:Subject:Date:From;
        b=DfZsbrtweeZbBJKDevvBLxr9lAbrq6NHP0G2oxUupj22c9toV0qKDwaHuPpbH1gzj
         1MxLbfklRPtziZpqWiH7t/cjwDrD2ECbl1UFmpfeI/QSdJZ1QoJuUdaGRumVnVsuSp
         x7DJOF6B6qfkoKPLCUHyAj73NeOlTgv7ymfeikqEfOtYxjoXhxTPqxBqmQQRL1xyvy
         pbPi9Pvs6MVs/SOZC24u2QKm293AmsvVhY+Ngln8s9SJoQNoGlmGIkaLQhSEY5ZoQt
         Ow90hfJir8+6LEo5PqW9LRsaEe4/pMCzA8SmDbYqFcxBymBe+AiIZxe/x6Cd+vdIhr
         VEHzT1Qw2RAeQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20410A005B;
        Wed, 11 Mar 2020 15:37:25 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-axs10x]: PGU: remove unused encoder-slave property
Date:   Wed, 11 Mar 2020 18:37:24 +0300
Message-Id: <20200311153724.16140-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC PGU is looking for encoder via endpoint mechanism and doesn't
use "encoder-slave" property for a long time. Let's drop unused
"encoder-slave" property from ARC PGU node in axs10x.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/axs10x_mb.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
index 1d109b06e7d8..99d3e7175bf7 100644
--- a/arch/arc/boot/dts/axs10x_mb.dtsi
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -305,7 +305,6 @@
 		pgu@17000 {
 			compatible = "snps,arcpgu";
 			reg = <0x17000 0x400>;
-			encoder-slave = <&adv7511>;
 			clocks = <&pguclk>;
 			clock-names = "pxlclk";
 			memory-region = <&frame_buffer>;
-- 
2.21.1


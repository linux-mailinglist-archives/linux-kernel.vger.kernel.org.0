Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3623878
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbfETNnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 09:43:24 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:47878 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389412AbfETNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:43:19 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5B2D4C01A7;
        Mon, 20 May 2019 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558359805; bh=reTmF1bCjM35df0o63yVrU14FQlaB/qxg+NFA08wM/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=VUpqz3vhDn9+ax2Mdpp2Hbg3hVFBTfN83Ie1NgzpQ0NpS6iwVO0r7I5qZB2zmaunm
         es44+96V+tZ7xBrvQAbxV5scvO+Wse8jCFvPbDO3FJ1ZF7zRzZz95FTOz3snU2+e6N
         5d2/c2/Rvyk3LW8wvTGQPJgccoAGxgnHmQ/HkXzkZpLUxa1VXTkPhCS/VRttk6N5+x
         DWQTeQOC0j1Y1rTVdl4TYScVJ7PCik0ZqjkKe8iBGAWWlNEtybjL7txpBGNmPSv0i7
         kByT31TYlrsoSrwQ5skCa4flsvj9q8mR2MVKf+MRGXLwwPFbBq7XfJon7mRCNA0PCb
         5o1bScGxUiHRw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id B4FE7A00A2;
        Mon, 20 May 2019 13:43:15 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id E944D3CE91;
        Mon, 20 May 2019 15:43:14 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 2/2] ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC node
Date:   Mon, 20 May 2019 15:43:13 +0200
Message-Id: <cdd9b9c36ff1ac3a3b56dff4a90e9bfd89b48866.1558359611.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558359611.git.joabreu@synopsys.com>
References: <cover.1558359611.git.joabreu@synopsys.com>
In-Reply-To: <cover.1558359611.git.joabreu@synopsys.com>
References: <cover.1558359611.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding for RX/TX fifo size of GMAC node.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/boot/dts/hsdk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index b0f059377ab0..3bcd1edc4dcc 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -196,6 +196,9 @@
 			mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
 			dma-coherent;
 
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
+
 			mdio {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.7.4


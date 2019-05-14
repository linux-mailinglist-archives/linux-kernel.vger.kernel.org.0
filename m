Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF61C964
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 15:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 09:28:35 -0400
Received: from node.akkea.ca ([192.155.83.177]:46966 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfENN2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:28:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id C42734E2058;
        Tue, 14 May 2019 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557840510; bh=bLmus07ZtGpPjQkmnxTr8q/vrmMNTrER0QBD1MkZdFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ftBKvJFVUQVEa44o1ZbscwiB80Tj18fmdMlQTlczAuMW1g3gIbnZyg/zrHB994Y7h
         iK1/iGBP2LAt26k+dWbRHcoOoftm6PEEeedJg94QFU7dEnIutM+Er36xtCWdz7UqiF
         1Lz6hDZMb3dmyjXLl1HyYg9w2bCBnQsoB0OyVGiU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LHH9VyWS5AMq; Tue, 14 May 2019 13:28:30 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id EADBC4E204D;
        Tue, 14 May 2019 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557840510; bh=bLmus07ZtGpPjQkmnxTr8q/vrmMNTrER0QBD1MkZdFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ftBKvJFVUQVEa44o1ZbscwiB80Tj18fmdMlQTlczAuMW1g3gIbnZyg/zrHB994Y7h
         iK1/iGBP2LAt26k+dWbRHcoOoftm6PEEeedJg94QFU7dEnIutM+Er36xtCWdz7UqiF
         1Lz6hDZMb3dmyjXLl1HyYg9w2bCBnQsoB0OyVGiU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v12 3/4] dt-bindings: Add an entry for Purism SPC
Date:   Tue, 14 May 2019 06:28:21 -0700
Message-Id: <20190514132822.27023-4-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514132822.27023-1-angus@akkea.ca>
References: <20190514132822.27023-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Purism, SPC

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index e9034a6c003a..64bb1fa1a4d5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -333,6 +333,7 @@ poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 probox2	PROBOX2 (by W2COMP Co., Ltd.)
 pulsedlight	PulsedLight, Inc
+purism	Purism, SPC
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
-- 
2.17.1


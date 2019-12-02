Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8510EE18
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 18:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfLBRWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 12:22:11 -0500
Received: from node.akkea.ca ([192.155.83.177]:60936 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbfLBRWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:22:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B6C324E200E;
        Mon,  2 Dec 2019 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575307330; bh=Tay7PkRhxC2/HjsR27QnZoDpIHZRaRRBRVcxi/0JbN0=;
        h=From:To:Cc:Subject:Date;
        b=kF36udmj79PxzlmPMUv7izKr4qbE/7DwPB17XqS2jgooFuBBFM69CWI8ydDdYleWt
         +knkMlQsBVrcSjYiHBglkllwofuDV+mL7OfyL9woBAIKtMe538ZXdFjVsx/s3KfGcB
         EclPrSIiz5KJG9cJV4JAG9FSfrQkffOC8IFFRIIs=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IzGH-TaFCzUL; Mon,  2 Dec 2019 17:22:10 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id 7E7054E2003;
        Mon,  2 Dec 2019 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575307330; bh=Tay7PkRhxC2/HjsR27QnZoDpIHZRaRRBRVcxi/0JbN0=;
        h=From:To:Cc:Subject:Date;
        b=kF36udmj79PxzlmPMUv7izKr4qbE/7DwPB17XqS2jgooFuBBFM69CWI8ydDdYleWt
         +knkMlQsBVrcSjYiHBglkllwofuDV+mL7OfyL9woBAIKtMe538ZXdFjVsx/s3KfGcB
         EclPrSIiz5KJG9cJV4JAG9FSfrQkffOC8IFFRIIs=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH] dt-bindings: vendor-prefixes: Add a broadmobi entry
Date:   Mon,  2 Dec 2019 10:22:03 -0700
Message-Id: <20191202172203.11917-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Shanghai Broadmobi Communication Technology Co.,Ltd. for their modem
dts entries.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..fa657235dbda 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -149,6 +149,8 @@ patternProperties:
     description: Bosch Sensortec GmbH
   "^boundary,.*":
     description: Boundary Devices Inc.
+  "^broadmobi,.*":
+    description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^brcm,.*":
     description: Broadcom Corporation
   "^buffalo,.*":
-- 
2.17.1


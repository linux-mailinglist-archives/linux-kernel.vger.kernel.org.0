Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92501117BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 00:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLIXoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 18:44:24 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:37941 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfLIXoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:44:11 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7E0EF23E4F;
        Tue, 10 Dec 2019 00:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1575935048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=be7fCu04a3V6kQ7ufijxN9WEC5BVATqlM0smfMMKPzM=;
        b=NcDWtc/VBlnBMG47Rt5w7nZ7WVB+MyLHMZznm5b5XjGWw+ZyxCyn4SdB3k75aYYNv0mmUi
        If9CbR/9owDKM18kPS8PhpmRPvZy97EIWAeLLiOsUlZjQ3iarc27/EzzgUjg/SJFnkdISJ
        TGz0D4gfQTvtQzGXKb1819tVH/osneU=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 4/5] dt-bindings: arm: fsl: add Kontron sl28 boards
Date:   Tue, 10 Dec 2019 00:43:49 +0100
Message-Id: <20191209234350.18994-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209234350.18994-1-michael@walle.cc>
References: <20191209234350.18994-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 7E0EF23E4F
X-Spamd-Result: default: False [6.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-0.00)[-0.683];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c::/31, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Kontron SMARC-sAL28 board, its variants and combination with
carriers.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../devicetree/bindings/arm/fsl.yaml          | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f7792fe89a00..80ab4b5b68ef 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -358,6 +358,44 @@ properties:
               - fsl,ls1028a-rdb
           - const: fsl,ls1028a
 
+      - description: Kontron KBox A-230-LS
+        items:
+          - const: kontron,kbox-a-230-ls
+          - const: kontron,sl28-var4
+          - const: kontron,sl28
+          - const: fsl,ls1028a
+      - description:
+          Kontron SMARC-sAL28 board on the SMARC Eval Carrier 2.0
+        items:
+          - enum:
+              - kontron,sl28-var2-ads2
+              - kontron,sl28-var3-ads2
+              - kontron,sl28-var4-ads2
+          - enum:
+              - kontron,sl28-var2
+              - kontron,sl28-var3
+              - kontron,sl28-var4
+          - const: kontron,sl28
+          - const: fsl,ls1028a
+
+      - description:
+          Kontron SMARC-sAL28 board (on a generic/undefined carrier)
+        items:
+          - enum:
+              - kontron,sl28-var2
+              - kontron,sl28-var3
+              - kontron,sl28-var4
+          - const: kontron,sl28
+          - const: fsl,ls1028a
+
+      - description:
+          Kontron SMARC-sAL28 board (base). This is used in the base device
+          tree which is compatible with the overlays provided by the
+          vendor.
+        items:
+          - const: kontron,sl28
+          - const: fsl,ls1028a
+
       - description: LS1043A based Boards
         items:
           - enum:
-- 
2.20.1


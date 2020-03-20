Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1BE18CCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 12:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCTLYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 07:24:10 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:53806 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgCTLYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ALXaab2s1Lnzx+nrRs34/oE0duhtrEmt949ImG19WlQ=; b=qT1hN+mMLdTgt3zkV6EZlpedaX
        TrB0dv1Ypg7q9Uy7f+dWH+EhWKpjtNV7TXVUwczk3Cz4r/iFICmItVabjcsWR6ntVPam1v/Vesbok
        PHQEk+qMopTee/MjeuiPXH6JJO5B6iCFT8g+KrSi+8dVlESVn3S6thH7rSe7zUee5ToI3TX0X7c5D
        CjvWLpi7FGV6V23rK6g8cv4diTGyGPxwmPpnmSDaa9+NBNcuAKZiW68xmOKPAM1AqvNpUR9Da6mDL
        T2K9kq3aIeXOtfLV4pdM4xeYQMlR1923Q98DpkZRrny0f1aZIQsjx+ILpDgnvrCdh3b/hlk/k1fxU
        jCEOe0NA==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:57936 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jFFkr-0011ci-BD; Fri, 20 Mar 2020 12:23:57 +0100
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [PATCH v2 1/5] dt-bindings: panel: Add binding for Starry KR070PE2T
Date:   Fri, 20 Mar 2020 12:21:32 +0100
Message-Id: <20200320112205.7100-2-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320112205.7100-1-dev@pascalroeleven.nl>
References: <20200320112205.7100-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: dev@pascalroeleven.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree binding for Starry KR070PE2T

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 8fe60ee25..7cbace360 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -43,6 +43,8 @@ properties:
       - satoz,sat050at40h12r2
         # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
       - sharp,ls020b1dd01d
+        # Starry KR070PE2T 7" WVGA TFT LCD panel
+      - starry,kr070pe2t
 
   backlight: true
   enable-gpios: true
-- 
2.20.1


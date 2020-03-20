Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED22118CCF1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 12:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCTLZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 07:25:55 -0400
Received: from web0081.zxcs.nl ([185.104.29.10]:58628 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgCTLZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qEhR3T0Nfojt3eERAwazI68eQPd13TAEcxAgAW/RKYc=; b=N0cfTIenwdEy/BWu8/a7ulLJBk
        PU/AJ75NTxnoUgVZ6XaLXNNky4hAfXBR4xZTV6OwUCA/tlIyqhthjm0yi8FPiAyG3ik37CEJlfLHR
        g7FUk3YrTLUyN/CvfD1MvPZs0J9e1I8iPPSowOvFSB2fsau6RWOr/kXBMJmUHK4wDL4YpEP5PfLmJ
        ftY2GzKOnn+s6ZEeZcFCIDfNE2ws49hHC5SNTHSi2+rHYM8IgojRAPMD8rUgCXWjj7kJ4xAWcuqMl
        JrnUxB/tV/cSAehFrBbmIuwcKDoGYZtVkotPsIRCFuR6qqoqimIeZZq07RKTOipXjw7NGUXxH1dNA
        7DFA7y6g==;
Received: from ip565b1bc7.direct-adsl.nl ([86.91.27.199]:57936 helo=localhost.localdomain)
        by web0081.zxcs.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <dev@pascalroeleven.nl>)
        id 1jFFmf-0011ci-PN; Fri, 20 Mar 2020 12:25:49 +0100
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
Subject: [PATCH v2 3/5] dt-bindings: vendor-prefixes: Add Topwise
Date:   Fri, 20 Mar 2020 12:21:34 +0100
Message-Id: <20200320112205.7100-4-dev@pascalroeleven.nl>
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

Topwise Communication Co,. Ltd. is a company based in Shenzhen. They
manufacture all kind of products but seem to be focusing on POS nowadays.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944be..3c08370b7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -982,6 +982,8 @@ patternProperties:
   "^toppoly,.*":
     description: TPO (deprecated, use tpo)
     deprecated: true
+  "^topwise,.*":
+    description: Topwise Communication Co., Ltd.
   "^toradex,.*":
     description: Toradex AG
   "^toshiba,.*":
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907026FC32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfGVJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:31:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:10722 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfGVJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563787857;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Dv/zMXLNc2LBJs14qIfW45fwOAU8bZrhI21MX9TcRdI=;
        b=S7p6JMCx1TwPACpx6jZwjS/DXdWONjNqWGH15VZMV3VsEM4d4WF5MXTeLmLrWLS0sS
        OMfrq+Tgb+8MtseZqrPVLoPM1aqQS8FrvumqMZGlFkNOMXlaAUJJSi7WkQfcHfGnxzz2
        HSBKqp3QJOCyK98WARc7kPo34zVhYMFDzLIpOWpksVDdDYIPIvxKu6TOwkBg7VSZLNfI
        lf5VKe+imU+lQ4RoKSFJnOkQVTR40q6AZ62XLa8u3iTQ1y3fTJ95M0/S+8UWhTx1oamB
        pdycMYf2ONRsSC5hBfD43XIlFl1M1sR/pp7kt2ucsXiCLnL1Mak45QZTaPm5eisyXIXM
        rnjg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxP4G6N/EiB"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id m0a13fv6M9OlObw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 22 Jul 2019 11:24:47 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [RFC PATCH v2 1/4] dt-bindings: vendor-prefixes: Add Longcheer Technology Co., Ltd.
Date:   Mon, 22 Jul 2019 11:22:08 +0200
Message-Id: <20190722092211.100586-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722092211.100586-1-stephan@gerhold.net>
References: <20190722092211.100586-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "longcheer" vendor prefix for Longcheer Technology Co., Ltd.,
an "industry-leading service provider of mobile phone design
and product delivery". (http://www.longcheer.com)

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6992bbbbffab..7bcf340b6f38 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -529,6 +529,8 @@ patternProperties:
     description: Linear Technology Corporation
   "^logicpd,.*":
     description: Logic PD, Inc.
+  "^longcheer,.*":
+    description: Longcheer Technology (Shanghai) Co., Ltd.
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
   "^lwn,.*":
-- 
2.22.0


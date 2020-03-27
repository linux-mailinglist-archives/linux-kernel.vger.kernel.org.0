Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C04195B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgC0QbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 12:31:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgC0QbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:31:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02RGUNhE049560;
        Fri, 27 Mar 2020 11:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585326623;
        bh=l5rP1MJ098endPpFd2r/1F4oKnCHZocHpiIjl3Yjeas=;
        h=From:To:CC:Subject:Date;
        b=Sc8lp1CHfGpWMuD27YH+Bcn8tzIN/6RAV4Y2CV1gpPWmzxwl2bh1nDlLUNTieHG8D
         eW6qxaH8zrE5CuyAoKxEAds6hXvClCyw3yh4dMXddAF7OzkRMSKSNMKbAXMlcZbRyG
         55bU/nFPIx8puDDsl3/EWIX42V6nKj8zARloiPQo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02RGUNUc094613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Mar 2020 11:30:23 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 27
 Mar 2020 11:30:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 27 Mar 2020 11:30:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02RGUMvJ054778;
        Fri, 27 Mar 2020 11:30:22 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: sound: tlv320adcx140:  Remove undocumented property
Date:   Fri, 27 Mar 2020 11:24:32 -0500
Message-ID: <20200327162432.17067-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove undocumented and unneeded ti,use-internal-reg from the example as
it was an artifact from initial development.  The code does not query
for this property and as the document indicates if areg-supply is
undefined then the internal regulator is used.

Fixes: 302c0b7490cd ("dt-bindings: sound: Add TLV320ADCx140 dt
bindings")
CC: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index 1433ff62b14f..ab2268c0ee67 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -76,7 +76,6 @@ examples:
       codec: codec@4c {
         compatible = "ti,tlv320adc5140";
         reg = <0x4c>;
-        ti,use-internal-areg;
         ti,mic-bias-source = <6>;
         reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
       };
-- 
2.25.1


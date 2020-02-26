Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90A170439
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgBZQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 11:22:29 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56422 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgBZQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:22:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QGLgFg121430;
        Wed, 26 Feb 2020 10:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582734102;
        bh=qYRk9Qh2iIroRJl+3iF1hS7lDL46mTc+W347ZyPJ/Y4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zv3tIkZTlNxl061VWhv5IRD7r/Wuj0GamrHOZepyhdddPGavnbn4oblg+TozaglJF
         elHnb96ezQRKVsCR+NwFF3ZFVb1inIxImkuqSOKLXbkEIO90bNcjDbw1nKB2oJqRQt
         7enTOTyUIWoL4Re/TfiSq4ihakWkiPVb9kBgddNs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QGLgvT064850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 10:21:42 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 10:21:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 10:21:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QGLgqE074809;
        Wed, 26 Feb 2020 10:21:42 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [RESEND PATCH for-next 2/3] ASoC: dt-bindings: Add TAS2563 compatible to the TAS2562 binding
Date:   Wed, 26 Feb 2020 10:16:27 -0600
Message-ID: <20200226161628.29960-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226161628.29960-1-dmurphy@ti.com>
References: <20200226161628.29960-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Texas Instruments TAS2563 audio amplifier to the TAS262
binding.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2562.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
index 658e1fb18a99..94796b547184 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -8,7 +8,7 @@ real time monitoring of loudspeaker behavior.
 Required properties:
  - #address-cells  - Should be <1>.
  - #size-cells     - Should be <0>.
- - compatible:	   - Should contain "ti,tas2562".
+ - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
  - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
  - ti,imon-slot-no:- TDM TX current sense time slot.
 
-- 
2.25.0


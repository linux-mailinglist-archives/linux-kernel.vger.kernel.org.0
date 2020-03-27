Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85D2195CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 18:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgC0R2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 13:28:52 -0400
Received: from foss.arm.com ([217.140.110.172]:49746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgC0R2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:28:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FB531B;
        Fri, 27 Mar 2020 10:28:51 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05F763F71E;
        Fri, 27 Mar 2020 10:28:50 -0700 (PDT)
Date:   Fri, 27 Mar 2020 17:28:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        Rob Herring <robh@kernel.org>, tiwai@suse.com
Subject: Applied "ASoC: tlv320adcx140: Remove undocumented property" to the asoc tree
In-Reply-To:  <20200327162432.17067-1-dmurphy@ti.com>
Message-Id:  <applied-20200327162432.17067-1-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320adcx140: Remove undocumented property

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From d4061518c3982010d8f07b9b327c8e00297b14a3 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Fri, 27 Mar 2020 11:24:32 -0500
Subject: [PATCH] ASoC: tlv320adcx140: Remove undocumented property

Remove undocumented and unneeded ti,use-internal-reg from the example as
it was an artifact from initial development.  The code does not query
for this property and as the document indicates if areg-supply is
undefined then the internal regulator is used.

Fixes: 302c0b7490cd ("dt-bindings: sound: Add TLV320ADCx140 dt
bindings")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200327162432.17067-1-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34AA1704B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 17:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBZQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 11:46:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:58336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgBZQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:46:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C95AADE0;
        Wed, 26 Feb 2020 16:46:05 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     phil@raspberrypi.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: bcm2711: Add pcie0 alias
Date:   Wed, 26 Feb 2020 17:46:00 +0100
Message-Id: <20200226164601.20150-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bcm2711 revisions have different DMA constraints on the their PCIE
bus. The lower common denominator, being able to access the lower 3GB of
memory, is the default setting for now. Newer SoC revisions are able to
access the whole memory space.

Raspberry Pi 4's firmware is aware of this limitation and will correct
the PCIE's dma-ranges property if a pcie0 alias is available. So add
it.

Fixes: d5c8dc0d4c88 ("ARM: dts: bcm2711: Enable PCIe controller")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index cb3385262705..479f6828d73f 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -21,6 +21,7 @@ memory@0 {
 
 	aliases {
 		ethernet0 = &genet;
+		pcie0 = &pcie0;
 	};
 
 	leds {
-- 
2.25.1


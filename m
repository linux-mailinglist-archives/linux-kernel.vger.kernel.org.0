Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74474F94E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 17:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKLP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 10:59:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:57130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727137AbfKLP7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:59:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9604B3B4;
        Tue, 12 Nov 2019 15:59:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     andrew.murray@arm.com, maz@kernel.org, linux-kernel@vger.kernel.org
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 6/6] MAINTAINERS: Add brcmstb PCIe controller
Date:   Tue, 12 Nov 2019 16:59:25 +0100
Message-Id: <20191112155926.16476-7-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112155926.16476-1-nsaenzjulienne@suse.de>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller serves both the Raspberry Pi 4 (bcm2711) and brcmstb
platforms.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f7f8cdbc471..96d0feed45e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3223,6 +3223,8 @@ S:	Maintained
 N:	bcm2711
 N:	bcm2835
 F:	drivers/staging/vc04_services
+F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
@@ -3278,6 +3280,8 @@ F:	drivers/bus/brcmstb_gisb.c
 F:	arch/arm/mm/cache-b15-rac.c
 F:	arch/arm/include/asm/hardware/cache-b15-rac.h
 N:	brcmstb
+F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM BMIPS CPUFREQ DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
-- 
2.24.0


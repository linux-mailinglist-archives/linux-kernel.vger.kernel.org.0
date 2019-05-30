Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C18A3053A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 01:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfE3XKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 19:10:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40236 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfE3XKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:10:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so4901275pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HnaOzrwwH51oiIcYbbiBCTmS7Rc7gDAzx83ZpPiCGcM=;
        b=t2huDdkmSslScVjL94JKcIQCMTMwwACkvRwPfUenZ7x2N/8P/OndXymZV/ztYmff3n
         Yk91NpO1iA0Ra2DTWifvaZl+HZnhGShz3a9IH8XU6PkSoLOoaL0pUgZe3BpUWMTjOh1N
         PkPNkT2KEJ8KweJSbM9uvyv3d9n7MOE9gjf9Bbmj/0Jc/NUlS1bwaqgvfYcIrTwFJzpJ
         ytlES1SMoigWeXgb70wxf+NpnrJ0vQTOGQoenE/O40jCq1Qf7PDz0AQtJh6wC58PInvG
         aJvqv5XNX4CiYEm+o1ckIBYPJi9N2c6hfY+4qbHaLN0SL6TxgOL/iuF5Sc3/1T5ebnJZ
         AhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HnaOzrwwH51oiIcYbbiBCTmS7Rc7gDAzx83ZpPiCGcM=;
        b=RZZsiIJKOCbmcrDOiU4gcrlDUI6HAmZfrRelGHSkgXRtE9bQAqlEUjWo36us5iMymB
         faANHLIvbNbrGl8GziTL/xIBxe80LEVTZ407GcgrpHbA/Kh8MDBkmRHEX3mGdmGwEGeH
         2OtyV7lZuOIOfiM+66PmZFNmpMy351TwZP6djhGqRFi+Wfkep/6oTulZAqZpPlaBDCnI
         Aq1zdNYNfgsTJeYXTDmpMZf8gFXmsbuEzmcOFUKQcBPydOXVmwBv3rckas3yWZO2/G4b
         hafrzOpcaDoKpIHy02jPjwCUiZnKyFz4PGp+bFKIs0dj61fJ1vjcFrA7U3vh/lNhTMIM
         hs2g==
X-Gm-Message-State: APjAAAW0shC8CKNJQns8olwKN4MqvlbbXwXcu4WI0UXoRnPZZ/v0LNUU
        +mxIXYnLQdkXakcuLRQqLdE=
X-Google-Smtp-Source: APXvYqx7aB3hSQRS2ZPzY3sVELO8sZe8zAAyeqzVXweS1UkqAbfC9T/d66uiLnWGgbp5+RvPfchtIQ==
X-Received: by 2002:a17:90a:aa85:: with SMTP id l5mr5502041pjq.69.1559257808071;
        Thu, 30 May 2019 16:10:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k8sm3871643pfi.168.2019.05.30.16.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 16:10:07 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: bcm: Enable BCM7038_L1_IRQ for ARCH_BRCMSTB
Date:   Thu, 30 May 2019 16:09:58 -0700
Message-Id: <20190530230958.7059-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_BRCMSTB makes use of the irq-bcm7038-l1.c irqchip driver, enable
it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 4ef1e55f4a0b..ef4600cd2ce9 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -211,6 +211,7 @@ config ARCH_BRCMSTB
 	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
+	select BCM7038_L1_IRQ
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
-- 
2.17.1


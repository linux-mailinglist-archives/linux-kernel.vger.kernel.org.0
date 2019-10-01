Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51A7C43F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 00:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfJAWtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 18:49:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38231 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfJAWtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:49:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so5798457plq.5;
        Tue, 01 Oct 2019 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MAMlkRnO5l7BTKTwRIiopLRzEQTrPpsCd+4MsukYmNc=;
        b=HAz4lDL4/HYy4Ox1QSCZ3kvs83mTwGsEqL60MTu/23VTwZHoyErK+WUt5t3kZyKIck
         YrwFzDaJDdqBgFIGjkIjKor6i2iwhTKxEW6l18Lkbai3McS7Fal1Gv9/wyepIKKfq84U
         VFUTkBIjcovYwb8z1TyZMurQOni9Q5Q7nyigZWHapWBYWeggFg2up3dAECedjaSRua+4
         aEwWBFqLGXIC44i31OcMMGuCqBqBjR9IzO/R2n8yX1JcgF8IMibIYMOuARrOba5ELcYV
         xfJqhGzN9tNd9cwWMFA2x2WlztMuRFFb00jO04J5C0r9j0NGHO/pe0YINATrFzePM5W4
         2W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MAMlkRnO5l7BTKTwRIiopLRzEQTrPpsCd+4MsukYmNc=;
        b=GKfzfnKn0QjdMX/bilfBdHmes3WWZPUl+aIh3yyrH2ZKyPlcx1XyUjU6yPLcbGRN97
         o1EHmnjAKm1j1m+nY5aYQhW6WL3RMUdUqsonQ8XIFM1D/2sEdwiAQA41/s6LmW/vau76
         y5q7kNlq0rIpCk6j9rOl7//nReEJcA7MHNRV9v6AOItmm9Cn68ep88rCumUDKYiGWguN
         LixufQqFhhFNUL2P1G6lPhrfLUxTzIzO13LF/cK6RlZJnR8crzlfK5+sq59zm9Gw4xcK
         j167Yq6Byg4Ce5KyroNjyf4ymdPqptYW9dsh9uYzrAD6mI4LrXIgoWXhCnF4sG6Bf/La
         7F8w==
X-Gm-Message-State: APjAAAXMssv+XjadoAVRjLKof3K9ReuNg/BZEOYLF+Icy14UMCJCcRcQ
        k18cag4qDVYJBw9vajVSTKmq5QzP
X-Google-Smtp-Source: APXvYqxEhwZILl7XTzqS0JmTl5V0s3Q2tsvy5lvU7+vFWHRphKhv2LJaKswN152OGBrBamTuEaAp4w==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr229858pld.150.1569970143390;
        Tue, 01 Oct 2019 15:49:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:49:02 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH 6/7] irqchip: Build BCM283X_IRQ for ARCH_BRCMSTB
Date:   Tue,  1 Oct 2019 15:48:41 -0700
Message-Id: <20191001224842.9382-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001224842.9382-1-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that irq-bcm2835.c and irq-bcm2836.c have been updated to support
BCM7211 which is under ARCH_BRCMSTB, build both drivers for
ARCH_BRCMSTB.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d1bb20d23d27..ffd5f986172a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -116,7 +116,7 @@ config I8259
 config BCM283X_IRQ
 	bool
 	select IRQ_DOMAIN
-	default ARCH_BCM2835
+	default ARCH_BCM2835 || ARCH_BRCMSTB
 
 config BCM6345_L1_IRQ
 	bool
-- 
2.17.1


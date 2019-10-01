Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F016BC43F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 00:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfJAWs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 18:48:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33936 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfJAWs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:48:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id y35so10756876pgl.1;
        Tue, 01 Oct 2019 15:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmmruYs8eLLY9TVJPuXrREyshp3NHm54X/4qVh/jdCE=;
        b=t2gIYStIo7EvVeIu6qgRKCQj05e3VScNvXYgE/q7zJYjc7ohseAY+M8DvdBFlWgw5T
         2FodYA90XfoyXlFgDJj86rC/vBcSFP28bvv+t2dEx0okKZzoGQPmJmCq0oJ1qrnkFbJF
         UuujmtaBm5j9LQGWmdlahf25QNGo046c1yJLAMUSAkv5044TM75nHV2e9cvgAMILuLzC
         lQQq+l2CdWjUeQM4Z6G9qJoU/GiPpHmocgGaSfijjwSj8VdmoDwNnykDtzj1MieYiq1R
         mBO7XG+R0x/z2GEiAYcgayT3W/UO/y/ln4IIAeCbdZBGBGsT0IswilDEdfSn8ILvpQl6
         TNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmmruYs8eLLY9TVJPuXrREyshp3NHm54X/4qVh/jdCE=;
        b=smXbuvcP8+feWtjq7osSAoC7vRtaUjeIJxxccwGYobaJ1XdDw+8nwEVNoY4m01xldw
         8vbQC73gt4mDThVIJ2B9PtqNrIRY8i4OQLHX+5qo2p3klNONiOynuZr0S3S3ajVM4BRJ
         cim07cxArvbX9SUPc2xjVd9RkkJioXIStZWHiLwujRFEloHjd/Frw1SVTcasM3/3qFQC
         WbPDCFt9gg01V2hQRzPTwcf1mmEnBRMesvRtZgAjApF7nQeLbIZFmIneS6x/MehYE4pL
         mRrn3lg+du25oR0HVs5nkZPFhrvG1zNhNAeHIxT32A9JNN8xIuNvwDTtPO+dQ7gsPP7U
         ttfQ==
X-Gm-Message-State: APjAAAUCMQp/6WaI00zBZoX/QozL8IRiSo8zfnHr4CuUqilJpR1KizE9
        nenPYYUDqH1XtNXFgfxiy/VDsRPQ
X-Google-Smtp-Source: APXvYqwhgl5YTOlRsYIJipNujsEavjL7imf4qlNubaxLu6R3vxIAUZv7WzUYsDaYY6Me7w0ebcmRvQ==
X-Received: by 2002:a17:90a:24a1:: with SMTP id i30mr702873pje.128.1569970137924;
        Tue, 01 Oct 2019 15:48:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:48:57 -0700 (PDT)
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
Subject: [PATCH 2/7] dt-bindings: interrupt-controller: Add brcm,bcm7211-armctrl-ic binding
Date:   Tue,  1 Oct 2019 15:48:37 -0700
Message-Id: <20191001224842.9382-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001224842.9382-1-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7211 features a second level interrupt controller similar in nature
to BCM2836, with a few modifications to the register offsets, document
that specific compatible string.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../interrupt-controller/brcm,bcm2835-armctrl-ic.txt        | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
index 0f1af5a1c12e..0b07845b46e4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
@@ -12,7 +12,8 @@ interrupt there indicates that the ARMCTRL has an interrupt to handle.
 Required properties:
 
 - compatible : should be "brcm,bcm2835-armctrl-ic" or
-                 "brcm,bcm2836-armctrl-ic"
+                 "brcm,bcm2836-armctrl-ic" or
+		 "brcm,bcm7211-armctrl-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
@@ -25,7 +26,8 @@ Required properties:
   The 2nd cell contains the interrupt number within the bank. Valid values
   are 0..7 for bank 0, and 0..31 for bank 1.
 
-Additional required properties for brcm,bcm2836-armctrl-ic:
+Additional required properties for brcm,bcm2836-armctrl-ic and
+brcm,bcm7211-armctrl-ic:
 - interrupts : Specifies the interrupt on the parent for this interrupt
   controller to handle.
 
-- 
2.17.1


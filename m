Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01A11918E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLJUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 15:09:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:09:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so21519934wrt.6;
        Tue, 10 Dec 2019 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KlsBUJwYdM7SXbMApHLqeQhJsLc3mR/p7rFqoydEok4=;
        b=lz1QaZAGHeTc/ijJo6V27zZwf62uJZVRebgHc/mBkHPBIOt6Se2iLUnNu71tp8wCeL
         XYMDu9Tt2bY/kqWgjd1l/cBA6hs13nIbdj7ZlloukO01edwwryA/EBGWbR1YEKTjiHz/
         MDY3Csk6RHzvWijMbAFRQ5K8SaRGu5UIh2PjAsr75RCP4QoWyMFVsgiVAU6UFgv9rRam
         QDAERwmASBIb0E6EH4ac79OE8VViZ/t3T4Ywo6Am/h20teNRoGs0JKycHzyctBioc5Hz
         L05ghMha8dYLTB06bE8HFCcDBXuvO+23K6H4uxaYJ/rdTHjxMCiVkBEH92o7/rwLtXQv
         zL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KlsBUJwYdM7SXbMApHLqeQhJsLc3mR/p7rFqoydEok4=;
        b=kcinUQGpMR+COOG+PvXBcky8hDd0dLeK/kzFqZfbeLfthpw4rfXlLLw8q1YE/LCwqK
         mJQvHrVe2/bSRoSXajS25eNlSbtO9zjlgRF9KZDwKRPdq04/wVdW4c+NzMxr5DTYZFlU
         Xn55FLE3KJy+p1UqQyohmsYfqv0gu+r0WQnjBaiRzPEMB6OYb39zr1cvxqgtdqgcGZIu
         33ghmN9Vr8BV5jp2Avak43KIVVuCUBYDjOPDGbAzQMs/3XAKnDfXSycXuFNVBhpuOSHT
         sh1RFCC/09KKsqlMa+mjyZv3vsOsvolztb3vPONF+dTf7LL+kfMqvD8eQZZOWmrUIKV1
         f4IA==
X-Gm-Message-State: APjAAAXM9uNtTJYeTq//75S+WujDht+CIiBYZsftLXRHwxLt9qgMtabR
        hp/X0AV+Bf7LF7HyoeSTVD4=
X-Google-Smtp-Source: APXvYqyUdoIyAKqiB4UnMN/qX5fpLQybyRYkQu9nxmXblrx9PKUF9Di0xHQPn2uBX4dEfPUbuI7/QQ==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr5107948wrp.110.1576008556437;
        Tue, 10 Dec 2019 12:09:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w19sm4113643wmc.22.2019.12.10.12.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:09:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     kishon@ti.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 1/2] dt-bindings: phy: Document BCM7216 SATA PHY compatible string
Date:   Tue, 10 Dec 2019 12:08:51 -0800
Message-Id: <20191210200852.24945-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210200852.24945-1-f.fainelli@gmail.com>
References: <20191210200852.24945-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define "brcm,bcm7216-sata-phy" as a new compatible string for the
Broadcom SATA3 PHY.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
index b640845fec67..c03ad2198410 100644
--- a/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: should be one or more of
+     "brcm,bcm7216-sata-phy"
      "brcm,bcm7425-sata-phy"
      "brcm,bcm7445-sata-phy"
      "brcm,iproc-ns2-sata-phy"
-- 
2.17.1


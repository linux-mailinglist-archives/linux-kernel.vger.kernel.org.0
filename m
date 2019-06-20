Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5714DC33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFTVKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 17:10:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41616 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFTVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:10:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so1876307pls.8;
        Thu, 20 Jun 2019 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cDab2WaDc8pmyozwLyE8nCfYmBAFCdTC9FtT+TR/XI0=;
        b=uY7cEYYQj2MK+bqyQ9CpRQfc3g1dfCFniZZIXkdY8drNCUNjJBLLaHdZH5+p06aemy
         GcGPYFm+q6oXQg+Jk8Ala/K1G1hgnI/L09BDHXHqDAkba54zHOpJbaSyOCQ2sJ5l05eV
         ALWeeMvw72G9T8lbNHqkzhfWXR9/ZBQy9k2FxcErC0mA2YYQHGxp7/d53WjF+pivlOxI
         cl6enhqqSNB+LYMH8jSauOfmidOQtrqYIJvkL2iSEbHFH3w3HCip2upVzj0jXjK7A1cK
         v1BO7cd/kPDvEeTCxLY/QuvFgikQTM3Vhf9T+ateZNZyvGVYPp6VhyrfIowMOGjNJy+H
         L6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cDab2WaDc8pmyozwLyE8nCfYmBAFCdTC9FtT+TR/XI0=;
        b=mFt3vCx/TijTuTXuUdRGZmf74cqAHpzWRW8CEN/qGNepBQVqQ5HuYNKTfnxovsR5kp
         4B8iXqSYWH+9uHkuPvaWoinOiSO4c9DyKLn7YsCvhacNimxumcVRoKUjj51+g6OELPE3
         sjaeyNNFIRDJidvdRLVrt7n7oxAegpIG/8HVT2YPoqcW1C3oiKuAaMJTZdwidGum+MlB
         rEqmUInsFN+mOsFphDxMGXNsP6s4yP5Ywv7PpzwRW7Pjt0uD06ULz0ayuXLXdqF+Dzic
         6bMjAflC9+zbVmgUnWvbtnQSMpDpNGxpTTwJ5+btjI7VdErVVr4ZsA58w2t2B3ESMnMG
         AFMg==
X-Gm-Message-State: APjAAAWJknMq5MDPU6QDU6mfXRq9wsaEZEq94A7O7kDDYWh9JqhuVP/t
        Wphr1CDuzn1d1FmEJNnfi9x1BPTBOYQ=
X-Google-Smtp-Source: APXvYqwZjKo2rGUjYzKp0BcPEdJYd30LpDC7JkTj8NUjDCwb1T5DEN95UNT37w4J5RCNhwMlN2GQvA==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr9490608pld.112.1561065016794;
        Thu, 20 Jun 2019 14:10:16 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p1sm386805pff.74.2019.06.20.14.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:10:16 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 5/6] dt-bindings: usb: bdc: Update compatible strings
Date:   Thu, 20 Jun 2019 17:09:50 -0400
Message-Id: <1561064991-16874-6-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "brcm,bdc-v0.16" because it was never used on any system.
Add "brcm,bdc-udc-v3.1" which exists for any STB system with BDC.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 Documentation/devicetree/bindings/usb/brcm,bdc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.txt b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
index 63e63af3bf59..597f3902d857 100644
--- a/Documentation/devicetree/bindings/usb/brcm,bdc.txt
+++ b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
@@ -4,7 +4,7 @@ Broadcom USB Device Controller (BDC)
 Required properties:
 
 - compatible: must be one of:
-                "brcm,bdc-v0.16"
+                "brcm,bdc-udc-v3.1"
                 "brcm,bdc"
 - reg: the base register address and length
 - interrupts: the interrupt line for this controller
@@ -21,7 +21,7 @@ On Broadcom STB platforms, these properties are required:
 Example:
 
         bdc@f0b02000 {
-                compatible = "brcm,bdc-v0.16";
+                compatible = "brcm,bdc-udc-v3.1";
                 reg = <0xf0b02000 0xfc4>;
                 interrupts = <0x0 0x60 0x0>;
                 phys = <&usbphy_0 0x0>;
-- 
1.9.0.138.g2de3478


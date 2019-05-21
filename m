Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F825270
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfEUOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:44:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44978 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:44:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id c5so8530155pll.11;
        Tue, 21 May 2019 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5hSVFJBohFjK9FSeZbvc1XbTRHdPXQ9DePHe1SZpJps=;
        b=EgF2gub7T32hGBYch+5cag0ZHP3ftygxoSFTghzmsNn/7gpMaWPzWBT/hsD1KGrUAe
         GqFIr7bTRXjgk9pJRFBfcmZ2TgJEnFJFzxET9by/Nv16VQ/vpPg6CUr0kTFbESqb+uuo
         rsoo3PnXAMRqZrrB6KEaH+p9eeKUA8FEauSpG8IrB1tMG6omnk39ivcyPQnLKICAY/Vq
         jTyFOLlJjDStRXaxZEeuPEc/oJ1wZLbCNmRcJBJEjuZBMZvpWR+bDmuvrlUzTvgjRBPy
         NT/1D5F0Ru7j8gsRKQJnyFb+H07quREQS/uXsrfbaZzLxRI+1HVlT+sxohAt/c6gVTnQ
         H6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5hSVFJBohFjK9FSeZbvc1XbTRHdPXQ9DePHe1SZpJps=;
        b=NU3samsVtuu6+udNrCeZ2Qs7/PcihohxgXbzQRB338L0E1ZZZ/9AMqkBMZitLSR2Mz
         3S7A8odk4W54tshlhTHIXF9JuLFSvMuyhC2A9chobPllJZjaV/tmyClb4T3Z8A4s1MSb
         8VKjsSyr2hmVdK7I4jxmFj/zroWsTDxh/GdkeO/h3MUSWJxRSQfb+LhvKw3ZmdS2hvZB
         rrYGPnLTTBkGSDtj62Oa46GoD+Onad2xMQ3qtgbYkNoowfLop4QRf0EvizAiC4WfKGfm
         x9qnZEhPaKytoYMPOvnYV1R6TdtH7cGjeNoDRRAngTxb9z7KpBMa69gmke4UIZhi9VZe
         /rTQ==
X-Gm-Message-State: APjAAAWBYfKqaoVLpSOv+UgTwuIQEWlcnbknXgXYqSuG0s0l2GA8NM3z
        5CyvMDTOWTvX1dy/dlzstlU=
X-Google-Smtp-Source: APXvYqwN5M46bLj4p1rW2xAHz/GQgxgVKlmBJe3gqKesdGm7yuComflkxTKuJS1Bz2EF1upSxW6XBQ==
X-Received: by 2002:a17:902:521:: with SMTP id 30mr44314557plf.62.1558449880398;
        Tue, 21 May 2019 07:44:40 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g17sm13227945pfb.56.2019.05.21.07.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 07:44:39 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: mtd: brcmnand: Make nand-ecc-strength and nand-ecc-step-size optional
Date:   Tue, 21 May 2019 10:44:21 -0400
Message-Id: <1558449865-36852-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nand-ecc-strength and nand-ecc-step-size can be made optional as
brcmnand driver can support using raw NAND layer detected values.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
index bcda1df..0d952af 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
@@ -101,12 +101,12 @@ Required properties:
                               number (e.g., 0, 1, 2, etc.)
 - #address-cells            : see partition.txt
 - #size-cells               : see partition.txt
-- nand-ecc-strength         : see nand.txt
-- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
 
 Optional properties:
+- nand-ecc-strength         : see nand-controller.yaml
+- nand-ecc-step-size        : must be 512 or 1024. See nand-controller.yaml
 - nand-on-flash-bbt         : boolean, to enable the on-flash BBT for this
-                              chip-select. See nand.txt
+                              chip-select. See nand-controller.yaml
 - brcm,nand-oob-sector-size : integer, to denote the spare area sector size
                               expected for the ECC layout in use. This size, in
                               addition to the strength and step-size,
-- 
1.9.0.138.g2de3478


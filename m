Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 904668446E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfHGGWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 02:22:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45616 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfHGGWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:22:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so39122151plr.12;
        Tue, 06 Aug 2019 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=kPrp8nG0QEUeUMz0Ak8tH6QVQCe9QZAzvRu9tkMhvlo=;
        b=gU1EKsK1Xyi6hcBW6jyVX8/FHdkfrg/w6z63scbu08I6eQ7OAaNRJPgW9ruJX4/Y+K
         z2IlG3Rg9ftGpfxRuzTtAeQiZn7z1cPxoumMQSsF6F6cXwXGtDx0m2VWa0lB2BbfwNfM
         u+iuU7VF0waiurTMx7rL876gKo4yT7AH1UDdc87OwayRN3VGyzsKdHylvAzzEGOk740i
         +ctWa4dcQsWKWHqdhTApg7mhRAsV0llo6gh24iycRdfyuq5NKMAYTVx4EL0RK6exYjYg
         HN71UKBcPweK27Vas50YA4tT3EVPrWkvFVuokAZck0OFCvTgYcp9/gGNZ2mQR99SXUjQ
         XHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=kPrp8nG0QEUeUMz0Ak8tH6QVQCe9QZAzvRu9tkMhvlo=;
        b=V200gw/fB0GtTWgenOQe0NLO607rf6IBAbastK0cqO4QQlAk85VuzAnsVPIeGAfy2c
         5KxrdevuhdzTCFIEHuKup/pUw4J0iBjnmcRt2bapa8uaBp21OBjQ94b46Mlfbh6395Vx
         nX2tfWhKTOON+LkGKXyem63fNL9RI8rBAUPah127z7baD74/+Pe+K+JmNbKggXxUQDPj
         NvdDJFY7f/Kxb14ZQKEhzlGCnzbYG/kcWxt86ecuL5McjWMVMpQSLtBv/9vq3mIg/V+S
         XRg0xcneDKC3xW6USMbunrXuYk1Vloju8cBO/XNXcVhjBzx1kJ3JB2yrZxdiXlXtKEum
         8nIg==
X-Gm-Message-State: APjAAAWqeWSMzpWTowb4AhraqCgmj3znVwR+rAPgJppw9CEQoSCpVyzG
        nWfV0ioqbiSfbOSbJeEJU1U=
X-Google-Smtp-Source: APXvYqxSbOLXgQl6/SQk96QnmwJwXxYdXa/z4z0jNJd2HaSUW02GPmODddxX9YrVdZTnTWGGTmJC1w==
X-Received: by 2002:aa7:81d9:: with SMTP id c25mr7795660pfn.255.1565158965373;
        Tue, 06 Aug 2019 23:22:45 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id 85sm95310585pfv.130.2019.08.06.23.22.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 23:22:44 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: dts: sifive: Add missing "clock-frequency" to cpu0/cpu1 nodes
Date:   Tue,  6 Aug 2019 23:22:40 -0700
Message-Id: <1565158960-12240-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing "clock-frequency" property to the cpu0/cpu1 nodes
for consistency with other cpu nodes.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 42b5ec2..4befc70 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -22,6 +22,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		cpu0: cpu@0 {
+			clock-frequency = <0>;
 			compatible = "sifive,e51", "sifive,rocket0", "riscv";
 			device_type = "cpu";
 			i-cache-block-size = <64>;
@@ -37,6 +38,7 @@
 			};
 		};
 		cpu1: cpu@1 {
+			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
-- 
2.7.4


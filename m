Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF41344BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 15:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgAHONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 09:13:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgAHONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:13:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so3596099wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9A8G0j2tOPV5FCjdR09EsC+W3lv8v1DkkMAhtWMYjQk=;
        b=mE4ElWaJnTCOvULGEugcZlrS0AvKFzP2T1ZQgv7If0CPJ+801EzSgzPzUuVxDsV1b3
         encydKe/iOsHS+EWKTCPrnDN14rN2i7bdBgAXp4X+r+yNXWTHMj3dN9RFExBpJbyLGKH
         valhGxo4sfUf2TwXxWTJlqYgRBeHQBOxxuRZyxut9SiraDesPGrs/p2Ejw/9KGSzB1tq
         5IPun/7YCO5V5l24/dKQq8qF+soyBYBaLjng4RY62K2EYQS9M3x1yyf1JfZMcbqfkG5p
         LkUbSdldHFH2y8ANSsA2IFBoqEm6iawPVNTd2Fyzzt9zGDYEO/+YP1QiawMx/9hzAeYV
         UFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9A8G0j2tOPV5FCjdR09EsC+W3lv8v1DkkMAhtWMYjQk=;
        b=S0l2L11wn+SARzpNqD/tiUrlHYzXr0C7nixCT8uaLZg+r/s3fkHVTLiz48Gh1g2fVi
         IJXCZfdezGRibHVMJ6jethksNTBBMCGEahkoyx321iCedpdvGQDpWOgtKg3znP1CPlUe
         Td1x60lVvmaC0rmUm/NuZMb8m2cmbEcp8a03GZLwCtk3ujyy+vuwnRzb6NQvh9WNKjYx
         KSmQdKzDfJ/69hJmSreSmBIlw7xv3v65P4TpxY7cL5f50K6OjQNhlTJE/M8L0iNli7kz
         hnhQktb1dOiuFSAu/2qMm3N0b1VsVv2axqQc2XhSPGTP+Ve/evsos5WFghWJCowWc51b
         LgJA==
X-Gm-Message-State: APjAAAUMSJ/i2g8bPKymJhakgjyNQo464ngYmpp6TI4xMwAp78+cgU6x
        aSRW7RF2d1Q/dqBuhbTFsqZSO4sqp/c+8g==
X-Google-Smtp-Source: APXvYqyIFWyUUSpkZjERC1rO3Tqh856VOJb1uBTzRVh1CenvSxFc2c3XK5jdEbkpMbkznGy8J5Vt1g==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr4817516wrn.152.1578492782234;
        Wed, 08 Jan 2020 06:13:02 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q3sm4666671wrn.33.2020.01.08.06.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 06:13:01 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] microblaze: Fix message about compiled-in FDT location
Date:   Wed,  8 Jan 2020 15:13:00 +0100
Message-Id: <1a11e5cd73f6eb999f78981953d39773eb154040.1578492778.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%p is not working that early (don't know why)

Before this patch:
Compiled-in FDT at (ptrval)

After:
Compiled-in FDT at 0xc043c24c

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 522a0c5d9c59..effed14eee06 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -138,7 +138,7 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	if (fdt)
 		pr_info("FDT at 0x%08x\n", fdt);
 	else
-		pr_info("Compiled-in FDT at %p\n", _fdt_start);
+		pr_info("Compiled-in FDT at 0x%08x\n", (unsigned)&_fdt_start);
 
 #ifdef CONFIG_MTD_UCLINUX
 	pr_info("Found romfs @ 0x%08x (0x%08x)\n",
-- 
2.24.0


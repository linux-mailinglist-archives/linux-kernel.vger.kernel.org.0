Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5710D25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEATWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 15:22:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40213 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEATWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:22:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id e56so128004ede.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T7DidsTvqZaeVynddvHxxBbAAEvCO8/AfOY7nE2AqW8=;
        b=KHu23Ma6nMbPVzQb2iomiVuHbgOJlZeyOzYz7talegjesg/G2vqf5OjeHTAmg4eOE0
         IE+g5ARBtPYe/hV8jYk5sqOifHKJ7YWWHQnxK/XAy0C2Sb2pE90Itd2NzyV5MGGK8ABS
         Jv/HChG970YtLduHqoDISBOiwMWWrO+ixat8GlM2m/GPBxUOCx0C4Er3cAWpJXIIPPhT
         KP5SDDDpnH25A9ZbKiPQK+qkMvrElZA25R0kUqHKFtKO/TV2+THHICcn1NSRnANQpgmF
         RQA51mRYKhpOx1hTiy+JhPhNpsZYkqqDaBBxm/J3go71JPj6yd2BrgULUEhwvqDh7GAG
         45Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T7DidsTvqZaeVynddvHxxBbAAEvCO8/AfOY7nE2AqW8=;
        b=dMBD2gVoKlos/nkZjYdndZnlieYt1D+0Oh2yqhV9GHTfakfbNhv50IkCXZqcpiOAXr
         MFB3UTzWcavLNFKRXWtNbSk9HkBjNXtF7OvGud2ThM/XlLYOW068Fel+Ls707fOlIe+L
         foqSi6VwW5kA2/GXVJh3Ub2r1eO6qAgPen1FxxtV4fkoTjNtK1EbyHtSNp2jZydawvZI
         wbiuYgduysR3AZVIvXpXP0JTVegWPgf3gTk8owQ7HaP1yeM2UcV3tar93aVRLSE+Rsbi
         3afjT35ObPGzF8an6jq395tgLAWeLdhpo6vkqT2m3l7Jhk17D81Z0BJpeuo1blOQ4sN6
         jIZw==
X-Gm-Message-State: APjAAAV81qhhoDErlcge5HX5C208uaxg+WADEM6LrH6n5SISKBuycUgk
        hg38tUYi6/Kmf0pVSxJkJDJCXbnV
X-Google-Smtp-Source: APXvYqz4HSBDn3uHjHJ6HZyzyjEGVF0rgL9wjeexGQka8VXpbC0R4qEfbT9skPtWw3UlnrieJflsYw==
X-Received: by 2002:a50:e79c:: with SMTP id b28mr9954998edn.277.1556738558952;
        Wed, 01 May 2019 12:22:38 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g6sm11144033edd.48.2019.05.01.12.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:22:38 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v2] mtd: rawnand: brcmnand: fix bch ecc layout for large page nand
Date:   Wed,  1 May 2019 15:22:14 -0400
Message-Id: <1556738544-29857-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The oobregion->offset for large page nand parts was wrong, change
fixes this error in calculation.

Fixes: ef5eeea6e911 ("mtd: nand: brcm: switch to mtd_ooblayout_ops")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 482c6f0..3eefea7 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -939,7 +939,7 @@ static int brcmnand_bch_ooblayout_ecc(struct mtd_info *mtd, int section,
 	if (section >= sectors)
 		return -ERANGE;
 
-	oobregion->offset = (section * (sas + 1)) - chip->ecc.bytes;
+	oobregion->offset = ((section + 1) * sas) - chip->ecc.bytes;
 	oobregion->length = chip->ecc.bytes;
 
 	return 0;
-- 
1.9.0.138.g2de3478


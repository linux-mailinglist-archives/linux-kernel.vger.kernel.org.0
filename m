Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E185A724E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 04:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGXCrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 22:47:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41115 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGXCrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:47:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so10047018pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 19:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jBTk1hrNk+mwNzaYgR/1ZCf8cY2MU3CovpAv/pz3LXk=;
        b=EQMb5ADmcEHu05TNX6WPacxDeLfNc5iFh75wjjsxdhpxpLV0GetY9P2xNAjtYBGax7
         YxNhm277uugFSVCl2Pase2oKI4ZkxzFtYP1IDgctmJwFkfq5uFfyDKDt2wmi9br/YP9g
         HjURdQ5wwRjQeIIDC+oJrruD0y3rI1CaTQTIIcZbJR+fP+7Ybnx0XfymzMXti7S+w6By
         VMTx3sOoA3urPyhXz+hezoXDhSZLfEXehWnnRSf1taoRy5AR0KZ4XcxwMZ4Gwug1uzJQ
         pDoSiGv/gpXLxy/S1hxZpxT2RK/xyst4TyGPQRJmiOjSfae3YDYBhQrm02z9M8/BbEvD
         S+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jBTk1hrNk+mwNzaYgR/1ZCf8cY2MU3CovpAv/pz3LXk=;
        b=J9/ypI/v416u1XoxzPJcg/Do6YZi5/LiKhj82JmgRo9ofl2W1kAUFYXDCeN/UcYMfw
         jsPdfs2AeyuDfzwht9AvEE5UUf2j+QymCduYNVTQhVetCR1g5QnfhMtgH+jSc2TBT9wp
         9BYHP+K6bkuQI17qb5YkvONy3S/UE06xaEMHi5dPrgHBYwK8UQ42tTbi8y2bueR95HnU
         NlBnuaMAVx7QWuTeSWH/kRzPk0wO+pl4byOqMP+dZplgNZtwMtep8urF+vJJealfROJy
         J00b1P89xLXDHNOkBqdyCMGWFi0Jq90pFpgGKrU5Vs9pI/oKAqGAQYVYxr61HgghzgMo
         Vq1A==
X-Gm-Message-State: APjAAAU1GyMsLhLRH6xatGNiDq6DaSddA1R4o68OqL4QMYOZ1TSJvK0B
        K83xf2rC6z1h7deDnAvopu8=
X-Google-Smtp-Source: APXvYqzljyqxqRrlCFHMqxEOclzeWh/TVTapUPxvESWXNFbY9TNSova2LH7dpR2YRyCCgWuaerqfxA==
X-Received: by 2002:a62:ce07:: with SMTP id y7mr8559601pfg.12.1563936424998;
        Tue, 23 Jul 2019 19:47:04 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id l124sm45063616pgl.54.2019.07.23.19.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 19:47:04 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dwmw2@infradead.org, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: jffs2: Fix possible null-pointer dereferences in jffs2_add_frag_to_fragtree()
Date:   Wed, 24 Jul 2019 10:46:58 +0800
Message-Id: <20190724024658.27623-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In jffs2_add_frag_to_fragtree(), there is an if statement on line 223 to
check whether "this" is NULL:
    if (this)

When "this" is NULL, it is used at several places, such as on line 249:
    if (this->node)
and on line 260:
    if (newfrag->ofs > this->ofs)

Thus possible null-pointer dereferences may occur.

To fix these bugs, -EINVAL is returned when "this" is NULL.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/jffs2/nodelist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/nodelist.c b/fs/jffs2/nodelist.c
index b86c78d178c6..021a4a2190ee 100644
--- a/fs/jffs2/nodelist.c
+++ b/fs/jffs2/nodelist.c
@@ -226,7 +226,7 @@ static int jffs2_add_frag_to_fragtree(struct jffs2_sb_info *c, struct rb_root *r
 		lastend = this->ofs + this->size;
 	} else {
 		dbg_fragtree2("lookup gave no frag\n");
-		lastend = 0;
+		return -EINVAL;
 	}
 
 	/* See if we ran off the end of the fragtree */
-- 
2.17.0


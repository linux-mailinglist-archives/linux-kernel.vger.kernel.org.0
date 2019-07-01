Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E934E2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 05:12:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44661 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFUJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:12:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so4470733lfm.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGWPck9wpyZRR3E02z/BR5xB8SDUTdEAXPWir9EA+Iw=;
        b=w6zy5RcYtlwpn9uZXBTPnNqk13OWqgW/Z2IEW/b5Va7tVCdbZbgJ0Cnouiv1j8bK7K
         bWDV6rGP+wes+RvdAIhBg3cRGlsDMwzbX/6Pfp6zyqHpiYqTGnTFvLM0Pg65iaGyGe9S
         wL+Qtd2PN1OIZ6m+5zeoMcbz9V58AEbYH7Ozo007qVRWkc4c0o/JWGYAueBfZWH3kyVJ
         GiMfrOUImqgt+6PJ9Mmm3Q25GZAXsoP7p0h+TeEEOa9HMFuROrH4kUTSFef/409yBtpA
         SZksPiF4DLQ6yesYrrSClVK54ohgnvbcEUQAx3MFCpdpHzGuDwlT14kmhEqQv6OX076f
         LdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGWPck9wpyZRR3E02z/BR5xB8SDUTdEAXPWir9EA+Iw=;
        b=ugspS1T1yn1u8odgi6FpbMAetOTotDyv7xwsIIg2b7tclS2Vv2/JRO1RTkSG1kR2r0
         1/emSMoHCLy+//5oL7s/xAtpWHyPHaJKGu1dHFlLCP22wYvjZHF3wwZNkuUzu0Sc0uYc
         fqVj2Nw04BFXafsbrmz/CzTKak5n1saQuOjxzmHekrffwG6/hN/QxHfsUqTtjPF4O3N2
         ynnKj7z30BsxHY6JJOBk+Pm+ivaocYDFzRvGuuKzuzUJFR56ezNyT7pcmSxmGlD4gwgh
         TIL6zr++73BzgooLp0BjEHFI3YUuYfcoGGPZ0xizUOIM67a2loHBo9AWDMUizPwYCAGS
         JsGg==
X-Gm-Message-State: APjAAAXfQVJ9mRMdEPGxQrEWek3xHTghyYpqj8xN+5zsIEFuESiajxPw
        s4VKRHAMO76aV32VsUTzjvDNhg==
X-Google-Smtp-Source: APXvYqwEQaPtv/AT8pgQU9n75IZ6a1nGoS44tadH/5E9dMkzEJyY5mAnoUx0dj0rJvAXeL1ic/ruZA==
X-Received: by 2002:a19:d5:: with SMTP id 204mr1954825lfa.66.1561108328971;
        Fri, 21 Jun 2019 02:12:08 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id z26sm303178ljz.64.2019.06.21.02.12.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:12:08 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 1/2] lightnvm: pblk: fix freeing of merged pages
Date:   Fri, 21 Jun 2019 11:11:59 +0200
Message-Id: <20190621091200.23168-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621091200.23168-1-mb@lightnvm.io>
References: <20190621091200.23168-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

bio_add_pc_page() may merge pages when a bio is padded due to a flush.
Fix iteration over the bio to free the correct pages in case of a merge.

Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 773537804319..f546e6f28b8a 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -323,14 +323,16 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
 			 int nr_pages)
 {
-	struct bio_vec bv;
-	int i;
+	struct bio_vec *bv;
+	struct page *page;
+	int i, e, nbv = 0;
 
-	WARN_ON(off + nr_pages != bio->bi_vcnt);
-
-	for (i = off; i < nr_pages + off; i++) {
-		bv = bio->bi_io_vec[i];
-		mempool_free(bv.bv_page, &pblk->page_bio_pool);
+	for (i = 0; i < bio->bi_vcnt; i++) {
+		bv = &bio->bi_io_vec[i];
+		page = bv->bv_page;
+		for (e = 0; e < bv->bv_len; e += PBLK_EXPOSED_PAGE_SIZE, nbv++)
+			if (nbv >= off)
+				mempool_free(page++, &pblk->page_bio_pool);
 	}
 }
 
-- 
2.19.1


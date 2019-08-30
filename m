Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD5A2DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 05:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfH3D5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 23:57:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34020 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfH3D5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:57:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so2816601pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 20:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/HuFXkowcP+PhyYkveYBzv+j/h0vppynxHJvt6n2HAk=;
        b=moQeQIKoaJ93ePUYq94t6PADnGL2q3riHOwSm1XVfTZMGiQo4fV69WkpUmcqt5BP1W
         3cXgke7tr09maxVWa/iWQThO8rMN8byoSkxy29BLEpAGyRjswKoA6rRn+/9t3swI74ck
         mctaSLZRJ8NQaePEYastuGIEt4okwxK8PPu2KNj8oMV1j5OasElKppOurLrr0yw6/ruK
         Ld/RXGOilFBM3dlmGUqgBPgrKY+Xu3ACWyMq2Dr/Z7jnkbrsg/i8HpBCWqdMiBp5mchU
         jLsel04EOud3NkxXoSEGSPRAT8Fw7U+5nyRCZrrRhrPGvgh44xPJZbmZWnv/ZF4W/Ji7
         XhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/HuFXkowcP+PhyYkveYBzv+j/h0vppynxHJvt6n2HAk=;
        b=fkHksisElpEN3FAdSc2orHr94dSxYPfGEnqAmDcTNMy/EGBUGyIoLMCUSK6STBGdOQ
         CRjlaDGKy3kMLLgosyQEQAZk1ksfnB/E5nrU4wJOYnvkm0srXdnVCd75rGVW3Y51tcZ+
         uSlKezPbWQ1okH02celBv5KSSGWFUK089Kxp4VFZ5QC7bBoGbKpHrQBuTxM0Q6+Xzbpo
         nEM6iiSOWVIgUf2VVrW5HrVVb4s3g9fAMDemssZSCU+77FZxG8hZwKzwhDrxL5/XLOxe
         NMSp29nYzCbmc6aFoGcNw3vbfGPgBfhb/rjelrsmqBZvMYWLaivom41HLlKD6TV6x/Rp
         0QRw==
X-Gm-Message-State: APjAAAVbN1aDxoW6u6YX1krQxdnUoG3GAIAGSSHV4+mng+fCIuSHhWl9
        RNbogqHIyoYXFiOaWoSeZKQ=
X-Google-Smtp-Source: APXvYqwNoLkKDpIBufzzAa4LKNrJHjHtc25D+dzgQpL88XmdY4FUFnHk06c63DKPdWP8/ES4ZAV4LQ==
X-Received: by 2002:a17:90a:fa82:: with SMTP id cu2mr13917778pjb.85.1567137442010;
        Thu, 29 Aug 2019 20:57:22 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id o1sm3024519pjp.0.2019.08.29.20.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 20:57:21 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:57:16 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     akpm@linux-foundation.org, urezki@gmail.com, guro@fb.com,
        rpenyaev@suse.de, mhocko@suse.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        austindh.kim@gmail.com
Subject: [PATCH] mm/vmalloc: move 'area->pages' after if statement
Message-ID: <20190830035716.GA190684@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If !area->pages statement is true where memory allocation fails, 
area is freed.

In this case 'area->pages = pages' should not executed.
So move 'area->pages = pages' after if statement.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 mm/vmalloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b810103..af93ba6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2416,13 +2416,15 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	} else {
 		pages = kmalloc_node(array_size, nested_gfp, node);
 	}
-	area->pages = pages;
-	if (!area->pages) {
+
+	if (!pages) {
 		remove_vm_area(area->addr);
 		kfree(area);
 		return NULL;
 	}
 
+	area->pages = pages;
+
 	for (i = 0; i < area->nr_pages; i++) {
 		struct page *page;
 
-- 
2.6.2


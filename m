Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3F83DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 01:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHFXQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 19:16:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44829 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfHFXQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:16:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so64291408qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evI7jo74G4Gx7Gga7ZV8g3f7D3AhHv7OMI4oYy7KjpQ=;
        b=MzTXpv/RThZvTM0oekrE0HbJIq9MDfLDK/pFUY/Kg6pyTj13D+sPiKCI/dSGwPAxpY
         66cmu6NttsKhYSMYlnguyr7uhmgAbn3zoEecwJHbFK40+26VHkYuF99AdRjGXrECGqPh
         vtfbOQsp5XxERMNpAIlGBC0fNvBHCI4Xe9NbY9LiKeaS2gZSeE7ortCdr7AwymC1bQMf
         tH8isbUtYa12pesEmXPJTyySS7DaU/IrFA7s+yY18pgcvmsoF40zJdJl86bWxSpitktu
         59wGxHKZqUMMqNyx4DORY6ozb2JQGWE2AME4lSBAP89G+fxJ+NZfrKn08DfZpc+bITKO
         VTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evI7jo74G4Gx7Gga7ZV8g3f7D3AhHv7OMI4oYy7KjpQ=;
        b=am/Aijh9hqEBtKvcZRhFw/Vv55yBZGWa1SaJ0C8tsKzuKKzSGRAR8i0UN0/ae3RzvK
         VTn9LWiRRLH5T0iNqTW/rZdiXMM9LDF+A86b91oXzwnJYHfx9tII6L72iqoH/jMc3czi
         RlG2U2cjgzyK75oayhp2V2of4JYi3N0dP2uYJ2J+n8hUCsgrjMsmR8Q7MOI56gOgzyer
         HcAURGLyHj+i5RIAsFKK6nERz3XxVnugpKKpRXFjajiADTpJ9RrcRYHhKW3pTyvYnNSn
         72THE32n7mFMnVBr8fGKRPmHx+nDrKrjtBdNLWQezEiR/sK8twRkSYnl/aJvSjKEdsgG
         wpbg==
X-Gm-Message-State: APjAAAUGfZC9BEtRnh25TuUgP/dkrRn+7Oe4ldnKG0H1UShzAI3q6yEm
        n0A/jbpXBfgE37QpWUghwsHx+A==
X-Google-Smtp-Source: APXvYqylqTmNzPQYqTYhRiwrI4AtCqibIZpw6EBPoIBj42tnctW/9AiKc7I50IcPqwnV2QCyiSKRxQ==
X-Received: by 2002:a37:660d:: with SMTP id a13mr5780388qkc.36.1565133374824;
        Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f22sm35086171qkk.45.2019.08.06.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 16:16:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv8gg-0006eG-0j; Tue, 06 Aug 2019 20:16:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        Gavin Shan <shangw@linux.vnet.ibm.com>,
        Andrea Righi <andrea@betterlinux.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 hmm 01/11] mm/mmu_notifiers: hoist do_mmu_notifier_register down_write to the caller
Date:   Tue,  6 Aug 2019 20:15:38 -0300
Message-Id: <20190806231548.25242-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This simplifies the code to not have so many one line functions and extra
logic. __mmu_notifier_register() simply becomes the entry point to
register the notifier, and the other one calls it under lock.

Also add a lockdep_assert to check that the callers are holding the lock
as expected.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/mmu_notifier.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index b5670620aea0fc..218a6f108bc2d0 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -236,22 +236,22 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range);
 
-static int do_mmu_notifier_register(struct mmu_notifier *mn,
-				    struct mm_struct *mm,
-				    int take_mmap_sem)
+/*
+ * Same as mmu_notifier_register but here the caller must hold the
+ * mmap_sem in write mode.
+ */
+int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct mmu_notifier_mm *mmu_notifier_mm;
 	int ret;
 
+	lockdep_assert_held_write(&mm->mmap_sem);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
-	ret = -ENOMEM;
 	mmu_notifier_mm = kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
 	if (unlikely(!mmu_notifier_mm))
-		goto out;
+		return -ENOMEM;
 
-	if (take_mmap_sem)
-		down_write(&mm->mmap_sem);
 	ret = mm_take_all_locks(mm);
 	if (unlikely(ret))
 		goto out_clean;
@@ -279,13 +279,11 @@ static int do_mmu_notifier_register(struct mmu_notifier *mn,
 
 	mm_drop_all_locks(mm);
 out_clean:
-	if (take_mmap_sem)
-		up_write(&mm->mmap_sem);
 	kfree(mmu_notifier_mm);
-out:
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__mmu_notifier_register);
 
 /*
  * Must not hold mmap_sem nor any other VM related lock when calling
@@ -302,19 +300,14 @@ static int do_mmu_notifier_register(struct mmu_notifier *mn,
  */
 int mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	return do_mmu_notifier_register(mn, mm, 1);
-}
-EXPORT_SYMBOL_GPL(mmu_notifier_register);
+	int ret;
 
-/*
- * Same as mmu_notifier_register but here the caller must hold the
- * mmap_sem in write mode.
- */
-int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
-{
-	return do_mmu_notifier_register(mn, mm, 0);
+	down_write(&mm->mmap_sem);
+	ret = __mmu_notifier_register(mn, mm);
+	up_write(&mm->mmap_sem);
+	return ret;
 }
-EXPORT_SYMBOL_GPL(__mmu_notifier_register);
+EXPORT_SYMBOL_GPL(mmu_notifier_register);
 
 /* this is called after the last mmu_notifier_unregister() returned */
 void __mmu_notifier_mm_destroy(struct mm_struct *mm)
-- 
2.22.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8658883DBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfHFXQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 19:16:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35969 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfHFXQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:16:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so86496530qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NUFqlMBKMBn5vDhbmYDSPrCJfAHH+vuZmJm73vmPZ4=;
        b=LfRTCxlqNIR4uH7LAgvFKd3/HUW6EIX8oEHk8vRJZDXfu+MODxUjSc0mwQLjdlj1r5
         TdBQZiQ/h32bzsTmZvXIlzRhFHn0mmy0idj25YbeDts1A24fsEifBIe3NP5hqVvkvhrR
         nWWVKtWYfgjQk2Um2/MKR8gMUgvqui+DvGzyTcwS1oxYmThfLcGfOjUwJchzx5IQFtkm
         39y5spX//3k4QzhKIKnxJHNlnrtBxmpACeuwQvwhJuooM9+kRZCHN9wt4AYFAx6mZGXI
         dWzRId28bdIuuoDxYm8FkG1fzostiVkDLyxOWPmcJ25bAgDrnqB6r/Lbc3/r/c8WbtlX
         CAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NUFqlMBKMBn5vDhbmYDSPrCJfAHH+vuZmJm73vmPZ4=;
        b=OBs2zPgFCWpOpRo7V4NDJ085sTLf9kEggsDVHzF0oILU1B/MaUVLT7MANrKxFZlq03
         X0wE+LHtzSCcl8O6Y/OEhyZoLku082srce9KhqmNX+xTRHlgxeSPr9X+Z7T7n06KMzqK
         B3aRTCTMPsJeFsWnYTHJQoNKDfdhqgJBqRupo1HuxGMMAPVol9c0cVXs7iq1FEkADFZE
         +hZf91y0biS+2xqXkN/6JcTywlt7QuTic/VPcysDA6foF0RotUCzrSAM6cMhfNj5IkjN
         StOT9Q1qWwhN1hNd3xM3VJ/yzWwXOTBkHpsaGrvEZfdCPGTVqBtaTm3mT7gSjUdvcREP
         u+ww==
X-Gm-Message-State: APjAAAXpxrxf+/S6aAWlgiD+8CDoZ8XsCYJVYkOOpI2Rq0MQ6KFqWGH1
        A0N+1svu9fXXYwCfMFCSEe7FUA==
X-Google-Smtp-Source: APXvYqzyRI5TBbiUa5tyo3mkBzAmzYq9JR3/ocS4Z9Tm5ZTYPwm7qYeGZqLl/Ddc4+CKmoOUg5XVtQ==
X-Received: by 2002:ac8:270e:: with SMTP id g14mr5557862qtg.65.1565133377937;
        Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y9sm37771754qki.116.2019.08.06.16.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv8gg-0006fA-Hu; Tue, 06 Aug 2019 20:16:14 -0300
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
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v3 hmm 10/11] drm/amdkfd: use mmu_notifier_put
Date:   Tue,  6 Aug 2019 20:15:47 -0300
Message-Id: <20190806231548.25242-11-jgg@ziepe.ca>
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

The sequence of mmu_notifier_unregister_no_release(),
mmu_notifier_call_srcu() is identical to mmu_notifier_put() with the
free_notifier callback.

As this is the last user of those APIs, converting it means we can drop
them.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++------
 2 files changed, 4 insertions(+), 9 deletions(-)

I'm really not sure what this is doing, but it is very strange to have a
release with no other callback. It would be good if this would change to use
get as well.

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3933fb6a371efb..9450e20d17093b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -686,9 +686,6 @@ struct kfd_process {
 	/* We want to receive a notification when the mm_struct is destroyed */
 	struct mmu_notifier mmu_notifier;
 
-	/* Use for delayed freeing of kfd_process structure */
-	struct rcu_head	rcu;
-
 	unsigned int pasid;
 	unsigned int doorbell_index;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c06e6190f21ffa..e5e326f2f2675e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -486,11 +486,9 @@ static void kfd_process_ref_release(struct kref *ref)
 	queue_work(kfd_process_wq, &p->release_work);
 }
 
-static void kfd_process_destroy_delayed(struct rcu_head *rcu)
+static void kfd_process_free_notifier(struct mmu_notifier *mn)
 {
-	struct kfd_process *p = container_of(rcu, struct kfd_process, rcu);
-
-	kfd_unref_process(p);
+	kfd_unref_process(container_of(mn, struct kfd_process, mmu_notifier));
 }
 
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
@@ -542,12 +540,12 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 
 	mutex_unlock(&p->mutex);
 
-	mmu_notifier_unregister_no_release(&p->mmu_notifier, mm);
-	mmu_notifier_call_srcu(&p->rcu, &kfd_process_destroy_delayed);
+	mmu_notifier_put(&p->mmu_notifier);
 }
 
 static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.release = kfd_process_notifier_release,
+	.free_notifier = kfd_process_free_notifier,
 };
 
 static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
-- 
2.22.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC783633
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbfHFQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 12:06:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ufYdFo+9XJwMOX62CI8v2zFvEvykN+4LFgKRtsn/jXw=; b=q54LJoAxOoyTjGRyl8D80iZGMb
        lYxNuteSkjzIL5LB2TYkC0TXo+C0bsRy0oaVuqo9j0MlqChurC+FdW3n95QWIEUWw/aLfcWCP06yu
        YXY4J7ATQpT5OS8URVwWNOdqkWOYwNLcl0Hw3gLuN6FJ0B2COSdS/G5yYN5hPpGFTaOp3SSAoAhBN
        qThI/PXzNb6HKEIEt8dVxjuNyMmN3/LShHRtoUekUi9yBJA6s3ob8DsdTaxVBL+x/f2AtJACyVtKV
        r6sws4m88ditq+6B0oyycJeE1GcnQuNUd5x4WojtPgxtoFGkbowjE63VyCmmwr/UBTCy6BBjx33BB
        No0OVtTQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yL-0000WO-Aq; Tue, 06 Aug 2019 16:06:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] amdgpu: don't initialize range->list in amdgpu_hmm_init_range
Date:   Tue,  6 Aug 2019 19:05:40 +0300
Message-Id: <20190806160554.14046-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list is used to add the range to another list as an entry in the
core hmm code, and intended as a private member not exposed to drivers.
There is no need to initialize it in a driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index b698b423b25d..60b9fc9561d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -484,6 +484,5 @@ void amdgpu_hmm_init_range(struct hmm_range *range)
 		range->flags = hmm_range_flags;
 		range->values = hmm_range_values;
 		range->pfn_shift = PAGE_SHIFT;
-		INIT_LIST_HEAD(&range->list);
 	}
 }
-- 
2.20.1


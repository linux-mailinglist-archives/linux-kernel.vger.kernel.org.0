Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B737A0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 07:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfG3Fw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 01:52:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfG3FwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MiAJz6/LGZ9crHwvj8CLjPFMqAcUr7sr54tyumAelRs=; b=Rg7K55yowl6k/ZPgtgKzOFotco
        EVRGBimUYALuPVAK+Kd0lIYGAgz8qtzz4r7Rt2jsMd0MtpQWT8xWTjMhSpjmP6B+WzSAt0NQxsH3z
        +abmLHxfsepvGEZ16JG88WTk4KK/xmmi/835FUkRt3rJXl5jFfuGcN+T4XXHJZr+nfh2bJRDlW3PY
        pEOwZbQr5FVYHNr00EG+63WsoZ6aeTTX2HHITa6njQqVgFg/XDoSqkAj0N5KDOYMSp9n85MUhgF5D
        whhEQ2w7Jug4LOPnVeW4QA+7KPrsRNLvw5OSVDmss722pMK5UEW5tPkequZrhaCLygy8OXTJOT9po
        zeDCXljw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL3c-00015E-DZ; Tue, 30 Jul 2019 05:52:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] amdgpu: don't initialize range->list in amdgpu_hmm_init_range
Date:   Tue, 30 Jul 2019 08:51:52 +0300
Message-Id: <20190730055203.28467-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730055203.28467-1-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list is used to add the range to another list as an entry in the
core hmm code, so there is no need to initialize it in a driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


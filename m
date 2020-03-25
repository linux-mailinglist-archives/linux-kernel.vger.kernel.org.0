Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9531926AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 12:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCYLGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 07:06:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCYLGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EkHoDcsZdb3+NNm3P9VHHz4Mkfwg7iMQl/Gfq2O/6E8=; b=RJMjuKIC6trIUEu4k4lHbz+/Sz
        k9XRJZ0N+obCxSWid13xOFLXsvdxjW75eV2dE2SnwVr67Ha5kxuWHeUQAkP/JBvRy/vFK4L9B2w9u
        nukmi3Kyx/dcr5uLyH24nirR9mCCds8VyM2wxzlaPyuyV6c225Icm55ubqFk18gBMsCo3cvSKqRyp
        aOvcqoJSQ9k99SKulqNB8hG7/Xe4uc193FHk5PKcNuVA73zYxkUIOU8w22yiN5zaG/ZDZzj83EKKP
        sKod/6fyQme78Qzyviovb+eq1oDkcfE8Pru30KHHCvhlpFMjw7heXq6KVk3Q8YNi5VI4W9woPbsA3
        VuF7hlDg==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3rG-0001vA-Pm; Wed, 25 Mar 2020 11:06:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] block: unexport disk_map_sector_rcu
Date:   Wed, 25 Mar 2020 12:03:34 +0100
Message-Id: <20200325110338.1029232-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
References: <20200325110338.1029232-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

disk_map_sector_rcu is not used by any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 48ed042d7f26..144cb50e8eb3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,7 +345,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	}
 	return &disk->part0;
 }
-EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
 
 /*
  * Can be deleted altogether. Later.
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF9192D49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 16:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCYPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 11:48:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgCYPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8vpbSNblzf9RY5Yrw3ugXop3KwSRABCfQos9GBILzPY=; b=Ht8DKRPZ60rJ4Fqdz8OfMXTMqW
        zJPpnHc46iDI5JScml8dIkt8MRq6d7lG/YAF0FR4v1DLS7K2aTDET1ZPyKn1lrWCsq3c6dHtptWn8
        ghEDostuGnFSjTxX8l6X3xEj/e8P/pkfcbf6rUKepBmUCF+fzLPcKZOuoOBQQN0ZGLvQGkQj2Z7M6
        yXLaKVwZuE+PgTV7K0CTKiaIE+VVvKhGK5FeF4tdbWElltj7gfoW7qd3LvrY84jshlFoYMnV6f0uK
        EtuxB6zuhDRoXuA7UCEdWlRxc/2a/4lvySxfiVO9V0pRGKjVLLeB+QgKutPJG0Rd/YEQzuj9ce+SW
        JIPvENqw==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8H1-0005HF-5Y; Wed, 25 Mar 2020 15:48:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] block: unexport disk_map_sector_rcu
Date:   Wed, 25 Mar 2020 16:48:38 +0100
Message-Id: <20200325154843.1349040-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325154843.1349040-1-hch@lst.de>
References: <20200325154843.1349040-1-hch@lst.de>
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
index 0ee74b7e01f4..1e4855c8265a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -372,7 +372,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	}
 	return &disk->part0;
 }
-EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
 
 /*
  * Can be deleted altogether. Later.
-- 
2.25.1


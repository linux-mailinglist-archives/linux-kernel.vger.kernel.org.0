Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAD1926AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 12:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgCYLGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 07:06:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCYLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AK5e+mU1Ma2q6vCv2R327p1MJXsygIrqf2AYyif01k4=; b=U26RUwOipgBrUqQ6+2xbGUDZOq
        +TAgBFv/rd2/g8MmeEIO9jeilZmAQNMDFYqZGZJLGDPm5ICRxpFGXUDa3PuYGodek3ti7aPSPX5q5
        Q/zZU/vfip5UeG+Y18CQsSUyvuDakzlnb53VUvd8zVgBLsklQUeEK5VC69u4xxcoOZjLCfl4nQLF8
        INyLCfQUrjoZoXFIY0MWnufSietNGKQt9ygjOCaGf5bczwsfLl0OHGRCjon3m3gJgLI7g8THYrwOx
        MhVhwRAtABxDkV5UQS1nP5JNlGaZAjxi0L2N1ENVPKVeGLJjSUgTHPCHkfhZtcUsfie5tCu3LzKSG
        yjmDijlQ==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3rE-0001uO-4R; Wed, 25 Mar 2020 11:06:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] block: unexport disk_get_part
Date:   Wed, 25 Mar 2020 12:03:33 +0100
Message-Id: <20200325110338.1029232-4-hch@lst.de>
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

disk_get_part is not used by any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index e8978df06f35..48ed042d7f26 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -190,7 +190,6 @@ struct hd_struct *disk_get_part(struct gendisk *disk, int partno)
 
 	return part;
 }
-EXPORT_SYMBOL_GPL(disk_get_part);
 
 /**
  * disk_part_iter_init - initialize partition iterator
-- 
2.25.1


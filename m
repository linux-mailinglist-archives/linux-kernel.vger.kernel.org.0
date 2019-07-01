Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD835DED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 15:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfFENad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 09:30:33 -0400
Received: from verein.lst.de ([213.95.11.211]:43006 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfFENab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:30:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 43E3E227A81; Wed,  5 Jun 2019 15:30:03 +0200 (CEST)
Date:   Wed, 5 Jun 2019 15:30:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: too large sg segments with commit 09324d32d2a08
Message-ID: <20190605133002.GA13368@lst.de>
References: <alpine.LFD.2.21.1906051057200.2118@schleppi> <20190605100928.GA9828@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605100928.GA9828@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, it looks like something completely general isn't
easily doable, not without some major dma API work.  Here is what
should fix nvme, but a few other drivers will need fixes as well:

---
From 745541130409bc837a3416300f529b16eded8513 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 5 Jun 2019 14:55:26 +0200
Subject: nvme-pci: don't limit DMA segement size

NVMe uses PRPs (or optionally unlimited SGLs) for data transfers and
has no specific limit for a single DMA segement.  Limiting the size
will cause problems because the block layer assumes PRP-ish devices
using a virt boundary mask don't have a segment limit.  And while this
is true, we also really need to tell the DMA mapping layer about it,
otherwise dma-debug will trip over it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f562154551ce..524d6bd6d095 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2513,6 +2513,12 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	dev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
+
+	/*
+	 * Don't limit the IOMMU merged segment size.
+	 */
+	dma_set_max_seg_size(dev->dev, 0xffffffff);
+
 	mutex_unlock(&dev->shutdown_lock);
 
 	/*
-- 
2.20.1


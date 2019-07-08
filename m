Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDD62B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 23:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405400AbfGHVfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 17:35:19 -0400
Received: from verein.lst.de ([213.95.11.211]:37247 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404695AbfGHVfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:35:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D5E6268B05; Mon,  8 Jul 2019 23:35:15 +0200 (CEST)
Date:   Mon, 8 Jul 2019 23:35:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@lst.de, darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: memory leaks from xfs_rw_bdev()
Message-ID: <20190708213515.GB18177@lst.de>
References: <1562616489.8510.15.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562616489.8510.15.camel@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually have a discussion on that in another thread, but if you
can easily reproduce the issue, can you test the patch below?

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index 757c1d9293eb..e2148f2d5d6b 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -43,7 +43,7 @@ xfs_rw_bdev(
 			bio_copy_dev(bio, prev);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
 			bio->bi_opf = prev->bi_opf;
-			bio_chain(bio, prev);
+			bio_chain(prev, bio);
 
 			submit_bio(prev);
 		}

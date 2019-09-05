Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CBEA9A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 08:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfIEGGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 02:06:33 -0400
Received: from verein.lst.de ([213.95.11.211]:45989 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfIEGGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:06:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 27DF868AFE; Thu,  5 Sep 2019 08:06:28 +0200 (CEST)
Date:   Thu, 5 Sep 2019 08:06:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Message-ID: <20190905060627.GA1753@lst.de>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:40:44PM -0700, David Rientjes wrote:
> Hi Christoph, Jens, and Ming,
> 
> While booting a 5.2 SEV-enabled guest we have encountered the following 
> WARNING that is followed up by a BUG because we are in atomic context 
> while trying to call set_memory_decrypted:

Well, this really is a x86 / DMA API issue unfortunately.  Drivers
are allowed to do GFP_ATOMIC dma allocation under locks / rcu critical
sections and from interrupts.  And it seems like the SEV case can't
handle that.  We have some semi-generic code to have a fixed sized
pool in kernel/dma for non-coherent platforms that have similar issues
that we could try to wire up, but I wonder if there is a better way
to handle the issue, so I've added Tom and the x86 maintainers.

Now independent of that issue using DMA coherent memory for the nvme
PRPs/SGLs doesn't actually feel very optional.  We could do with
normal kmalloc allocations and just sync it to the device and back.
I wonder if we should create some general mempool-like helpers for that.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4110C410
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 07:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfK1GlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 01:41:00 -0500
Received: from verein.lst.de ([213.95.11.211]:50604 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfK1GlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:41:00 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E117D68B05; Thu, 28 Nov 2019 07:40:56 +0100 (CET)
Date:   Thu, 28 Nov 2019 07:40:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Message-ID: <20191128064056.GA19822@lst.de>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de> <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com> <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com> <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com> <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com> <20190918132242.GA16133@lst.de> <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 02:11:28PM -0800, David Rientjes wrote:
> So we're left with making dma_pool_alloc(GFP_ATOMIC) actually be atomic 
> even when the DMA needs to be unencrypted for SEV.  Christoph's suggestion 
> was to wire up dmapool in kernel/dma/remap.c for this.  Is that necessary 
> to be done for all devices that need to do dma_pool_alloc(GFP_ATOMIC) or 
> can we do it within the DMA API itself so it's transparent to the driver?

It needs to be transparent to the driver.  Lots of drivers use GFP_ATOMIC
dma allocations, and all of them are broken on SEV setups currently.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6B72772
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfGXFlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 01:41:25 -0400
Received: from verein.lst.de ([213.95.11.211]:47601 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfGXFlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:41:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 72F3D68B02; Wed, 24 Jul 2019 07:41:23 +0200 (CEST)
Date:   Wed, 24 Jul 2019 07:41:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] mm/hmm: a few more C style and comment clean ups
Message-ID: <20190724054123.GA685@lst.de>
References: <20190723233016.26403-1-rcampbell@nvidia.com> <20190723233016.26403-2-rcampbell@nvidia.com> <20190723235747.GP15331@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723235747.GP15331@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:57:52PM +0000, Jason Gunthorpe wrote:
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 16b6731a34db79..3d8cdfb67a6ab8 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -285,8 +285,9 @@ struct hmm_vma_walk {
>  	struct hmm_range	*range;
>  	struct dev_pagemap	*pgmap;
>  	unsigned long		last;
> -	bool			fault;
> -	bool			block;
> +	bool			fault : 1;
> +	bool			block : 1;
> +	bool			hugetlb : 1;

I don't think we should even keep these bools around.  I have something
like this hiding in a branche, which properly cleans much of this up:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-dma-cleanup

Notably:

http://git.infradead.org/users/hch/misc.git/commitdiff/2abdc0ac8f9f32149246957121ebccbe5c0a729d

http://git.infradead.org/users/hch/misc.git/commitdiff/a34ccd30ee8a8a3111d9e91711c12901ed7dea74

http://git.infradead.org/users/hch/misc.git/commitdiff/81f442ebac7170815af7770a1efa9c4ab662137e

This doesn't go all the way yet - the page_walk infrastructure is
built around the idea of doing its own vma lookups, and we should
eventually kill the lookup inside hmm entirely. 

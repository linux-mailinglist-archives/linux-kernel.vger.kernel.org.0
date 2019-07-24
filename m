Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E6728C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfGXHF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 03:05:58 -0400
Received: from verein.lst.de ([213.95.11.211]:48269 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfGXHF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:05:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 715E168B20; Wed, 24 Jul 2019 09:05:54 +0200 (CEST)
Date:   Wed, 24 Jul 2019 09:05:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724070553.GA2523@lst.de>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723210506.25127-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

One comment on a related cleanup:

>  	list_for_each_entry(mirror, &hmm->mirrors, list) {
>  		int rc;
>  
> -		rc = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
> +		rc = mirror->ops->sync_cpu_device_pagetables(mirror, nrange);
>  		if (rc) {
> -			if (WARN_ON(update.blockable || rc != -EAGAIN))
> +			if (WARN_ON(mmu_notifier_range_blockable(nrange) ||
> +			    rc != -EAGAIN))
>  				continue;
>  			ret = -EAGAIN;
>  			break;

This magic handling of error seems odd.  I think we should merge rc and
ret into one variable and just break out if any error happens instead
or claiming in the comments -EAGAIN is the only valid error and then
ignoring all others here.

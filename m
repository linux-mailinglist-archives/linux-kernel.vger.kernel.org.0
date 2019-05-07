Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE715E57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 09:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfEGHjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 03:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfEGHjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:39:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92B9EAEC6;
        Tue,  7 May 2019 07:39:03 +0000 (UTC)
Date:   Tue, 7 May 2019 09:39:01 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     tmurphy@arista.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] iommu/amd: fix a null-ptr-deref in map_sg()
Message-ID: <20190507073901.GC3486@suse.de>
References: <20190506164440.37399-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506164440.37399-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Mon, May 06, 2019 at 12:44:40PM -0400, Qian Cai wrote:
> The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
> iommu_map_page") added domain_flush_np_cache() in map_sg() which
> triggered a crash below during boot. sg_next() could return NULL if
> sg_is_last() is true, so after for_each_sg(sglist, s, nelems, i), "s"
> could be NULL which ends up deferencing a NULL pointer later here,
> 
> domain_flush_np_cache(domain, s->dma_address, s->dma_length);
> 
> so move domain_flush_np_cache() call inside for_each_sg() to loop over
> each sg element.

Thanks for the fix, but it is too late to merge it into the tree. I am
going to revert commit 1a1079011da3 for now and we can try again in the
next cycle.


Thanks,

	Joerg


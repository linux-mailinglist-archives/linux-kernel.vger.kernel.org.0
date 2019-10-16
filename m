Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B231D959C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 17:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394169AbfJPPbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 11:31:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfJPPbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:31:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CCA7EAC9A;
        Wed, 16 Oct 2019 15:31:14 +0000 (UTC)
Date:   Wed, 16 Oct 2019 17:31:12 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
Message-ID: <20191016153112.GF4695@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
 <1571237982.5937.60.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571237982.5937.60.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

thanks for the report!

On Wed, Oct 16, 2019 at 10:59:42AM -0400, Qian Cai wrote:
> On Wed, 2019-10-16 at 10:55 -0400, Qian Cai wrote:
> > Today's linux-next generates a lot of warnings on multiple servers during boot
> > due to the series "iommu/amd: Convert the AMD iommu driver to the dma-iommu api"
> > [1]. Reverted the whole things fixed them.
> > 
> > [1] https://lore.kernel.org/lkml/20190908165642.22253-1-murphyt7@tcd.ie/
> > 
> 
> BTW, the previous x86 warning was from only reverted one patch "iommu: Add gfp
> parameter to iommu_ops::map" where proved to be insufficient. Now, pasting the
> correct warning.

I am looking into it and may send you fixes to test.

Thanks,

	Joerg


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E3DC13A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406962AbfJRJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 05:39:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727917AbfJRJjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:39:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD41AB1F5;
        Fri, 18 Oct 2019 09:39:11 +0000 (UTC)
Date:   Fri, 18 Oct 2019 11:39:10 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
Message-ID: <20191018093910.GB26328@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
 <1571237982.5937.60.camel@lca.pw>
 <20191016154455.GG4695@suse.de>
 <1571323153.5937.67.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571323153.5937.67.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:39:13AM -0400, Qian Cai wrote:
> On Wed, 2019-10-16 at 17:44 +0200, Joerg Roedel wrote:
> > On Wed, Oct 16, 2019 at 10:59:42AM -0400, Qian Cai wrote:
> > > BTW, the previous x86 warning was from only reverted one patch "iommu: Add gfp
> > > parameter to iommu_ops::map" where proved to be insufficient. Now, pasting the
> > > correct warning.
> > 
> > Can you please test this small fix:
> 
> This works fine so far.

Thanks for testing, I queued the fix and will push it to my next branch
today.

Regards,

	Joerg

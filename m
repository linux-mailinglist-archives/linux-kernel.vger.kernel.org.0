Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646349DD93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 08:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfH0GVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 02:21:19 -0400
Received: from verein.lst.de ([213.95.11.211]:53918 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0GVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:21:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A12468AFE; Tue, 27 Aug 2019 08:21:14 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:21:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: swiotlb-xen cleanups
Message-ID: <20190827062113.GA31752@lst.de>
References: <20190816130013.31154-1-hch@lst.de> <alpine.DEB.2.21.1908261859490.3428@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908261859490.3428@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:00:44PM -0700, Stefano Stabellini wrote:
> On Fri, 16 Aug 2019, Christoph Hellwig wrote:
> > Hi Xen maintainers and friends,
> > 
> > please take a look at this series that cleans up the parts of swiotlb-xen
> > that deal with non-coherent caches.
> 
> Hi Christoph,
> 
> I just wanted to let you know that your series is on my radar, but I
> have been swamped the last few days. I hope to get to it by the end of
> the week.

Thanks, and no rush.  Note that I posted a v2 with a few significant
changes yesterday.

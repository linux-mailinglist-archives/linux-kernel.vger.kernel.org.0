Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E027A7C34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfIDHAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 03:00:38 -0400
Received: from verein.lst.de ([213.95.11.211]:36623 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfIDHAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:00:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 57523227A8A; Wed,  4 Sep 2019 09:00:33 +0200 (CEST)
Date:   Wed, 4 Sep 2019 09:00:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] swiotlb-xen: always use dma-direct helpers to
 alloc coherent pages
Message-ID: <20190904070033.GA11643@lst.de>
References: <20190902130339.23163-1-hch@lst.de> <20190902130339.23163-9-hch@lst.de> <5799ca4b-7993-b1c5-73fa-396a560f58e8@oracle.com> <8a7f9e23-ef26-e83b-8d1e-dcd7d233642a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7f9e23-ef26-e83b-8d1e-dcd7d233642a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:25:54PM -0400, Boris Ostrovsky wrote:
> > If I am reading __dma_direct_alloc_pages() correctly there is a path
> > that will force us to use GFP_DMA32 and as Juergen pointed out in
> > another message that may not be desirable.

Yes, it will add GFP_DMA32.  So I guess for now we'll just keep the
direct page allocator calls and resend.  I don't think this is the
right thing to do long term, but I'd really like to get this series
finished.

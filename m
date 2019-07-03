Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1405ED81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfGCU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:29:00 -0400
Received: from verein.lst.de ([213.95.11.211]:54906 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfGCU3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:29:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA28168B05; Wed,  3 Jul 2019 22:28:57 +0200 (CEST)
Date:   Wed, 3 Jul 2019 22:28:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 1/5] mm: return valid info from hmm_range_unregister
Message-ID: <20190703202857.GA15690@lst.de>
References: <20190703184502.16234-1-hch@lst.de> <20190703184502.16234-2-hch@lst.de> <20190703190045.GN18688@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703190045.GN18688@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:00:50PM +0000, Jason Gunthorpe wrote:
> I don't think the API should be encouraging some shortcut here..
> 
> We can't do the above pattern because the old hmm_vma API didn't allow
> it, which is presumably a reason why it is obsolete.
> 
> I'd rather see drivers move to a consistent pattern so we can then
> easily hoist the seqcount lock scheme into some common mmu notifier
> code, as discussed.

So you don't like the version in amdgpu_ttm_tt_get_user_pages_done in
linux-next either?

I can remove this and just move hmm_vma_range_done to nouveau instead.
Let me know if you have other comments before I resend.  Note that
I'll probably be offline Thu-Sun this week.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A638471D98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbfGWRXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 13:23:38 -0400
Received: from verein.lst.de ([213.95.11.211]:43461 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732675AbfGWRXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:23:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F84E68B02; Tue, 23 Jul 2019 19:23:35 +0200 (CEST)
Date:   Tue, 23 Jul 2019 19:23:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Message-ID: <20190723172335.GA2846@lst.de>
References: <20190722094426.18563-1-hch@lst.de> <20190722094426.18563-5-hch@lst.de> <20190723151824.GL15331@mellanox.com> <20190723163048.GD1655@lst.de> <20190723171731.GD15357@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723171731.GD15357@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 02:17:31PM -0300, Jason Gunthorpe wrote:
> That reminds me, this code is also leaking hmm_range_unregister() in
> the success path, right?

No, that is done by hmm_vma_range_done / nouveau_range_done for the
success path.

> 
> I think the right way to structure this is to move the goto again and
> related into the nouveau_range_fault() so the whole retry algorithm is
> sensibly self contained.

Then we'd take svmm->mutex inside the helper and let the caller
unlock that.  Either way it is a bit of a mess, and I'd rather prefer
if someone has the hardware would do a grand rewrite of this path
eventually.  Alternatively if no one signs up to mainain this code
we should eventually drop it given the staging status.

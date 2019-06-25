Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73952393
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 08:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfFYGdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 02:33:01 -0400
Received: from verein.lst.de ([213.95.11.211]:59903 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfFYGdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:33:00 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B569268B02; Tue, 25 Jun 2019 08:32:28 +0200 (CEST)
Date:   Tue, 25 Jun 2019 08:32:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
Message-ID: <20190625063228.GA29561@lst.de>
References: <20190614102126.8402-1-hch@lst.de> <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:53:55PM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Fri, Jun 14, 2019 at 12:21 PM Christoph Hellwig <hch@lst.de> wrote:
> > can you take a look at the (untested) patches below?  They convert m68k
> > to use the generic remapping DMA allocator, which is also used by
> > arm64 and csky.
> 
> Thanks. But what does this buy us?

A common dma mapping code base with everyone, including supporting
DMA allocations from atomic context, which the documentation and
API assume are there, but which don't work on m68k.

> bloat-o-meter says:
> 
> add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)

What do these values stand for?  The code should grow a little as
we now need to include the the pool allocator for the above API
fix.

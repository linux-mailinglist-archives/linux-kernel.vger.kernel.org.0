Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E767B21BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEQQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 12:34:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gfmhm1QndU1vd1KEmZzYh+ZiMXcMk0B49UsIQYdD2dY=; b=oncT9ByRFsu0LIodjLvi9FTXl
        B/LOhGID0QvmlZPRC5j2ltiGoiPdmoOFyFLY1k/V3UaaLked3INDzOiNZmLdkTHFvtvHmo4iLSSpj
        y1hqmUexfR8Qhk9mNHA+EMLMcS9HqKL5fhpZIvbNrCYJxOtPXfJt1aFxJkDlD6OLngDMoXVoh+VFQ
        GTsJ3fHQ0lx76k6yEztxe0DGZ6CVIVq4AA8jVgmVrVXMPDfuJxIt4227EKDZrwDNye969GcP3PC5W
        0sh5QzdtGZNC1dqNYRhwmJY4EUlsTVkaH7ZoEKyqb2FPxcDcqGZGGBZa7fkS/9sIQomHVg+gIWV8/
        GxFHUoq5Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRfoK-0002UT-DP; Fri, 17 May 2019 16:34:20 +0000
Date:   Fri, 17 May 2019 09:34:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon31.kim@samsung.com>, ytk.lee@samsung.com
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
Message-ID: <20190517163420.GG31704@bombadil.infradead.org>
References: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 01:02:28AM +0900, Jaewon Kim wrote:
> Hello I don't have enough knowledge on USB core but I've wondered
> why GFP_NOIO has been used in xhci_alloc_dev for
> xhci_alloc_virt_device. I found commit ("a6d940dd759b xhci: Use
> GFP_NOIO during device reset"). But can we just change GFP_NOIO
> to __GFP_RECLAIM | __GFP_FS ?

No.  __GFP_FS implies __GFP_IO; you can't set __GFP_FS and clear __GFP_IO.

It seems like the problem you have is using the CMA to do DMA allocation.
Why would you do such a thing?

> Please refer to below case.
> 
> I got a report from Lee YongTaek <ytk.lee@samsung.com> that the
> xhci_alloc_virt_device was too slow over 2 seconds only for one page
> allocation.
> 
> 1) It was because kernel version was v4.14 and DMA allocation was
> done from CMA(Contiguous Memory Allocator) where CMA region was
> almost filled with file page and  CMA passes GFP down to page
> isolation. And the page isolation only allows file page isolation only to
> requests having __GFP_FS.
> 
> 2) Historically CMA was changed at v4.19 to use GFP_KERNEL
> regardless of GFP passed to  DMA allocation through the
> commit 6518202970c1 "(mm/cma: remove unsupported gfp_mask
> parameter from cma_alloc()".
> 
> I think pre v4.19 the xhci_alloc_virt_device could be very slow
> depending on CMA situation but free to USB deadlock issue. But as of
> v4.19, I think, it will be fast but can face the deadlock issue.
> Consequently I think to meet the both cases, I think USB can pass
> __GFP_FS without __GFP_IO.
> 
> If __GFP_FS is passed from USB core, of course, the CMA patch also
> need to be changed to pass GFP.



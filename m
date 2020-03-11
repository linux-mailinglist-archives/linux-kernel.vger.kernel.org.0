Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF00181C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgCKPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:43:31 -0400
Received: from verein.lst.de ([213.95.11.211]:60055 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbgCKPna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:43:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5515F68B05; Wed, 11 Mar 2020 16:43:28 +0100 (CET)
Date:   Wed, 11 Mar 2020 16:43:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
Message-ID: <20200311154328.GA24044@lst.de>
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/> <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com> <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com> <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de> <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:34:38PM +0000, Artem S. Tashkinov wrote:
> On 3/11/20 3:24 PM, Christoph Hellwig wrote:
>> pdev->dma_mask = parent->dma_mask ? *parent->dma_mask : 0;
>
> This patch makes no difference.
>
> The kernel panics with the same call trace which starts with:

This looks really strange and not dma mask related, but there must be
some odd interactions somewhere.

Can you call gdb on the vmlinux file for the 5.5.8-200.fc31 kernel
in the jpg and then do

l *(kmem_cache_alloc_trace+0x7e)

l *(acpi_processor_add+0x3a)

and send the output?

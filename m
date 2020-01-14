Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E032213ADF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgANPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 10:47:47 -0500
Received: from verein.lst.de ([213.95.11.211]:46589 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728688AbgANPrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:47:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 547AF68AFE; Tue, 14 Jan 2020 16:47:44 +0100 (CET)
Date:   Tue, 14 Jan 2020 16:47:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] microblaze: Wire CMA allocator
Message-ID: <20200114154744.GB7194@lst.de>
References: <1a1a4c1e0f930e4fc0dfc785dbce57c07303f1a6.1579003045.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1a4c1e0f930e4fc0dfc785dbce57c07303f1a6.1579003045.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:57:28PM +0100, Michal Simek wrote:
> Based on commit 04e3543e228f ("microblaze: use the generic dma coherent remap allocator")
> CMA can be easily enabled by calling dma_contiguous_reserve() at the end of
> mmu_init(). High limit is end of lowmem space which is completely unused at
> this point of time.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Christoph: Can you please review this patch?

Looks sensible to me.  If you touch this area anyway I have a request,
though:

> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -7,6 +7,7 @@ generic-y += bugs.h
>  generic-y += compat.h
>  generic-y += device.h
>  generic-y += div64.h
> +generic-y += dma-contiguous.h

Can you add a prep patch to add a

mandatory-y += dma-contiguous.h

to include/asm-generic/Kbuild and remove the generic-y in all the
arch files?  That reduces the arch churn a little.

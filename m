Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2A52395
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfFYGdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 02:33:33 -0400
Received: from verein.lst.de ([213.95.11.211]:59906 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfFYGdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:33:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0D43868B05; Tue, 25 Jun 2019 08:33:02 +0200 (CEST)
Date:   Tue, 25 Jun 2019 08:33:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
Message-ID: <20190625063301.GB29561@lst.de>
References: <20190614102126.8402-1-hch@lst.de> <CAMuHMdUbuTc+MWqDFw=RnYxtiNQPQkzJ91KDuAQbhMq533tBCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbuTc+MWqDFw=RnYxtiNQPQkzJ91KDuAQbhMq533tBCQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:16:30AM +0200, Geert Uytterhoeven wrote:
> Doing
> 
> -       select DMA_DIRECT_REMAP if MMU && !COLDFIRE
> +       select DMA_DIRECT_REMAP if MMU && !COLDFIRE && !SUN3
> 
> in arch/m68k/Kconfig fixes the build.
> 
> Alternatively, you could use:
> 
> -       select DMA_DIRECT_REMAP if MMU && !COLDFIRE
> +       select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE

The latter might be a little cleaner.

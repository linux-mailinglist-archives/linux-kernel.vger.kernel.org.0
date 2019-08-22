Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B99891C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 03:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfHVBvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 21:51:17 -0400
Received: from verein.lst.de ([213.95.11.211]:42693 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbfHVBvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:51:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9559C68BFE; Thu, 22 Aug 2019 03:51:13 +0200 (CEST)
Date:   Thu, 22 Aug 2019 03:51:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 3/3] RISC-V: Do not invoke SBI call if cpumask is
 empty
Message-ID: <20190822015113.GC11922@lst.de>
References: <20190822004644.25829-1-atish.patra@wdc.com> <20190822004644.25829-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822004644.25829-4-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 05:46:44PM -0700, Atish Patra wrote:
> SBI calls are expensive. If cpumask is empty, there is no need to
> trap via SBI as no remote tlb flushing is required.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/tlbflush.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 9f58b3790baa..2bd3c418d769 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -21,6 +21,9 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
>  		goto issue_sfence;
>  	}
>  
> +	if (cpumask_empty(cmask))
> +		goto done;

I think this can even be done before the get_cpu to optimize it a little
further.

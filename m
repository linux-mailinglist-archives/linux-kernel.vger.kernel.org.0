Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B011A179F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfH2LBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 07:01:51 -0400
Received: from verein.lst.de ([213.95.11.211]:45200 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfH2LBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:01:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 120E168B20; Thu, 29 Aug 2019 13:01:46 +0200 (CEST)
Date:   Thu, 29 Aug 2019 13:01:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Clark <michaeljclark@mac.com>,
        Rob Herring <robh@kernel.org>, Zong Li <zong@andestech.com>
Subject: Re: [PATCH v6] RISC-V: Implement sparsemem
Message-ID: <20190829110145.GA15360@lst.de>
References: <20190828214054.3562-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828214054.3562-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 9c66033c3a54..7b0259c044c9 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -31,7 +31,7 @@ enum fixed_addresses {
>  };
> 
>  #define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
> -#define FIXADDR_TOP		(VMALLOC_START)
> +#define FIXADDR_TOP		(VMEMMAP_START)
>  #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)

Note that this actually changes again in the fixes branch that
is targeted for 5.3.  Not actually conflicting your functionality,
but the FIXADDR_TOP definition moves to pgtable.h.

Otherwise this still looks fine.

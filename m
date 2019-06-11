Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A513C844
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 12:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405265AbfFKKLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 06:11:45 -0400
Received: from foss.arm.com ([217.140.110.172]:57536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404501AbfFKKLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:11:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCF88337;
        Tue, 11 Jun 2019 03:11:44 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A4193F557;
        Tue, 11 Jun 2019 03:13:26 -0700 (PDT)
Subject: Re: [PATCH 01/17] mm: provide a print_vma_addr stub for !CONFIG_MMU
To:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190610221621.10938-1-hch@lst.de>
 <20190610221621.10938-2-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <e5827553-0924-28ee-3c8a-d29b4c01defd@arm.com>
Date:   Tue, 11 Jun 2019 11:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610221621.10938-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 11:16 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mm.h | 6 ++++++
>  1 file changed, 6 insertions(+)

FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd0b5f4e1e45..69843ee0c5f8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2756,7 +2756,13 @@ extern int randomize_va_space;
>  #endif
>  
>  const char * arch_vma_name(struct vm_area_struct *vma);
> +#ifdef CONFIG_MMU
>  void print_vma_addr(char *prefix, unsigned long rip);
> +#else
> +static inline void print_vma_addr(char *prefix, unsigned long rip)
> +{
> +}
> +#endif
>  
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
> 


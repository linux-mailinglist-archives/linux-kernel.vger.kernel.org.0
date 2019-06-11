Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5513C7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405159AbfFKJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 05:58:05 -0400
Received: from foss.arm.com ([217.140.110.172]:57064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404989AbfFKJ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:58:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193BD337;
        Tue, 11 Jun 2019 02:58:04 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4623F73C;
        Tue, 11 Jun 2019 02:59:44 -0700 (PDT)
Subject: Re: [PATCH 08/15] binfmt_flat: add endianess annotations
To:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
        linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-9-hch@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <79a2f6d9-7161-b2c7-2eb0-6719daadca8b@arm.com>
Date:   Tue, 11 Jun 2019 10:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> Most binfmt_flat on-disk fields are big endian.  Use the proper __be32
> type where applicable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/binfmt_flat.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

> 
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 6ae0f9af3fc9..6c1848dee724 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -421,7 +421,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>  	unsigned long textpos, datapos, realdatastart;
>  	u32 text_len, data_len, bss_len, stack_len, full_data, flags;
>  	unsigned long len, memp, memp_size, extra, rlim;
> -	u32 __user *reloc, *rp;
> +	__be32 __user *reloc;
> +	u32 __user *rp;
>  	struct inode *inode;
>  	int i, rev, relocs;
>  	loff_t fpos;
> @@ -594,7 +595,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>  			goto err;
>  		}
>  
> -		reloc = (u32 __user *)
> +		reloc = (__be32 __user *)
>  			(datapos + (ntohl(hdr->reloc_start) - text_len));
>  		memp = realdatastart;
>  		memp_size = len;
> @@ -619,7 +620,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>  				MAX_SHARED_LIBS * sizeof(u32),
>  				FLAT_DATA_ALIGN);
>  
> -		reloc = (u32 __user *)
> +		reloc = (__be32 __user *)
>  			(datapos + (ntohl(hdr->reloc_start) - text_len));
>  		memp = textpos;
>  		memp_size = len;
> @@ -785,15 +786,16 @@ static int load_flat_file(struct linux_binprm *bprm,
>  		u32 __maybe_unused persistent = 0;
>  		for (i = 0; i < relocs; i++) {
>  			u32 addr, relval;
> +			__be32 tmp;
>  
>  			/*
>  			 * Get the address of the pointer to be
>  			 * relocated (of course, the address has to be
>  			 * relocated first).
>  			 */
> -			if (get_user(relval, reloc + i))
> +			if (get_user(tmp, reloc + i))
>  				return -EFAULT;
> -			relval = ntohl(relval);
> +			relval = ntohl(tmp);
>  			addr = flat_get_relocate_addr(relval);
>  			rp = (u32 __user *)calc_reloc(addr, libinfo, id, 1);
>  			if (rp == (u32 __user *)RELOC_FAILED) {
> @@ -812,8 +814,13 @@ static int load_flat_file(struct linux_binprm *bprm,
>  				 * Do the relocation.  PIC relocs in the data section are
>  				 * already in target order
>  				 */
> -				if ((flags & FLAT_FLAG_GOTPIC) == 0)
> -					addr = ntohl(addr);
> +				if ((flags & FLAT_FLAG_GOTPIC) == 0) {
> +					/*
> +					 * Meh, the same value can have a different
> +					 * byte order based on a flag..
> +					 */
> +					addr = ntohl((__force __be32)addr);
> +				}
>  				addr = calc_reloc(addr, libinfo, id, 0);
>  				if (addr == RELOC_FAILED) {
>  					ret = -ENOEXEC;
> @@ -828,11 +835,10 @@ static int load_flat_file(struct linux_binprm *bprm,
>  		}
>  	} else {
>  		for (i = 0; i < relocs; i++) {
> -			u32 relval;
> +			__be32 relval;
>  			if (get_user(relval, reloc + i))
>  				return -EFAULT;
> -			relval = ntohl(relval);
> -			old_reloc(relval);
> +			old_reloc(ntohl(relval));
>  		}
>  	}
>  
> 


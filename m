Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AED8CFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHNJiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:38:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38211 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfHNJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:38:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so2240981pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WSQ8x3Kte6YBcS3BZS8foC9gRE9/UkfnKaeDUxU+eHY=;
        b=QIo/rJUuFDqHt+oiFtOQOTjviXEDmONNuz80zeXO0JMPFpycRGNgVJz+Lb/yBNCRK0
         +DBCLcoDbJ2m4YrJlnKfSN8ai1LI/TjLNBn8o7CuK5blsHmG2iv5hSNw7nt2S/Q3jDl+
         oeTJG3okbEll+vkcn8nC9mePVe4Dlyfxv/Qsv7CLhgNsnv5Qk21ZbF/opZvVL3P6NEDv
         QdeLP1ccRmDCdI8Nq48LjIaOLzCYlCPw7S9WS58oCymkYzWR++xj0EfqT+LEkTnN0HZJ
         NpnkEONIxp02WXwQx48jp+d2fZuSQShhuYb5j6CXT8vltAdoC8eT6IIBxiX21OFOpuu2
         i91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSQ8x3Kte6YBcS3BZS8foC9gRE9/UkfnKaeDUxU+eHY=;
        b=Fs8f1U78mMmYjbwOcx1O11uq9DY0asf57fG21HGZbFpxAXTskJ8xm9TpiZ40ZDVbks
         pus3gEoqTI4l55GCHq/ExXpFuYYDC5Q8U5ZdCmyS/pkTzzg487fEHfxsfNaAw1osqE5p
         6OC7xnmJFxXV476CVUovIVlFrU9JhtTyOJA4nQSnQwrhF7cQT+Nk6Zib2eKeg4iqg1I9
         rlY2nR75ab2PVTOtfKiP1QNWRwol1N3IEQTL+MvDWlRLKb/CKKYY6QSow0FzGSP+VIt2
         tbz4T49lOOP6h5klnJ8pVSxE2AxWpV4GBg2/L2RxpZMbyV86U61eWBKHhglgEdGpg+dJ
         0dwg==
X-Gm-Message-State: APjAAAWIz43ZNJUHua31O+fhkcFyxvDlAQ9+g8GCb50JM0IdLhcTx9t2
        qLadptGfT9e1Lk9uytr/X8fR1v1bt0p8Fw==
X-Google-Smtp-Source: APXvYqyiyDadkE+jXau+W2rGx8eBCE9ekVdN1MRe4+I5lCQJYgQ1k56FF8qphx4XKd+fWL94RnRxbA==
X-Received: by 2002:a63:66c5:: with SMTP id a188mr38049168pgc.127.1565775530162;
        Wed, 14 Aug 2019 02:38:50 -0700 (PDT)
Received: from [192.168.68.119] (203-219-253-117.static.tpgi.com.au. [203.219.253.117])
        by smtp.gmail.com with ESMTPSA id l31sm164137962pgm.63.2019.08.14.02.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 02:38:48 -0700 (PDT)
Subject: Re: [PATCH v9 6/7] powerpc/mce: Handle UE event for memcpy_mcsafe
To:     Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
References: <20190812092236.16648-1-santosh@fossix.org>
 <20190812092236.16648-7-santosh@fossix.org>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <d30efc87-69cb-60fe-0def-a8e2f489c320@gmail.com>
Date:   Wed, 14 Aug 2019 19:38:43 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812092236.16648-7-santosh@fossix.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/19 7:22 pm, Santosh Sivaraj wrote:
> If we take a UE on one of the instructions with a fixup entry, set nip
> to continue execution at the fixup entry. Stop processing the event
> further or print it.
> 
> Co-developed-by: Reza Arbab <arbab@linux.ibm.com>
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---

Isn't this based on https://patchwork.ozlabs.org/patch/895294/? If so it should still have my author tag and signed-off-by

Balbir Singh

>  arch/powerpc/include/asm/mce.h  |  4 +++-
>  arch/powerpc/kernel/mce.c       | 16 ++++++++++++++++
>  arch/powerpc/kernel/mce_power.c | 15 +++++++++++++--
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> index f3a6036b6bc0..e1931c8c2743 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -122,7 +122,8 @@ struct machine_check_event {
>  			enum MCE_UeErrorType ue_error_type:8;
>  			u8		effective_address_provided;
>  			u8		physical_address_provided;
> -			u8		reserved_1[5];
> +			u8		ignore_event;
> +			u8		reserved_1[4];
>  			u64		effective_address;
>  			u64		physical_address;
>  			u8		reserved_2[8];
> @@ -193,6 +194,7 @@ struct mce_error_info {
>  	enum MCE_Initiator	initiator:8;
>  	enum MCE_ErrorClass	error_class:8;
>  	bool			sync_error;
> +	bool			ignore_event;
>  };
>  
>  #define MAX_MC_EVT	100
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index a3b122a685a5..ec4b3e1087be 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -149,6 +149,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
>  		if (phys_addr != ULONG_MAX) {
>  			mce->u.ue_error.physical_address_provided = true;
>  			mce->u.ue_error.physical_address = phys_addr;
> +			mce->u.ue_error.ignore_event = mce_err->ignore_event;
>  			machine_check_ue_event(mce);
>  		}
>  	}
> @@ -266,8 +267,17 @@ static void machine_process_ue_event(struct work_struct *work)
>  		/*
>  		 * This should probably queued elsewhere, but
>  		 * oh! well
> +		 *
> +		 * Don't report this machine check because the caller has a
> +		 * asked us to ignore the event, it has a fixup handler which
> +		 * will do the appropriate error handling and reporting.
>  		 */
>  		if (evt->error_type == MCE_ERROR_TYPE_UE) {
> +			if (evt->u.ue_error.ignore_event) {
> +				__this_cpu_dec(mce_ue_count);
> +				continue;
> +			}
> +
>  			if (evt->u.ue_error.physical_address_provided) {
>  				unsigned long pfn;
>  
> @@ -301,6 +311,12 @@ static void machine_check_process_queued_event(struct irq_work *work)
>  	while (__this_cpu_read(mce_queue_count) > 0) {
>  		index = __this_cpu_read(mce_queue_count) - 1;
>  		evt = this_cpu_ptr(&mce_event_queue[index]);
> +
> +		if (evt->error_type == MCE_ERROR_TYPE_UE &&
> +		    evt->u.ue_error.ignore_event) {
> +			__this_cpu_dec(mce_queue_count);
> +			continue;
> +		}
>  		machine_check_print_event_info(evt, false, false);
>  		__this_cpu_dec(mce_queue_count);
>  	}
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index e74816f045f8..1dd87f6f5186 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/ptrace.h>
> +#include <linux/extable.h>
>  #include <asm/mmu.h>
>  #include <asm/mce.h>
>  #include <asm/machdep.h>
> @@ -18,6 +19,7 @@
>  #include <asm/pte-walk.h>
>  #include <asm/sstep.h>
>  #include <asm/exception-64s.h>
> +#include <asm/extable.h>
>  
>  /*
>   * Convert an address related to an mm to a physical address.
> @@ -559,9 +561,18 @@ static int mce_handle_derror(struct pt_regs *regs,
>  	return 0;
>  }
>  
> -static long mce_handle_ue_error(struct pt_regs *regs)
> +static long mce_handle_ue_error(struct pt_regs *regs,
> +				struct mce_error_info *mce_err)
>  {
>  	long handled = 0;
> +	const struct exception_table_entry *entry;
> +
> +	entry = search_kernel_exception_table(regs->nip);
> +	if (entry) {
> +		mce_err->ignore_event = true;
> +		regs->nip = extable_fixup(entry);
> +		return 1;
> +	}
>  
>  	/*
>  	 * On specific SCOM read via MMIO we may get a machine check
> @@ -594,7 +605,7 @@ static long mce_handle_error(struct pt_regs *regs,
>  				&phys_addr);
>  
>  	if (!handled && mce_err.error_type == MCE_ERROR_TYPE_UE)
> -		handled = mce_handle_ue_error(regs);
> +		handled = mce_handle_ue_error(regs, &mce_err);
>  
>  	save_mce_event(regs, handled, &mce_err, regs->nip, addr, phys_addr);
>  
> 

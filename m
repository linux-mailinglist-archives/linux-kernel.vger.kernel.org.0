Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6B150352
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 10:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBCJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 04:25:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38655 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:25:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so16986611wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F9yu2wtiNO9AUs6nrKy2by5yqmhTTOqT7fKPke38AkA=;
        b=IrJckNU3TBy2Ho2bFZT/sDmmNA89gz9uNI1I08zCGhFGKvXfO4vweB2nmJSN5YsKsz
         9/zJJ1M89N6Mvjz0m9hDX3GK2ebobSvAi+TWW/29be5h1rnJrgTH7yy4vAPfdX3fw0nm
         mzz4HtL4SiBvNNpfhiK8hYs9RMM/Z+fK1ne0EPb6sRkkyby4laEWtx9aiL5EhWDncZef
         PtzeS10ymMQlChGaOeTgMZw4sdLkSmSxPnPI4Y+q0cv1GQJs//H6UCIilrAldZSSaCRE
         87nn70bfkP2KB/hg/MAnp/gqTRkrkPLgTts/3thKG2qc1Ms7U5o0stuV6NzswbnVctbu
         lhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9yu2wtiNO9AUs6nrKy2by5yqmhTTOqT7fKPke38AkA=;
        b=dps2+si9Y/4u5ekkQb5/3utAYiLlMOU/zs+EQhAqW/n92qkgfjDs7FlkFwpoPaciXe
         J6wDy8T4D8k91AW3yvK6qe4Sk/hkxA/wzanVY7l/DmdbFFQOMPL7gE6pWrp429sZk/I4
         uU311i9alt2Vm/2pyU3CdZE6B4+yDUVd3c0elSBPFMblDWpaBec9ZeL1MF5Kngcf+fEa
         zywSdRtdL6vI/p3o8XwsBQ3xislJoX6fwSAyLZkeXNpFxZVu9MnrNsr1LNdrgNRxs/ks
         AM0vFkCCVVgwIWKaQNerKDUO5bM3Pv/om22mMlrzzkP62gZMeo+SkgCvLJpG9ecOQKoF
         sJqg==
X-Gm-Message-State: APjAAAUuBidXxbbsx3ROaYBF/eiVPUHfUniTzx9K62C0QlT6S2b6jxz5
        f/sn4RhhQZK1OU05vlEdllXbcw==
X-Google-Smtp-Source: APXvYqxMp3Ck8IjM3P3+ox8B3yR/DSErPTTa6J5xqFm1bMcpTRQZ39Yvj8v9HY3lGBV2CsuW0xEyMw==
X-Received: by 2002:adf:f787:: with SMTP id q7mr11348594wrp.297.1580721928632;
        Mon, 03 Feb 2020 01:25:28 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:459c:4174:f0ee:1b26])
        by smtp.gmail.com with ESMTPSA id b18sm24549847wru.50.2020.02.03.01.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:25:27 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:25:25 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH v2 1/3] PCI: hv: Move hypercall related definitions into
 tlfs header
Message-ID: <20200203092525.GC20189@big-machine>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
 <20200203050313.69247-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203050313.69247-2-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 01:03:11PM +0800, Boqun Feng wrote:
> Currently HVCALL_RETARGET_INTERRUPT and HV_PARTITION_ID_SELF are defined
> in pci-hyperv.c. However, similar to other hypercall related definitions
> , it makes more sense to put them in the tlfs header file.

Nit: please keep the comma attached to the previous word - even if that
means you need to move the word with it to the next line to maintain line
limits.

> 
> Besides, these definitions are arch-dependent, so for the support of
> virtual PCI on non-x86 archs in the future, move them into arch-specific
> tlfs header file.
> 
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h  | 3 +++
>  drivers/pci/controller/pci-hyperv.c | 6 ------
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 5f10f7f2098d..739bd89226a5 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -376,6 +376,7 @@ struct hv_tsc_emulation_status {
>  #define HVCALL_SEND_IPI_EX			0x0015
>  #define HVCALL_POST_MESSAGE			0x005c
>  #define HVCALL_SIGNAL_EVENT			0x005d
> +#define HVCALL_RETARGET_INTERRUPT		0x007e
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  
> @@ -405,6 +406,8 @@ enum HV_GENERIC_SET_FORMAT {
>  	HV_GENERIC_SET_ALL,
>  };
>  
> +#define HV_PARTITION_ID_SELF                    ((u64)-1)
> +
>  #define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
>  #define HV_HYPERCALL_FAST_BIT		BIT(16)
>  #define HV_HYPERCALL_VARHEAD_OFFSET	17
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 9977abff92fc..aacfcc90d929 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -406,12 +406,6 @@ struct pci_eject_response {
>  
>  static int pci_ring_size = (4 * PAGE_SIZE);
>  
> -/*
> - * Definitions or interrupt steering hypercall.
> - */
> -#define HV_PARTITION_ID_SELF		((u64)-1)
> -#define HVCALL_RETARGET_INTERRUPT	0x7e
> -

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

>  struct hv_interrupt_entry {
>  	u32	source;			/* 1 for MSI(-X) */
>  	u32	reserved1;
> -- 
> 2.24.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

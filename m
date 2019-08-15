Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70F98EB67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 14:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfHOMVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 08:21:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42504 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfHOMVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:21:38 -0400
Received: from zn.tnic (p200300EC2F0B52007D93C58FB2CAB236.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:7d93:c58f:b2ca:b236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E9CB1EC0959;
        Thu, 15 Aug 2019 14:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565871697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sSqvyUYtkx7/uZDnZ8n7rcur6vuPwhqq0uRXZCz9+qw=;
        b=W68dUmDbR7fJiGHQQGnj6fj4bwKWSiLxvTqJARyFPJdiw6vqINoskwOWPvjZLSRTnZGnDs
        8+vaG3mWp/LbpyItG+reLta34MRA4btIOZhcftJ+E7HckEpWjy1ZAxrlnWOXEtW7kmV22l
        DgwQSV+PnPMlc1GJ6KPg8c8U4T4aV/Q=
Date:   Thu, 15 Aug 2019 14:22:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, andriy.shevchenko@intel.com, alan@linux.intel.com,
        ricardo.neri-calderon@linux.intel.com, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Subject: Re: [PATCH 2/3] x86: cpu: Add new Intel Atom CPU type
Message-ID: <20190815122222.GE15313@zn.tnic>
References: <cover.1565856842.git.rahul.tanwar@linux.intel.com>
 <16de4480ae1216d5949d4d36787811dae35d2eff.1565856842.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16de4480ae1216d5949d4d36787811dae35d2eff.1565856842.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 05:46:46PM +0800, Rahul Tanwar wrote:
> This patch adds a new variant of Intel Atom Airmont CPU model used in a
> network processor SoC named Lightning Mountain.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 0278aa66ef62..cbbb8250370f 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -73,6 +73,7 @@
>  
>  #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* Cherry Trail, Braswell */
>  #define INTEL_FAM6_ATOM_AIRMONT_MID	0x5A /* Moorefield */
> +#define INTEL_FAM6_ATOM_AIRMONT_NP	0x75 /* Lightning Mountain */
>  
>  #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
>  #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
> -- 

Also, in addition to what Thomas said, due to the fact that all the
different groups within Intel are sending patches with model names,
please synchronize that model naming and patch sending with Tony from
now on:

https://git.kernel.org/tip/5ed1c835ed8b522ce25071cc2d56a9a09bd5b59e

He'll document the naming scheme and pay attention to what goes where so
make sure you CC him, talk to him or have him in the loop, in general.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

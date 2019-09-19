Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8FB7F40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 18:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbfISQgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 12:36:50 -0400
Received: from foss.arm.com ([217.140.110.172]:33858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbfISQgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:36:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 683B228;
        Thu, 19 Sep 2019 09:36:49 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0C8F3F575;
        Thu, 19 Sep 2019 09:36:46 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:36:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jia He <justin.he@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v5 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Message-ID: <20190919163644.GD6472@arrakis.emea.arm.com>
References: <20190919161204.142796-1-justin.he@arm.com>
 <20190919161204.142796-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919161204.142796-2-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 12:12:02AM +0800, Jia He wrote:
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index b1fdc486aed8..fb0e9425d286 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1141,6 +1141,16 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
>  	return true;
>  }
>  
> +/* Decouple AF from AFDBM. */
> +bool cpu_has_hw_af(void)
> +{
> +	return (read_cpuid(ID_AA64MMFR1_EL1) & 0xf);
> +}
> +#else /* CONFIG_ARM64_HW_AFDBM */
> +bool cpu_has_hw_af(void)
> +{
> +	return false;
> +}
>  #endif

Please place this function in cpufeature.h directly, no need for an
additional function call. Something like:

static inline bool cpu_has_hw_af(void)
{
	if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
		return read_cpuid(ID_AA64MMFR1_EL1) & 0xf;
	return false;
}

-- 
Catalin

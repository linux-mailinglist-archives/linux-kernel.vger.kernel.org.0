Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57819578C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 13:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgC0Mz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 08:55:26 -0400
Received: from foss.arm.com ([217.140.110.172]:44294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0Mz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:55:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E1C7FA;
        Fri, 27 Mar 2020 05:55:26 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B2AF3F71F;
        Fri, 27 Mar 2020 05:55:25 -0700 (PDT)
Date:   Fri, 27 Mar 2020 12:55:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: Kconfig: ptrauth: Add binutils version check
 to fix mismatch
Message-ID: <20200327125522.GB18117@mbp>
References: <1585236720-21819-1-git-send-email-amit.kachhap@arm.com>
 <1585236720-21819-2-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585236720-21819-2-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:02:00PM +0530, Amit Daniel Kachhap wrote:
> Recent addition of ARM64_PTR_AUTH exposed a mismatch issue with binutils.
> 9.1+ versions of gcc inserts a section note .note.gnu.property but this
> can be used properly by binutils version greater than 2.33.1. If older
> binutils are used then the following warnings are generated,
> 
> aarch64-linux-ld: warning: arch/arm64/kernel/vdso/vgettimeofday.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
> aarch64-linux-objdump: warning: arch/arm64/lib/csum.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
> aarch64-linux-nm: warning: .tmp_vmlinux1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
> 
> This patch enables ARM64_PTR_AUTH when gcc and binutils versions are
> compatible with each other. Older gcc which do not insert such section
> continue to work as before.
> 
> This scenario may not occur with clang as a recent commit 3b446c7d27ddd06
> ("arm64: Kconfig: verify binutils support for ARM64_PTR_AUTH") masks
> binutils version lesser then 2.34.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e6712b6..73135da 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1503,7 +1503,7 @@ config ARM64_PTR_AUTH
>  	default y
>  	depends on !KVM || ARM64_VHE
>  	depends on (CC_HAS_SIGN_RETURN_ADDRESS || CC_HAS_BRANCH_PROT_PAC_RET) && AS_HAS_PAC
> -	depends on CC_IS_GCC || (CC_IS_CLANG && AS_HAS_CFI_NEGATE_RA_STATE)
> +	depends on (CC_IS_GCC && (GCC_VERSION < 90100 || LD_VERSION >= 233010000)) || (CC_IS_CLANG && AS_HAS_CFI_NEGATE_RA_STATE)

We should add some of the comments in the commit log to the Kconfig
entry. I would also split this in two (equivalent to CC_IS_ implies):

	depends on !CC_IS_GCC || GCC_VERSION < 90100 || LD_VERSION >= 233010000
	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE

and add a comment above the gcc/ld version checking.

(not entirely identical to the original if CC is neither of them but I
don't think we have this problem)

-- 
Catalin

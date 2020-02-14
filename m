Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D18515D0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 05:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBNEXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 23:23:31 -0500
Received: from foss.arm.com ([217.140.110.172]:56636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgBNEXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:23:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 992601FB;
        Thu, 13 Feb 2020 20:23:30 -0800 (PST)
Received: from [10.162.16.95] (p8cg001049571a15.blr.arm.com [10.162.16.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9E03F6CF;
        Thu, 13 Feb 2020 20:23:28 -0800 (PST)
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <45ce930c-81b3-3161-ced6-34a8c8623ac8@arm.com>
Date:   Fri, 14 Feb 2020 09:53:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/28/2020 06:09 PM, Anshuman Khandual wrote:
> This series is primarily motivated from an adhoc list from Mark Rutland
> during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
> which does macro replacement for various open bits shift encodings in
> various CPU ID registers. This series is based on linux-next 20200124.
> 
> [1] https://patchwork.kernel.org/patch/11287805/
> 
> Is there anything else apart from these changes which can be accommodated
> in this series, please do let me know. Thank you.

Just a gentle ping. Any updates, does this series looks okay ? Is there
anything else related to CPU ID register feature bits, which can be added
up here. FWIW, the series still applies on v5.6-rc1.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (6):
>   arm64/cpufeature: Introduce ID_PFR2 CPU register
>   arm64/cpufeature: Add DIT and CSV2 feature bits in ID_PFR0 register
>   arm64/cpufeature: Add remaining feature bits in ID_MMFR4 register
>   arm64/cpufeature: Define an explicit ftr_id_isar0[] for ID_ISAR0 register
>   arm64/cpufeature: Drop TraceFilt feature exposure from ID_DFR0 register
>   arm64/cpufeature: Replace all open bits shift encodings with macros
> 
>  arch/arm64/include/asm/cpu.h    |  1 +
>  arch/arm64/include/asm/sysreg.h | 51 +++++++++++++++++++
>  arch/arm64/kernel/cpufeature.c  | 87 ++++++++++++++++++++++-----------
>  arch/arm64/kernel/cpuinfo.c     |  1 +
>  arch/arm64/kvm/sys_regs.c       |  2 +-
>  5 files changed, 112 insertions(+), 30 deletions(-)
> 

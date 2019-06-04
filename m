Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A323451A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfFDLMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 07:12:36 -0400
Received: from foss.arm.com ([217.140.101.70]:40454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfFDLMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:12:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E61280D;
        Tue,  4 Jun 2019 04:12:36 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC0753F690;
        Tue,  4 Jun 2019 04:12:33 -0700 (PDT)
Date:   Tue, 4 Jun 2019 12:12:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH v5 2/3] arch/arm64: fpsimd: Introduce
 fpsimd_save_and_flush_cpu_state() and use it
Message-ID: <20190604111230.GA5668@arrakis.emea.arm.com>
References: <20190521172139.21277-1-julien.grall@arm.com>
 <20190521172139.21277-3-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521172139.21277-3-julien.grall@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 06:21:38PM +0100, Julien Grall wrote:
> The only external user of fpsimd_save() and fpsimd_flush_cpu_state() is
> the KVM FPSIMD code.
> 
> A following patch will introduce a mechanism to acquire owernship of the
> FPSIMD/SVE context for performing context management operations. Rather
> than having to export the new helpers to get/put the context, we can just
> introduce a new function to combine fpsimd_save() and
> fpsimd_flush_cpu_state().
> 
> This has also the advantage to remove any external call of fpsimd_save()
> and fpsimd_flush_cpu_state(), so they can be turned static.
> 
> Lastly, the new function can also be used in the PM notifier.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
[...]
> ---
>  arch/arm64/include/asm/fpsimd.h |  4 +---
>  arch/arm64/kernel/fpsimd.c      | 17 +++++++++++++----
>  arch/arm64/kvm/fpsimd.c         |  4 +---
>  3 files changed, 15 insertions(+), 10 deletions(-)

Marc, since this touches KVM, can I get an ack on this patch? I plan to
queue the series.

Thanks.

-- 
Catalin

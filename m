Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01173146F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAWREi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 12:04:38 -0500
Received: from foss.arm.com ([217.140.110.172]:42396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbgAWREh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:04:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29D911FB;
        Thu, 23 Jan 2020 09:04:35 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B73E3F6C4;
        Thu, 23 Jan 2020 09:04:33 -0800 (PST)
Subject: Re: [PATCH v2 2/6] arm64: trap to EL1 accesses to AMU counters from
 EL0
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Capper <steve.capper@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-3-ionela.voinescu@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <dcecb179-02f1-0608-6a84-5b2dd0bbcdb3@arm.com>
Date:   Thu, 23 Jan 2020 17:04:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218182607.21607-3-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 18:26, Ionela Voinescu wrote:
> +/*
> + * reset_amuserenr_el0 - reset AMUSERENR_EL0 if AMUv1 present
> + */
> +	.macro	reset_amuserenr_el0, tmpreg
> +	mrs	\tmpreg, id_aa64pfr0_el1	// Check ID_AA64PFR0_EL1
> +	ubfx	\tmpreg, \tmpreg, #ID_AA64PFR0_AMU_SHIFT, #4
> +	cbz	\tmpreg, 9000f			// Skip if no AMU present
> +	msr_s	SYS_AMUSERENR_EL0, xzr		// Disable AMU access from EL0
> +9000:

AIUI you can steer away from the obscure numbering scheme and define the
label using the macro counter:

	cbz \tmpreg, .Lskip_\@
	[...]
.Lskip_\@:
	.endm


> +	.endm

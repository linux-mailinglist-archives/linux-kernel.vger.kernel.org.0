Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924C735C25
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfFEL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 07:56:49 -0400
Received: from foss.arm.com ([217.140.101.70]:58572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfFEL4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:56:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9A5480D;
        Wed,  5 Jun 2019 04:56:48 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DEAB3F5AF;
        Wed,  5 Jun 2019 04:56:47 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:56:44 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com
Subject: Re: [PATCH 2/3] arm64: arch_timer: mark functions as __always_inline
Message-ID: <20190605115644.GF15030@fuggles.cambridge.arm.com>
References: <20190603091402.25115-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603091402.25115-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 11:14:02AM +0200, Anders Roxell wrote:
> If CONFIG_FUNCTION_GRAPH_TRACER is enabled function
> arch_counter_get_cntvct() is marked as notrace. However, function
> __arch_counter_get_cntvct is marked as inline. If
> CONFIG_OPTIMIZE_INLINING is set that will make the two functions
> tracable which they shouldn't.
> 
> Rework so that functions __arch_counter_get_* are marked with
> __always_inline so they will be inlined even if CONFIG_OPTIMIZE_INLINING
> is turned on.
> 
> Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable counters")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/include/asm/arch_timer.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I can pick this up if Marc is happy with it.

Will

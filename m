Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1081151990
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfFXRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 13:30:13 -0400
Received: from foss.arm.com ([217.140.110.172]:55464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFXRaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:30:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75C6B360;
        Mon, 24 Jun 2019 10:30:12 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90D43F718;
        Mon, 24 Jun 2019 10:30:10 -0700 (PDT)
Date:   Mon, 24 Jun 2019 18:30:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 2/4] x86/entry: Simplify _TIF_SYSCALL_EMU handling
Message-ID: <20190624173008.GJ29120@arrakis.emea.arm.com>
References: <20190523090618.13410-3-sudeep.holla@arm.com>
 <20190611145627.23229-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611145627.23229-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:56:27PM +0100, Sudeep Holla wrote:
> The usage of emulated and _TIF_SYSCALL_EMU flags in syscall_trace_enter
> is more complicated than required.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/x86/entry/common.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> Hi Catalin,
> 
> I assume you can now pick up this patch.

I can, unless Thomas picks it up through the tip tree (there is no
dependency on the other patches in this series, which I already queued
via arm64).

-- 
Catalin

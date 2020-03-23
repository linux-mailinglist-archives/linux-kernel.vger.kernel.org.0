Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEA18F42A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCWMOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:14:43 -0400
Received: from foss.arm.com ([217.140.110.172]:48018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgCWMOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:14:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 463A51FB;
        Mon, 23 Mar 2020 05:14:42 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A19193F52E;
        Mon, 23 Mar 2020 05:14:40 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:14:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200323121437.GC2597@C02TD0UTHF1T.local>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
 <20200319091407.51449-1-remi@remlab.net>
 <20200323120700.GB2597@C02TD0UTHF1T.local>
 <2345780.q8flsOIESp@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2345780.q8flsOIESp@basile.remlab.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:08:53PM +0200, Rémi Denis-Courmont wrote:
> Le maanantaina 23. maaliskuuta 2020, 14.07.00 EET Mark Rutland a écrit :
> > On Thu, Mar 19, 2020 at 11:14:05AM +0200, Rémi Denis-Courmont wrote:
> > > From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > 
> > > This switches from custom instruction patterns to the regular large
> > > memory model sequence with ADRP and LDR. In doing so, the ADD
> > > instruction can be eliminated in the SDEI handler, and the code no
> > > longer assumes that the trampoline vectors and the vectors address both
> > > start on a page boundary.
> > > 
> > > Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > ---
> > > 
> > >  arch/arm64/kernel/entry.S | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > > index e5d4e30ee242..24f828739696 100644
> > > --- a/arch/arm64/kernel/entry.S
> > > +++ b/arch/arm64/kernel/entry.S
> > > @@ -805,9 +805,9 @@ alternative_else_nop_endif
> > > 
> > >  2:
> > >  	tramp_map_kernel	x30
> > >  
> > >  #ifdef CONFIG_RANDOMIZE_BASE
> > > 
> > > -	adr	x30, tramp_vectors + PAGE_SIZE
> > > +	adrp	x30, tramp_vectors + PAGE_SIZE
> > > 
> > >  alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
> > > 
> > > -	ldr	x30, [x30]
> > > +	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
> > 
> > I think this is busted for !4K kernels once we reduce the alignment of
> > __entry_tramp_data_start.
> > 
> > The ADRP gives us a 64K aligned address (with bits 15:0 clear). The lo12
> > relocation gives us bits 11:0, so we haven't accounted for bits 15:12.
> 
> IMU, ADRP gives a 4K aligned value, regardless of MMU (TCR) settings.

Sorry, I had erroneously assumed tramp_vectors was page aligned. The
issue still stands -- we haven't accounted for bits 15:12, as those can
differ between tramp_vectors and __entry_tramp_data_start.

Thanks,
Mark.

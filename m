Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D14B329
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 09:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfFSHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 03:36:08 -0400
Received: from foss.arm.com ([217.140.110.172]:53664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSHgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:36:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14CB6344;
        Wed, 19 Jun 2019 00:36:07 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103953F246;
        Wed, 19 Jun 2019 00:36:05 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:36:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, joel@sing.id.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RISC-V: Break load reservations during switch_to
Message-ID: <20190619073600.GA29918@lakrids.cambridge.arm.com>
References: <20190607222222.15300-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607222222.15300-1-palmer@sifive.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 03:22:22PM -0700, Palmer Dabbelt wrote:
> The comment describes why in detail.  This was found because QEMU never
> gives up load reservations, the issue is unlikely to manifest on real
> hardware.
> 
> Thanks to Carlos Eduardo for finding the bug!

> @@ -330,6 +330,17 @@ ENTRY(__switch_to)
>  	add   a3, a0, a4
>  	add   a4, a1, a4
>  	REG_S ra,  TASK_THREAD_RA_RA(a3)
> +	/*
> +	 * The Linux ABI allows programs to depend on load reservations being
> +	 * broken on context switches, but the ISA doesn't require that the
> +	 * hardware ever breaks a load reservation.  The only way to break a
> +	 * load reservation is with a store conditional, so we emit one here.
> +	 * Since nothing ever takes a load reservation on TASK_THREAD_RA_RA we
> +	 * know this will always fail, but just to be on the safe side this
> +	 * writes the same value that was unconditionally written by the
> +	 * previous instruction.
> +	 */

I suspect that you need to do the same as 32-bit ARM, and clear this in
your exception return path, rather than in __switch_to, since handlers
for interrupts and other exceptions could leave a dangling reservation.

For ARM, the architecture permits a store-exclusive to succeed even if
the address differed from the load-exclusive. I don't know if the same
applies here, but regardless I believe the case above applies if an IRQ
is taken from kernel context, since the handler can manipulate the same
variable as the interrupted code.

Thanks,
Mark.

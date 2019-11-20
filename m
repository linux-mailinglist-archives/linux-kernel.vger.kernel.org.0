Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D41046A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfKTWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 17:34:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59072 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKTWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:34:13 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXYY7-00007z-LA; Wed, 20 Nov 2019 23:34:11 +0100
Date:   Wed, 20 Nov 2019 23:34:10 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexander Duyck <alexander.duyck@gmail.com>
cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org
Subject: Re: [x86/iopl PATCH] x86/ioperm: Fix use of deprecated config
 option
In-Reply-To: <20191120222426.3060.18462.stgit@localhost.localdomain>
Message-ID: <alpine.DEB.2.21.1911202333190.29534@nanos.tec.linutronix.de>
References: <157390508218.12247.10003209681229427208.tip-bot2@tip-bot2> <20191120222426.3060.18462.stgit@localhost.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Fixes: 111e7b15cf10 ("x86/ioperm: Extend IOPL config to control ioperm() as well")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Duh, yes. 

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/kernel/process.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 7964d7db9366..bd2a11ca5dd6 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -382,8 +382,7 @@ void tss_update_io_bitmap(void)
>  	if (test_thread_flag(TIF_IO_BITMAP)) {
>  		struct thread_struct *t = &current->thread;
>  
> -		if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION) &&
> -		    t->iopl_emul == 3) {
> +		if (IS_ENABLED(CONFIG_X86_IOPL_IOPERM) && t->iopl_emul == 3) {
>  			*base = IO_BITMAP_OFFSET_VALID_ALL;
>  		} else {
>  			struct io_bitmap *iobm = t->io_bitmap;
> 
> 

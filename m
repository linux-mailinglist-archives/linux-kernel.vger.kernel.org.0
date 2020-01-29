Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA014D244
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 22:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgA2VFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 16:05:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbgA2VFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:05:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B058CAD85;
        Wed, 29 Jan 2020 21:05:45 +0000 (UTC)
Date:   Wed, 29 Jan 2020 22:05:43 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/process: Remove unneccessary #ifdef CONFIG_PPC64
 in copy_thread_tls()
Message-ID: <20200129210543.GH4113@kitsune.suse.cz>
References: <6ecbda05b4119c40222dc8ec284604e1597c9bff.1580327381.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecbda05b4119c40222dc8ec284604e1597c9bff.1580327381.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:50:07PM +0000, Christophe Leroy wrote:
> is_32bit_task() exists on both PPC64 and PPC32, no need of an ifdefery.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/process.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index fad50db9dcf2..e730b8e522b0 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1634,11 +1634,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
>  		p->thread.regs = childregs;
>  		childregs->gpr[3] = 0;  /* Result from fork() */
>  		if (clone_flags & CLONE_SETTLS) {
> -#ifdef CONFIG_PPC64
>  			if (!is_32bit_task())
>  				childregs->gpr[13] = tls;
>  			else
> -#endif
>  				childregs->gpr[2] = tls;
>  		}
>  

Reviewed-by: Michal Suchanek <msuchanek@suse.de>

Thanks

Michal

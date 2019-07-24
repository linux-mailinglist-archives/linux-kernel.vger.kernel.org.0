Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CB72B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfGXJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 05:31:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45146 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfGXJbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:31:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so40585351eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nEkTF+cqPf/v2CMmPE5u5s1dVQ6nE3Sqg5k1QdIwMS4=;
        b=ekczK6N+BR0shxexBKgIZQ4TSWiAI9mE07FsYpvO4oyWt/i9GexLYk7EoZdy3iwKRH
         g+BuyeJawN4iS6909W2c6JtM2AxtdiJqQwpEE6HgpKRVjB3HwNu/UJuYiuwmMsT4OeZ3
         utiMHUgGTNB0iP3G7lzOJC3WRUUNkHkvh+mZ5OVbYoSagg2/TJ3jJALK5iNmhoUYOjM3
         NlRHa50acd36Wqrh942AmrQvBqL4C6La4S3p+HLy5ZsMHdz2yjJCnNm6DnX8UXJUqczg
         1+moIY35SUyBEgDtu3qCiaB7G/oO3cpq8g2j8bOv5LFImmEt7ZNpK8b1M/VXvUkU3lAc
         u1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nEkTF+cqPf/v2CMmPE5u5s1dVQ6nE3Sqg5k1QdIwMS4=;
        b=iI6N0eoZvP7A+ctQIo5KCGZVEVam3Ily1M76yGWGASzMkF2SCF/67SWM2WUW2i7QMQ
         +GzKFuhbDCbN5z++RDGtOREC+XpoyjXSVzWTEMXV2k5FiVco1P3dgdf0wUKSbKXYmJ/s
         VshcyLehPFHiCkhxbNTP6rAm3OJTSt8aTlrSEwePBEMit1odLDi1/7E/2u2/l8FGnYYa
         KKXdbcprylK2FsszoBEfdkuyHOBEstslQRJDZjMFBM1ypoX3VzlsTtVKvfOf7CsdPrzv
         rxrfQlVQ4JOhYb81B2yBKV4GcwFL9i8ZoB1ZFhsx9HF3NzW6eGtiPnqr2FZxSTuopTEy
         SDpA==
X-Gm-Message-State: APjAAAUWZj60KaCRLMHXeiGqjjSJWvzPbhyHp3n2K0ZwhaEm1w3YAd+x
        clCX1d+Qfdi31yiklQainwU=
X-Google-Smtp-Source: APXvYqwgJ29U2DdS0WD8cMY2jrFDebelcceKx3kTwHiFfem/dqd2jhAjcifGI4qRDD5QHt9HaLW/oQ==
X-Received: by 2002:a17:906:3612:: with SMTP id q18mr63278352ejb.278.1563960695291;
        Wed, 24 Jul 2019 02:31:35 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id l35sm12571254edc.2.2019.07.24.02.31.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 02:31:34 -0700 (PDT)
Date:   Wed, 24 Jul 2019 11:31:34 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arseny Solokha <asolokha@kb.kras.ru>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc: Wire up clone3 syscall
Message-ID: <20190724093132.orflnhvyiff75yrd@brauner.io>
References: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
 <87ftmwknr9.fsf@kb.kras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftmwknr9.fsf@kb.kras.ru>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:25:14PM +0700, Arseny Solokha wrote:
> Hi,
> 
> may I also ask to provide ppc_clone3 symbol also for 32-bit powerpc? Otherwise
> Michael's patch breaks build for me:

Makes sense. Michael, are you planning on picking this up? :)

Christian

> 
>   powerpc-e500v2-linux-gnuspe-ld: arch/powerpc/kernel/systbl.o: in function `sys_call_table':
>   (.rodata+0x6cc): undefined reference to `ppc_clone3'
>   make: *** [Makefile:1060: vmlinux] Error 1
> 
> The patch was tested using Christian's program on a real e500 machine.
> 
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -597,6 +597,14 @@ ppc_clone:
>  	stw	r0,_TRAP(r1)		/* register set saved */
>  	b	sys_clone
> 
> +	.globl	ppc_clone3
> +ppc_clone3:
> +	SAVE_NVGPRS(r1)
> +	lwz	r0,_TRAP(r1)
> +	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
> +	stw	r0,_TRAP(r1)		/* register set saved */
> +	b	sys_clone3
> +
>  	.globl	ppc_swapcontext
>  ppc_swapcontext:
>  	SAVE_NVGPRS(r1)
> 
> I don't think this trivial hunk deserves a separate patch submission.
> 
> Thanks,
> Arseny

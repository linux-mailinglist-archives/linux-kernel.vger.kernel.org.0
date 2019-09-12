Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EF5B0867
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfILFnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 01:43:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41191 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfILFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 01:43:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so25951293wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 22:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WMphAgSBPHIKk4SYSy5DiphCnKasXaVbpOhSBFsQlZM=;
        b=eoTwfksJpQP/aJRoNnP2I9L/oxf3rt3+WUiVHu018iFRgwNVhSNaUJpczvueG0VVpT
         5UEajxPI1yyue6jILtHZ4Kq5JOv9RXWRwYs15GdqZnOPsvDSa0f5yVHZ7Oo+O5aXi26m
         oQq7bwa9VoCOJF8JJKk4SjzgOBDJo8oP18VvIm2DTTr8LiwkPxPmVDTgtfSQ7FJQtLBK
         SGMEj3OK2F0Om8P6F4VnepcY1ikk45GKvDALgQjx1815zBpUrFtUa/TvWVNAy0lgINtc
         ax8vt0u8nqR2rWCzu8I6d+CP/bhYa86aqRoue8PpNtZDlCpYbWeyeIWu+YeL+ZLTLFdR
         ZU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WMphAgSBPHIKk4SYSy5DiphCnKasXaVbpOhSBFsQlZM=;
        b=ic+3aDA3rADDAhf5iOUR7YQEg8c3btGhS1oUlsEDrrXZzRf7bcOoGC6G8USeHfZ8on
         GbqDbTeecmUXaSec3jfWmLn5foQT6LcM3YeANLafz7Mt3T37hKkacoCg27W+gT1UdhyT
         FoTdmU8YhaQhBXT0NK37d5jnnm5URoT/K+yLRstgyBipT3hYduT+1ehccsvENmPy215z
         8FdvlNNzScQJ6jTm+TMOmbJxTyLPlEiPf4eF6dmAzjFbirwsL+4TWSD8lJ02eZZQBUi4
         NTbc+o2+rwLKPgsfpX2xiPUhF2fXW1Ctx7snshC0bsXKf3vhNi+/2rnSdT2tspWQIqbt
         GXvQ==
X-Gm-Message-State: APjAAAX4JjDmeGlzOaagZDWiAoHnmDN9rb6ImQ9X48ov8sCgVW2g+lMp
        Fnwyn2zQaECErrFEdV+zUh8=
X-Google-Smtp-Source: APXvYqx8qHpVyMNgn+KXK4Ga99H83IyvN+gu/U0zu34xNKGN69+bZpzqlo+n/fuamwALPdtHuD1b7w==
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr9856547wrv.12.1568266986685;
        Wed, 11 Sep 2019 22:43:06 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id b194sm11035883wmg.46.2019.09.11.22.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 22:43:05 -0700 (PDT)
Date:   Wed, 11 Sep 2019 22:43:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3 3/3] powerpc/prom_init: Use -ffreestanding to avoid a
 reference to bcmp
Message-ID: <20190912054304.GA103826@archlinux-threadripper>
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20190911182049.77853-4-natechancellor@gmail.com>
 <CAKwvOdnh+YoACaX4Oxk7ZiEQAQ2VgA6W=Dtbk7gzK5yJduFvGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnh+YoACaX4Oxk7ZiEQAQ2VgA6W=Dtbk7gzK5yJduFvGQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 02:01:59PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 11, 2019 at 11:21 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > r370454 gives LLVM the ability to convert certain loops into a reference
> > to bcmp as an optimization; this breaks prom_init_check.sh:
> >
> >   CALL    arch/powerpc/kernel/prom_init_check.sh
> > Error: External symbol 'bcmp' referenced from prom_init.c
> > make[2]: *** [arch/powerpc/kernel/Makefile:196: prom_init_check] Error 1
> >
> > bcmp is defined in lib/string.c as a wrapper for memcmp so this could be
> > added to the whitelist. However, commit 450e7dd4001f ("powerpc/prom_init:
> > don't use string functions from lib/") copied memcmp as prom_memcmp to
> > avoid KASAN instrumentation so having bcmp be resolved to regular memcmp
> > would break that assumption. Furthermore, because the compiler is the
> > one that inserted bcmp, we cannot provide something like prom_bcmp.
> >
> > To prevent LLVM from being clever with optimizations like this, use
> > -ffreestanding to tell LLVM we are not hosted so it is not free to make
> > transformations like this.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/647
> > Link: https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e002
> 
> The above link doesn't work for me (HTTP 404).  PEBKAC?
> https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e002

Not really sure how an extra 2 got added on the end of that... Must have
screwed up in vim somehow.

Link: https://github.com/llvm/llvm-project/commit/5c9f3cfec78f9e9ae013de9a0d092a68e3e79e00

I can resend unless the maintainer is able to fix that up when it gets
applied.

Cheers,
Nathan

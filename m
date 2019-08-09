Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20588554
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfHIV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 17:56:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41911 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHIV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:56:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so36133869pgg.8;
        Fri, 09 Aug 2019 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iF8XDfjf7OAYK6LGbHjkXf1kEPXCCuRVGlqPI2lfvf4=;
        b=kQdIpVEb36HQzmYc1mG+FFRNAWSm8ZMY2r71qKqpR3j0RDWHumGqsKzVButPqdcaKA
         wqOSy6HXElsFnQczjlnC6J8KVJkGCE73DDJ00ftNfhmSxIJbpl77wor6QvXqpXZoFTKN
         HAytglT+YJniUV5hSreLG2wh4Jhc4ydruLXQ/l6MFLAfLNpz6fbQoBf+0AEO/NBBEO5Q
         paAR4GhyUDlAYhi+40b3KjBnZ7tOdiS8ZfEnf6iml/8PAr27aOWDagw/6lRVuMudoIf5
         LKqPpalwAtbdG/R1KtXdYGyx2vQxw4FRzhBjx+2zRwcXVKuSTNJ6HkJVGNz9xmp7KIz1
         2u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iF8XDfjf7OAYK6LGbHjkXf1kEPXCCuRVGlqPI2lfvf4=;
        b=rcyYMo3+05SqvukoP6uvONqOxNcCbqKGCJwBcKLB0iGUctOPwwP2FVx+Pg+jQ8tWtk
         gbmgiQkRbzgJ7J9v2Zkvc5xYy2hVIOraJsyxCkQkrTCEOO6KkxoLNZCKIIp3kTBQAH1c
         h2+55VQ0zZetPIzjki9+Iiho7w1cLK3bU0IRLVY5d/dTXgH0mfBJF6NL5ekYWcVQXQiv
         AaoSLzbTzSIPwQjd61qprL8QOvwZPj7bMvbdJ0BHOnn8RaLMpxtsxAO8B/kz1C7aJpNz
         Z0vUpwL/yASJ5RiURwGXvfCfJNK5NrCzkgbwEmMxVu4o43FLKX/V2XTf7lLqoq9rNmg6
         q4Kw==
X-Gm-Message-State: APjAAAWxGl5tZwbSelZvqMoNpQpZBXDKcnxdGabtbYc86UTyDrCFngDl
        LN9SuClqAQtt0kUvds4Edb/Fg7LI
X-Google-Smtp-Source: APXvYqyfsm+jqRUZiXsW83kcSpTAuQb8JUXdteAu+1jKe417GHvittc8WO+BS+ESv4GBJPQ+5BD5vw==
X-Received: by 2002:a65:4341:: with SMTP id k1mr19356600pgq.153.1565387770900;
        Fri, 09 Aug 2019 14:56:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 185sm99336215pfd.125.2019.08.09.14.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:56:09 -0700 (PDT)
Date:   Fri, 9 Aug 2019 14:56:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
Message-ID: <20190809215608.GA11065@roeck-us.net>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <20190805032441.GO9017@brightrain.aerifal.cx>
 <20190809195630.GA15606@roeck-us.net>
 <5f26547f-b48e-4b9f-b8ef-858283915e3d@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f26547f-b48e-4b9f-b8ef-858283915e3d@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:36:01PM -0500, Gustavo A. R. Silva wrote:
> Hi Guenter,
> 
> On 8/9/19 2:56 PM, Guenter Roeck wrote:
> > On Sun, Aug 04, 2019 at 11:24:41PM -0400, Rich Felker wrote:
> >> On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
> >>> Since commit a035d552a93b ("Makefile: Globally enable fall-through
> >>> warning"), all sh builds fail with errors such as
> >>>
> >>> arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> >>> arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> >>>
> >>> Since this effectively disables all build and boot tests for the
> >>> architecture, let's drop -Werror from the sh kernel Makefile until
> >>> the problems are fixed.
> >>>
> >>> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>
> >> Acked-by: Rich Felker <dalias@libc.org>
> >>
> > Any chance to get this or a similar patch applied soon ? All sh builds
> > in mainline and -next are still broken.
> > 
> 
> If no one cares, I can add it to my tree and include it in my pull-request
> for 5.3-rc4.
> 
> I would just need your Tested-by.
> 

Sure:

Tested-by: Guenter Roeck <linux@roeck-us.net>

[ Applied to ToT and built sh:{defconfig,allnoconfig,tinyconfig} ]

Thanks,
Guenter

> Thanks
> --
> Gustavo
> 
> > Thanks,
> > Guenter
> > 
> >>> ---
> >>>  arch/sh/kernel/Makefile | 2 --
> >>>  1 file changed, 2 deletions(-)
> >>>
> >>> diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
> >>> index 59673f8a3379..ef65f0625c6c 100644
> >>> --- a/arch/sh/kernel/Makefile
> >>> +++ b/arch/sh/kernel/Makefile
> >>> @@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
> >>>  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
> >>>  obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
> >>>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
> >>> -
> >>> -ccflags-y := -Werror
> >>> -- 
> >>> 2.7.4

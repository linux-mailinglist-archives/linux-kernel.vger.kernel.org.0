Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4821335A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 23:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgAGWZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 17:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgAGWZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:25:14 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DEA206DB;
        Tue,  7 Jan 2020 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578435913;
        bh=ck4c7UJ9ZG5qWrKFy9xztVIZezQr5I8+IAhGkqjM2wo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LjnYP2WtPxOf1+s588IKoPoQVbQS95f9r2Tm6C45d4QkS3w5bt0sdSroqMOUdQvpv
         0kiMXWQ2G04zlLAjsQtwAVQZhAI3ggQxSYs35zfx78MEZx3H4qwXMb+q1w8VPwzJAl
         iZocijQ+jIbbVfEkp/KVespF2ONYI7c7xk27OxQw=
Date:   Tue, 7 Jan 2020 14:25:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>, linux-mm@kvack.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: work around bogus -Wrestrict warning
Message-Id: <20200107142512.b3d63df56ffee1ef471b6acd@linux-foundation.org>
In-Reply-To: <20200107214042.855757-1-arnd@arndb.de>
References: <20200107214042.855757-1-arnd@arndb.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 22:40:26 +0100 Arnd Bergmann <arnd@arndb.de> wrote:

> gcc -O3 produces some really odd warnings for this file:
> 
> kernel/kallsyms.c: In function 'sprint_symbol':
> kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>    strcpy(buffer, name);
>    ^~~~~~~~~~~~~~~~~~~~
> kernel/kallsyms.c: In function 'sprint_symbol_no_offset':
> kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>    strcpy(buffer, name);
>    ^~~~~~~~~~~~~~~~~~~~
> kernel/kallsyms.c: In function 'sprint_backtrace':
> kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>    strcpy(buffer, name);
>    ^~~~~~~~~~~~~~~~~~~~
> 
> This obviously cannot be since it is preceded by an 'if (name != buffer)'
> check.
> 
> Using sprintf() instead of strcpy() is a bit wasteful but is
> the best workaround I could come up with.
> 
> ...
>
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -366,7 +366,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  		return sprintf(buffer, "0x%lx", address - symbol_offset);
>  
>  	if (name != buffer)
> -		strcpy(buffer, name);
> +		sprintf(buffer, "%s", name);
>  	len = strlen(buffer);
>  	offset -= symbol_offset;

gee, is that even worth "fixing"?  Oleksandr, I've seen a couple of
these false positives.  Do we know if anyone is taking them to the gcc
developers?


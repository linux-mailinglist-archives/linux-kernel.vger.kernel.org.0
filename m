Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5161362FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 23:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgAIWCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 17:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgAIWCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:02:04 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF9F2075D;
        Thu,  9 Jan 2020 22:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578607323;
        bh=88y37HxDUMffX0HsWQMZbo0p/Dn1R5k39rJxWhAGkv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RR5TIJx35kahaEVAxbdZSd2dD4wvvD8AygQIteNvGlhu412PcwBHI8AA++92FE7LS
         vzWA2mF2npuuF4AhWN+5xyBED2EGGDYnXNcNBvr/hY+Hz8EZplxNFIix9KXqE8N71x
         B3NTTHoTPXneC2tJYdwo7CNOgOrCKoT755DN3CLY=
Date:   Thu, 9 Jan 2020 14:02:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Natalenko <oleksandr@redhat.com>, linux-mm@kvack.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Will Deacon <will@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: work around bogus -Wrestrict warning
Message-Id: <20200109140202.fd5488a2ac02f81b25d83b88@linux-foundation.org>
In-Reply-To: <20200108102602.43d4c5433eb495cdbf387e9b@kernel.org>
References: <20200107214042.855757-1-arnd@arndb.de>
        <20200108102602.43d4c5433eb495cdbf387e9b@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 10:26:02 +0900 Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Arnd,
> 
> On Tue,  7 Jan 2020 22:40:26 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > gcc -O3 produces some really odd warnings for this file:
> > 
> > kernel/kallsyms.c: In function 'sprint_symbol':
> > kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
> >    strcpy(buffer, name);
> >    ^~~~~~~~~~~~~~~~~~~~
> > kernel/kallsyms.c: In function 'sprint_symbol_no_offset':
> > kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
> >    strcpy(buffer, name);
> >    ^~~~~~~~~~~~~~~~~~~~
> > kernel/kallsyms.c: In function 'sprint_backtrace':
> > kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
> >    strcpy(buffer, name);
> >    ^~~~~~~~~~~~~~~~~~~~
> > 
> > This obviously cannot be since it is preceded by an 'if (name != buffer)'
> > check.
> 
> Hmm, this looks like a bug in gcc.

Yes, we're getting a lot of such reports.  I don't think current gcc is
ready for this patch so I'll drop it, sorry.


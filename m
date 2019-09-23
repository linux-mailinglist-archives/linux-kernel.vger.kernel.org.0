Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0325FBBC49
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfIWTen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:34:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55662 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfIWTen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:34:43 -0400
Received: from zn.tnic (p200300EC2F060400F036B51F4D309BFC.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:f036:b51f:4d30:9bfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 743B11EC06F3;
        Mon, 23 Sep 2019 21:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569267281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cOtIH+ThVHQpxFENK80/GDkwsFcGH4JpmGhb1RD1kuE=;
        b=sXcWlOo1Cf6BR+lWrajtGnsDDTS9hIUvKwljeKpj+Nm0t85WnvDMx+6rvJziYTomTou4ZU
        KJLHPsr3OayePY/9EaXJutOEAxwUyYEMBQhiKuIXOj1m1wxS4/oVgmW1g7TaW7gHxxULSV
        12ky9HQnuiXhbMI4N6FQqTBFzrVrbF0=
Date:   Mon, 23 Sep 2019 21:34:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
Message-ID: <20190923193446.GL15355@zn.tnic>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190923094916.GB15355@zn.tnic>
 <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:41:59AM -0700, Andy Lutomirski wrote:
> On Mon, Sep 23, 2019 at 2:49 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> > > While touching seccomp code I realized that the struct seccomp_data
> > > argument to secure_computing() seems to be unused by all current
> > > callers. So let's remove it unless there is some subtlety I missed.
> > > Note, I only tested this on x86.
> >
> > What was amluto thinking in
> >
> > 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> 
> IIRC there was a period of time in which x86 used secure_computing()
> for normal syscalls, and it was a good deal faster to have the arch
> code supply seccomp_data.  x86 no longer works like this, and syscalls
> aren't fast anymore ayway :(

Uhuh, thanks Andy.

Christian, pls add that piece of history to the commit message.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

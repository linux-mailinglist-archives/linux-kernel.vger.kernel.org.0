Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E09137793
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 20:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgAJT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 14:58:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34950 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgAJT6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:58:45 -0500
Received: from zn.tnic (p200300EC2F0ACA00F8C15324EBC48DF9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:f8c1:5324:ebc4:8df9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAE561EC0AB5;
        Fri, 10 Jan 2020 20:58:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578686323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Zf4g5IfOki+jdhGV15Erd3yZAnIWoJKHhalmJWvQEg=;
        b=XPcsW5ON8bdwb6eQ1BUiL3NXPLHQ9MUEhHdnHz3BZ/O+Dq45sCeuiLmkbzg6WOB0079egu
        mSnz5bc6k6oLWWvtagMQKlfVRHwI754WNIS+l597r4fWVcZcWQuEambYIyxlxIglmvAJcd
        fCbtHhxI0Yb+ySxSfm4Qap56FFESDic=
Date:   Fri, 10 Jan 2020 20:58:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/nmi: remove the irqwork from long duration nmi
 handler
Message-ID: <20200110195837.GJ19453@zn.tnic>
References: <20200101072017.82990-1-changbin.du@gmail.com>
 <877e20bb8o.fsf@nanos.tec.linutronix.de>
 <20200109210225.GK5603@zn.tnic>
 <20200110140549.xqjhrdpxllkvqbuk@mail.google.com>
 <20200110151329.GF19453@zn.tnic>
 <20200110173449.rhr5p4lal3aul43g@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110173449.rhr5p4lal3aul43g@mail.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 05:34:50PM +0000, Changbin Du wrote:
> Just to move all the check code together and be a standalone function.
> yes, this somewhat does code refining after the irqwork is removed but
> I think it is normal.

But it makes review harder because your patch is removing irq_work,
*nothing* in the commit message is talking about *why* you're doing
that additional change. I'd imagine at the end of the commit message
something like:

"While at it, repurpose the IRQ work callback into a function which
concentrates the NMI duration checking."

This lets a reader know know why that additional change is done instead
of going back'n'forth and having to ask you why you're doing this.

Ok?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

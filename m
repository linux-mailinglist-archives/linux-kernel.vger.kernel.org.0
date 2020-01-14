Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 183E313A85D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgANLZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 06:25:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANLZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:25:47 -0500
Received: from zn.tnic (p200300EC2F0C770060129B71B11B0F90.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:6012:9b71:b11b:f90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 461A81EC0BEA;
        Tue, 14 Jan 2020 12:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579001146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g5ixugOVRuXE3OBNiFLY3JBBRHgbhFnO38afmDijZFs=;
        b=RCS7neu0FDJq6uwjIyKqhgqo3aYtR/9d31OtJ+xSReM7zFQNoJh/14Zxws1YKtbEotl5vF
        XF4wzwe9fycWPXSJrEVWLCZK5LDgYa64M9z4dNoSBhMgnAuNMvshEozGK13+Npa9GX+Rzc
        vR6czCncxfhMpkofsWZBzgJRjHh0ifk=
Date:   Tue, 14 Jan 2020 12:25:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200114112538.GD31032@zn.tnic>
References: <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
 <20200113161310.GA191743@rani.riverdale.lan>
 <20200113163855.GK13310@zn.tnic>
 <20200113175937.GA428553@rani.riverdale.lan>
 <20200113180826.GN13310@zn.tnic>
 <20200114041725.GC2536335@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114041725.GC2536335@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:17:25PM -0500, Arvind Sankar wrote:
> On Mon, Jan 13, 2020 at 07:08:26PM +0100, Borislav Petkov wrote:
> > On Mon, Jan 13, 2020 at 12:59:38PM -0500, Arvind Sankar wrote:
> > > How is "breaks with binutils before version 2.23" not clear enough? It
> > 
> > Nevermind, I'll write it myself if/when I end up applying some version
> > of it. I've wasted enough time trying to get my point across.
> > 
> 
> You're wasting time, because you're not _listening_ to the other guy.

FFS you're still missing the point: the question is whether this
is a widespread issue - a distro shipping this funky binutils and
therefore it being a problem on potentially more than one environment -
or something people can only trigger by *specially* building themselves
and thus a lot more seldom occurrence.

And I've answered the question myself by booting openSUSE 12.1 - i.e.,
at least one distro has it.

And regardless, so what if you add some more text to the commit message?
Are you afraid that you'll over-describe the issue? Hell, you've typed
more just in debating this.

And let me tell you why it is a good thing to have more detailed
explanations in commit messages: when you move on and go do something
else, all that is left is a commit message for maintainers to do git
archaeology on and scratch heads as to why stuff was done the way it was.

And this happens very often: read a oneliner commit message and go find
a crystal ball to figure out what the author meant.

And I told you that *I* will write it myself and you wouldn't have to do
diddly squat. And yet you still can't let it go!

So you can debate all you want - you won't change my mind about wanting
to have stuff explained in detail in commit messages.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

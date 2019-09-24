Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A14BCFF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633017AbfIXQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 12:43:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633002AbfIXQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pg+isT0abxRK8PsThFH4dFGWxytvoXKthoZB4FWIcCY=; b=pSSFz/TidsIPuUf4BwKRrs2QZ
        LXloOqHMGQqnDGcNyEaGbfzDPUl09vSRc2K6UpTyUxW0ZDkBAcsqByWEWQphORjwtjvqyki6mUUHa
        P/q+UwuyF470ELG8FkSSg8A4pBsKeaMxN5fY0+cRMFVucEwAf8H4OUBWuiAALthkV9yktC7BzDmbq
        p+8QkW4SXBcHudVMOXg6K8chfeho/zWf++weyvl/Xbl3hV5PDwA5vZa0AqWHTHr4E7JjU8947fQsM
        +IECp1HMQ/ksN4+s11S4124sp0H58LNN+2J270VtXorKzdN5qLldDhjlGUBwNw0byU11Rw4sixoME
        tIuWmqfZw==;
Received: from 177.96.206.173.dynamic.adsl.gvt.net.br ([177.96.206.173] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCnuT-0004nu-RX; Tue, 24 Sep 2019 16:43:30 +0000
Date:   Tue, 24 Sep 2019 13:43:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Use make invocation's -j argument for
 parallelism
Message-ID: <20190924134325.4788fc30@coco.lan>
In-Reply-To: <201909231537.0FC0474C@keescook>
References: <201909191438.C00E6DB@keescook>
        <20190922140331.3ffe8604@lwn.net>
        <201909231537.0FC0474C@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 23 Sep 2019 15:40:41 -0700
Kees Cook <keescook@chromium.org> escreveu:

> On Sun, Sep 22, 2019 at 02:03:31PM -0600, Jonathan Corbet wrote:
> > On Thu, 19 Sep 2019 14:44:37 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> >   
> > > While sphinx 1.7 and later supports "-jauto" for parallelism, this
> > > effectively ignores the "-j" flag used in the "make" invocation, which
> > > may cause confusion for build systems. Instead, extract the available  
> > 
> > What sort of confusion might we expect?  Or, to channel akpm, "what are the
> > user-visible effects of this bug"?  
> 
> When I run "make htmldocs -j16" with a pre-1.7 sphinx, it is not
> parallelized.

Sphinx supports parallel builds for a while. With pre-1.7, you could do
something like:

	make SPHINXOPTS="-j16" htmldocs

Yet, on my experiences on big machines (tested here with Xeon with 40 and 64
CPU threads), parallel build doesn't actually benefit with values higher than
-j5 to -j8, with pre-1.7.

Sphinx 1.7 and higher seem to have improved a lot with "-jauto"
(although I didn't time it comparing with -j5 or -j8 on a big server).

> When I run "make htmldocs -j8" with 1.7+ sphinx, it uses
> all my CPUs instead of 8. :)

This should do the trick:

	make SPHINXOPTS="-j8" htmldocs

But yeah, IMHO, the best is if it could honor the Makefile flag:

	make -j8 htmldocs

If SPHINXOPTS doesn't contain "-j".

> > > +	-j $(shell python3 $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \  
> > 
> > This (and the shebang line in the script itself) will cause the docs build
> > to fail on systems lacking Python 3.  While we have talked about requiring
> > Python 3 for the docs build, we have not actually taken that step yet.  We
> > probably shouldn't sneak it in here.  I don't see anything in the script
> > that should require a specific Python version, so I think it should be
> > tweaked to be version-independent and just invoke "python".  
> 
> Ah, no problem. I can fix this. In a quick scan it looked like sphinx
> was python3, but I see now that's just my install. :)

On Fedora 30, both python2 and python3 versions are available:

	python2-sphinx.noarch : Python documentation generator
	python3-sphinx.noarch : Python documentation generator

However, if one tries to install it without specifying "2" or "3", it
defaults to python2 version:

	$ sudo dnf install python-sphinx
	...
	Installing:
	 python2-sphinx                  noarch 1:1.8.4-1.fc30            fedora  1.8 M

AFAIKT, this also applies when distro upgrades takes place: upgrading
a python2 sphinx from Fedora 30 to Rawhide will very likely keep
the python2 version.

Thanks,
Mauro

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B9BCC22
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 18:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406800AbfIXQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 12:11:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39347 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbfIXQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:11:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so1574870pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qyTnNnxb8TJ7gNF/VD8MxVSVpiu+tvEw7TRp8mh/P70=;
        b=Sbw/n9Bl63pQKBOQbIUgIrw80Hqa0wGekdewr2/bo4VXF0gLYmWvZAHTcPxCGu9NSB
         0tR0WMz8rNqXHizIQimiUYEJ9Z5ftVquXRvlbhkZ++qXZLaWQNALCnax9AIVeHQ4sInm
         U+VIQ9193IuEz06aaEn+vo6kwJz7rS/uRNQv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyTnNnxb8TJ7gNF/VD8MxVSVpiu+tvEw7TRp8mh/P70=;
        b=Wmi2dyAoffUlflstJwxWp7Lt3HOT47ycPaTcozF21icSmZ49VfMEAAaqrpWrj8lDeg
         46F4P1HhtEunB2imSglRj8CnY88XJ1PmOqi/xf8Nmgy9Ceevq8mKqiMH4B4Z0lpL3A0s
         PJGq6O7DP6yGzRsnuW8iJvc/Ryz3jXlynsBo+eXaWSq7nPzb8aEltkucdIEiKRxI5Lck
         9QuongSpo0ryE3ndr017F2xaCIvtRJxBWFxow3ko0rLeImCO52N5cOnGWeJbu2oX0aTz
         kuYGpPwGbV4X6dFAkwwszOgROvXwRk0rqBerLxThx+jgSr15DD0ljXtHt6zUg/DTswxx
         7Hhw==
X-Gm-Message-State: APjAAAU51CdNtLGp//7pTz5WKxzn8F718/COe6N/dMqf6F8X1UuV6OC4
        vwTO8DXoXxOZaGqbd94eW85DwobElhs=
X-Google-Smtp-Source: APXvYqx1aOIENeCSah08MVTYFrD/NuAxr0V017MpiWVqy3TIvXWY1n8ZumQkO1CM5um9w8XxVf0x/g==
X-Received: by 2002:a63:5f47:: with SMTP id t68mr3945078pgb.363.1569341480924;
        Tue, 24 Sep 2019 09:11:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 64sm2096771pfx.31.2019.09.24.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 09:11:20 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:11:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Use make invocation's -j argument for
 parallelism
Message-ID: <201909240910.D6E5C767D1@keescook>
References: <201909191438.C00E6DB@keescook>
 <20190922140331.3ffe8604@lwn.net>
 <201909231537.0FC0474C@keescook>
 <87pnjqtbft.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnjqtbft.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:12:22AM +0300, Jani Nikula wrote:
> On Mon, 23 Sep 2019, Kees Cook <keescook@chromium.org> wrote:
> > On Sun, Sep 22, 2019 at 02:03:31PM -0600, Jonathan Corbet wrote:
> >> On Thu, 19 Sep 2019 14:44:37 -0700
> >> Kees Cook <keescook@chromium.org> wrote:
> >> 
> >> > While sphinx 1.7 and later supports "-jauto" for parallelism, this
> >> > effectively ignores the "-j" flag used in the "make" invocation, which
> >> > may cause confusion for build systems. Instead, extract the available
> >> 
> >> What sort of confusion might we expect?  Or, to channel akpm, "what are the
> >> user-visible effects of this bug"?
> >
> > When I run "make htmldocs -j16" with a pre-1.7 sphinx, it is not
> > parallelized. When I run "make htmldocs -j8" with 1.7+ sphinx, it uses
> > all my CPUs instead of 8. :)
> 
> To be honest, part of the solution should be to require Sphinx 1.8 or
> later. Even Debian stable has it. If your distro doesn't have it
> (really?), using the latest Sphinx in a virtual environment should be a
> matter of:
> 
> $ python3 -m venv .venv
> $ . .venv/bin/activate
> (.venv) $ pip install sphinx sphinx_rtd_theme
> (.venv) $ make htmldocs

I don't mind having sphinx 1.8 (I did, in fact, already update it), but
that still doesn't solve the whole problem: my -j argument is being
ignored...

-Kees

> 
> BR,
> Jani.
> 
> 
> >
> >> > +	-j $(shell python3 $(srctree)/scripts/jobserver-count $(SPHINX_PARALLEL)) \
> >> 
> >> This (and the shebang line in the script itself) will cause the docs build
> >> to fail on systems lacking Python 3.  While we have talked about requiring
> >> Python 3 for the docs build, we have not actually taken that step yet.  We
> >> probably shouldn't sneak it in here.  I don't see anything in the script
> >> that should require a specific Python version, so I think it should be
> >> tweaked to be version-independent and just invoke "python".
> >
> > Ah, no problem. I can fix this. In a quick scan it looked like sphinx
> > was python3, but I see now that's just my install. :)
> >
> >> >  	-b $2 \
> >> >  	-c $(abspath $(srctree)/$(src)) \
> >> >  	-d $(abspath $(BUILDDIR)/.doctrees/$3) \
> >> > diff --git a/scripts/jobserver-count b/scripts/jobserver-count
> >> > new file mode 100755
> >> > index 000000000000..ff6ebe6b0194
> >> > --- /dev/null
> >> > +++ b/scripts/jobserver-count
> >> > @@ -0,0 +1,53 @@
> >> > +#!/usr/bin/env python3
> >> > +# SPDX-License-Identifier: GPL-2.0-or-later
> >> 
> >> By license-rules.rst, this should be GPL-2.0+
> >
> > Whoops, thanks.
> >
> >> > +# Extract and prepare jobserver file descriptors from envirnoment.
> >> > +try:
> >> > +	# Fetch the make environment options.
> >> > +	flags = os.environ['MAKEFLAGS']
> >> > +
> >> > +	# Look for "--jobserver=R,W"
> >> > +	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> >> > +
> >> > +	# Parse out R,W file descriptor numbers and set them nonblocking.
> >> > +	fds = opts[0].split("=", 1)[1]
> >> > +	reader, writer = [nonblock(int(x)) for x in fds.split(",", 1)]
> >> > +except:
> >> 
> >> So I have come to really dislike bare "except" clauses; I've seen them hide
> >> too many bugs.  In this case, perhaps it's justified, but still ... it bugs
> >> me ...
> >
> > Fair enough. I will adjust this (and the later instance).
> >
> >> 
> >> > +	# Any failures here should result in just using the default
> >> > +	# specified parallelism.
> >> > +	print(default)
> >> > +	sys.exit(0)
> >> > +
> >> > +# Read out as many jobserver slots as possible.
> >> > +jobs = b""
> >> > +while True:
> >> > +	try:
> >> > +		slot = os.read(reader, 1)
> >> > +		jobs += slot
> >> > +	except:
> >> 
> >> This one, I think, should be explicit; anything other than EWOULDBLOCK
> >> indicates a real problem, right?
> >> 
> >> > +		break
> >> > +# Return all the reserved slots.
> >> > +os.write(writer, jobs)
> >> 
> >> You made writer nonblocking, so it seems plausible that we could leak some
> >> slots here, no?  Does writer really need to be nonblocking?
> >
> > Good point. I will fix this too.
> >
> >> 
> >> > +# If the jobserver was (impossibly) full or communication failed, use default.
> >> > +if len(jobs) < 1:
> >> > +	print(default)
> >> > +
> >> > +# Report available slots (with a bump for our caller's reserveration).
> >> > +print(len(jobs) + 1)
> >> 
> >> The last question I have is...why is it that we have to do this complex
> >> dance rather than just passing the "-j" option through directly to sphinx?
> >> That comes down to the "confusion" mentioned at the top, I assume.  It
> >> would be good to understand that?
> >
> > There is no method I have found to discover the -j option's contents
> > (intentionally so, it seems) from within make. :(
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Kees Cook

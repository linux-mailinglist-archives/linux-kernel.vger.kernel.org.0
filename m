Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06C91054AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 15:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKUOkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 09:40:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37847 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKUOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:40:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id g50so3915869qtb.4;
        Thu, 21 Nov 2019 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cz2tp7tcw8k14gkrUnEP9zX8ksAJjsAkvSmuB4LZNbQ=;
        b=PA9bCfC2QaMdT3abm5t9qg6tld7cebGzmYocA7wE3d2WCahijpsoOQ2dhT2Yt78Cc1
         slmIFEz4FRIA//ThFS1+Z//pP84evv+lw0Zng9HuWsnpH3virjSWYROI9b5hzujx3gQB
         AT0xHsyiv1dEpGsUGayvgUw0da5h3O9k+tlZ4pU+c2jxdP/sZ/snJJb1LS9fUWUbC5bB
         ra9eOImYroIOb5OUgPvywOUmaIjhDReY0RjRSrP1EEZkz3LBG9bmuy4DjQscNNFbLdHV
         jCiMvMxARLF3PF2925VhmLj8+LdX1Y5Vz++XQuCEl6ECI41L1K4hl6LH6ZVpZV3RP00b
         BGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cz2tp7tcw8k14gkrUnEP9zX8ksAJjsAkvSmuB4LZNbQ=;
        b=Koai2rMx+zCIDvTMR7ZHs7fXoDucB52okkVhSPcFf2SpPLgLteSIYM0UIjxP6ROKXz
         1V5dSfjepcJ+szUGRuGDhmPf9ymwtAKEUqnNU+19E6We/nXw6nwTcSKt+d76nx24wM+F
         XH1MxZotlQQj7r7+OKG3LSidSVHL6J2N60tTn0VihaqrQG9lRfw91kyXRVGMaUV1Mw4w
         9YSY18KLatSU7Q+vspooZZrW0kCSzPKGF08BJG3WoGsd2BF13aR7RaTychOSrDL80IIk
         hmCWoc5i2v2IlQNVcjPyCcV2gvzvkiYwI+hYoJr+SC1uhAOWQUMA1rECUG7cA3gJxNgr
         2JGA==
X-Gm-Message-State: APjAAAWGLdyzyxp7m09c4iBXkSLfzG31tkTXJzRQeHDHi2jOfpFar2j5
        2BMLsUy6+Ib5i87T+8stXYI=
X-Google-Smtp-Source: APXvYqxoPNNEp3XfqyoLMTw9ZAzBvWkITtRpOOYWrC7wKiBhnPQzKioSBjYvjgD0TLf3kHQymvdr3A==
X-Received: by 2002:ac8:6d0b:: with SMTP id o11mr8818428qtt.253.1574347204774;
        Thu, 21 Nov 2019 06:40:04 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q34sm1638736qte.50.2019.11.21.06.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:40:04 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F271F40D3E; Thu, 21 Nov 2019 11:40:01 -0300 (-03)
Date:   Thu, 21 Nov 2019 11:40:01 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH] libtraceevent: fix header installation
Message-ID: <20191121144001.GF5078@kernel.org>
References: <20191114133719.309-1-sudipm.mukherjee@gmail.com>
 <20191114174022.62c8259e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114174022.62c8259e@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 14, 2019 at 05:40:22PM -0500, Steven Rostedt escreveu:
> 
> Arnaldo,
> 
> Can you take this?
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks, applied.

- Arnaldo
 
> -- Steve
> 
> 
> On Thu, 14 Nov 2019 13:37:19 +0000
> Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> 
> > When we passed some location in DESTDIR, install_headers called
> > do_install with DESTDIR as part of the second argument. But do_install
> > is again using '$(DESTDIR_SQ)$2', so as a result the headers were
> > installed in a location $DESTDIR/$DESTDIR. In my testing I passed
> > DESTDIR=/home/sudip/test and the headers were installed in:
> > /home/sudip/test/home/sudip/test/usr/include/traceevent.
> > Lets remove DESTDIR from the second argument of do_install so that the
> > headers are installed in the correct location.
> > 
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > ---
> > 
> > Hi Steve,
> > sent this earlier as an attachment to an email thread, not sure if you
> > saw it, so sending it now properly.
> > The other problem with the pkgconfig, I guess we can live with that for
> > now as that folder is given by pc_path.
> > 
> >  tools/lib/traceevent/Makefile | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
> > index 5315f3787f8d..cbb429f55062 100644
> > --- a/tools/lib/traceevent/Makefile
> > +++ b/tools/lib/traceevent/Makefile
> > @@ -232,10 +232,10 @@ install_pkgconfig:
> >  
> >  install_headers:
> >  	$(call QUIET_INSTALL, headers) \
> > -		$(call do_install,event-parse.h,$(DESTDIR)$(includedir_SQ),644); \
> > -		$(call do_install,event-utils.h,$(DESTDIR)$(includedir_SQ),644); \
> > -		$(call do_install,trace-seq.h,$(DESTDIR)$(includedir_SQ),644); \
> > -		$(call do_install,kbuffer.h,$(DESTDIR)$(includedir_SQ),644)
> > +		$(call do_install,event-parse.h,$(includedir_SQ),644); \
> > +		$(call do_install,event-utils.h,$(includedir_SQ),644); \
> > +		$(call do_install,trace-seq.h,$(includedir_SQ),644); \
> > +		$(call do_install,kbuffer.h,$(includedir_SQ),644)
> >  
> >  install: install_lib
> >  

-- 

- Arnaldo

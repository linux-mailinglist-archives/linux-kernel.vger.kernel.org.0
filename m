Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272522D415
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 05:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfE2DFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 23:05:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39623 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2DFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:05:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so619424pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/03tKsWhiHmUnWe2CD0WCy6TKjmI9CNaKQ1QHLmZ1sA=;
        b=UsG7LOHi4eGxUeX0NsezAKQLnu5ULqBGWBytqwhY0xSGZCUI1EZwHAWwZ+xPeIlCnU
         LkbCKPTk3EFCU8u4Ly0VI9J9BZIkSXH6XjqyAmH+vlD5kVyjd4f9ALgrekbXJlZHUKz3
         ZT8BoO7Fij/rcMZOSCfoyfdZtRSzjOcSOdB00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/03tKsWhiHmUnWe2CD0WCy6TKjmI9CNaKQ1QHLmZ1sA=;
        b=DdtRdPYLhPoXX3zYjPgBshl4OQ0o5bxhbEq9Jwj+swsd7f43vZ85ChVSrCN+0JbCYU
         uK/A+kc4PI+qRtBhcjccSez4VCLX5Dt+8gCz9ScSIwgr1EyHme97Sm6uzBBzwi1+W1Gk
         U6GiFh1ZwmWVPOH3WXcySBFk8ULbso9a+ztEcUvVAxk/TqwdV6iiIIrFpoifDz9xWf1H
         IzPPoclzwmA+eZmeVS5BKTN5xbZ/gC6/SkIx2bdyDFqbqhLPcAmjq9lI2nrRAOri70UH
         N5vV/HVjgk7kLu2sP+3DgMFrOqwFTHADzT/qqamUKKEPxQuUfbkQVDwxlTktobHgYIEG
         hxkw==
X-Gm-Message-State: APjAAAXxjQy+wO6T/xQ+h293JXT74SdU/vYU8AmOV4/zdTRbXzpbC+XW
        UhT5ooJMJA+xfoymHOwzcpozYhw5huY=
X-Google-Smtp-Source: APXvYqy3KnvoJzyM65mWSVHCSRVd7NiAGi6YeXj8jQZi1cZxBdi377u8uo5PVjYL4iYNQf/N7R+L8A==
X-Received: by 2002:a17:90a:248:: with SMTP id t8mr9545652pje.119.1559099101509;
        Tue, 28 May 2019 20:05:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8sm3553933pjs.23.2019.05.28.20.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 20:05:00 -0700 (PDT)
Date:   Tue, 28 May 2019 20:04:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: test_overflow: Avoid taining the kernel and fix
 wrap size
Message-ID: <201905282004.A12656ECBF@keescook>
References: <201905281550.4E3CB258F@keescook>
 <7cf0e30a7309008a81cc65e692511a1e8e6b544f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cf0e30a7309008a81cc65e692511a1e8e6b544f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:40:06PM -0700, Joe Perches wrote:
> On Tue, 2019-05-28 at 15:51 -0700, Kees Cook wrote:
> > This adds __GFP_NOWARN to the kmalloc()-portions of the overflow test to
> > avoid tainting the kernel. Additionally fixes up the math on wrap size
> > to be architecture and page size agnostic.
> []
> > diff --git a/lib/test_overflow.c b/lib/test_overflow.c
> []
> > @@ -486,16 +486,17 @@ static int __init test_overflow_shift(void)
> []
> > +#define alloc_GFP		 (GFP_KERNEL | __GFP_NOWARN)
> []
> > +#define alloc110(alloc, arg, sz) alloc(arg, sz, alloc_GFP | __GFP_NOWARN)
> 
> seems redundant.

Whoops. Missed that one. Fixing...

-- 
Kees Cook

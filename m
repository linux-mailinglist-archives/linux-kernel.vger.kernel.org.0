Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10D537DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfFFUJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 16:09:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33713 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:09:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9so5122077edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=24yjnYL7s987Wr60j8RAvSz9t8n51a5eyXvTdKBP2FI=;
        b=T+TVZGGQQa96vI+6EVP32cJl1tCHal/pZDVbtAIrkuyFS0zd9i8L+qEhJCLo1ayG6n
         4tNcAxwlQe+aGhP0B1VaMiTRVAzqCuAi2x5Fq4U+Be2KKsdH8VKpixdx/kC4vBMSR8ON
         CW3HRyVODO/dFOKOrrZShUvHnZpOGeyVt3/QP94UVsOqnzhgR3tHwOGYvY9TDrQ8Ereu
         NQcl7V6jLDdqdBIvE32ySfeLOEhRCxUgX0hEvPIw26Sg6osJp6Vgrt516zRguEOnjLIt
         R23XeOGVkJ6UaZt4Iwk5H1TNn10EjP3bInaqK/ZnBfU2kSMOJrmNRzNs+lyt3lctP5jB
         BfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24yjnYL7s987Wr60j8RAvSz9t8n51a5eyXvTdKBP2FI=;
        b=BEu4XD/oPgAsGIS1xQZhcipHzlycjV7QYCXozW1mDuFPndEaRjIxSjj2J/zi4O7CW1
         XMjTs3eJvDUTfgPMa0aCTUAvsc2xTu1ICNZBQMXLy6Sdqeqr6t5ctY5StroVZ+OBWUVI
         3ues2XGZ7yp1g1+AhZcc4Kgk3dVdmYlbWJK/kOnoOiPa7XGlYZpHPiim8Sa+zTUHCQ60
         plx8SmMsPfGpEJcEvFEk9q5Cp66t6aHlZDxX4995AMWGmcEMjcn4z09YLlG9feU4wE16
         42rKoWusCTC7hLfD016DKoU+7guDEfiK/zOtvNpPczL6x5doYcHWWvliW7g0v2WLwe9E
         0Ksg==
X-Gm-Message-State: APjAAAWU0e31iB/qFLbo6KlexqhZu3B1MFTJ/KZO+SvtTiDj/InCgOyp
        uj47o+bXcTLGT+IjiNHzCOc=
X-Google-Smtp-Source: APXvYqzWlxmyZ/jtHCXySQJRlFAhkEFP/2YRxDB1KWJ4k66130Er8s8obknRMLzrvd7WFOq0+gRcLg==
X-Received: by 2002:a17:906:66c5:: with SMTP id k5mr43809059ejp.146.1559851761929;
        Thu, 06 Jun 2019 13:09:21 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id p23sm682711edx.61.2019.06.06.13.09.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 13:09:21 -0700 (PDT)
Date:   Thu, 6 Jun 2019 13:09:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ASoC: rt1011: Mark format integer literals as unsigned
Message-ID: <20190606200919.GA12912@archlinux-epyc>
References: <20190606051227.90944-1-natechancellor@gmail.com>
 <CAKwvOdnswiifrvSrBcAnc4Br8nhxJRUAL0yNM6T6=4xScHXf5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnswiifrvSrBcAnc4Br8nhxJRUAL0yNM6T6=4xScHXf5g@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 11:50:10AM -0700, Nick Desaulniers wrote:
> On Wed, Jun 5, 2019 at 10:13 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > sound/soc/codecs/rt1011.c:1291:12: warning: integer literal is too large
> > to be represented in type 'long', interpreting as 'unsigned long' per
> > C89; this literal will have type 'long long' in C99 onwards
> > [-Wc99-compat]
> >                 format = 2147483648; /* 2^24 * 128 */
> 
> This number's bitpattern is a leading one followed by 31 zeros.
> `format` is declared as `unsigned int`, and literals in C are signed
> unless suffixed, so this patch LGTM.  Maybe a macro declaring such a
> bitpattern would improve readability over the existing magic constant
> and comment?

I thought about it but that is ultimately up to the maintainer I think.

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> >                          ^
> > sound/soc/codecs/rt1011.c:2123:13: warning: integer literal is too large
> > to be represented in type 'long', interpreting as 'unsigned long' per
> > C89; this literal will have type 'long long' in C99 onwards
> > [-Wc99-compat]
> >                         format = 2147483648; /* 2^24 * 128 */
> >                                  ^
> > 2 warnings generated.
> >
> > Mark the integer literals as unsigned explicitly so that if the kernel
> > does ever bump the C standard it uses, the behavior is consitent.
> 
> s/consitent/consistent/
> 
> :set spell

Grr... I can send a v2 unless the maintainer wants to manually fix it
up. Thank you for the review as always.

Nathan

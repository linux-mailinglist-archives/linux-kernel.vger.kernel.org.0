Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92414A127
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 10:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgA0Jqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 04:46:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33389 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgA0Jqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:46:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id n7so4640096pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Cm7Q5qzKRSI5iiYtrFdNoM+jC44DmDk+4BVP7MJ9Zg=;
        b=TpYJh/exjltRCH5MaUqukcoU35cpYu4IuEiuVHoJprcgTTXo9U/FcLTjUK/nXQ3fDz
         6559/RJgNO0g3sLmU+rHSiUR2HGYTwLDvjiGdRTnxdtyP2X3wc5drkyP6dwwcCk40WaZ
         6Aey153QXTKHD/rXHU/kUZAkaWOsT8oaXxg71fAYko/Fo+knlW8ZewVpbEKF8HYuSmTO
         zDK/nhC3bVFz8H2ttpc7x42Qvp9pPqv/Zy9+PGPN0tEpCWa1bZEUpjUxKt3SmW7UF6B1
         PPl9+f2dfb/Z18xZgVEsR0SG74VwlPqgLnTECYbn949Aa84mw037tsNGH+QpGwX6UX+a
         /TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Cm7Q5qzKRSI5iiYtrFdNoM+jC44DmDk+4BVP7MJ9Zg=;
        b=FcERBuYWAEcjjmTPEXqgXLlXuz41HiIw72SzJNUGoEypZ21GiK92O4JsTUNio2txl1
         Df5M8rYYxtWnyvdY+Fvv7cDRC/6z9i1lLfV6Mb94x0eCsM44hN+9QT7LBfAxh7oOLZV9
         U4A60yuhLo2uHTd2JmWmZ0NjQ7WDSvg3kVVRCEaVSw7NLWOf0l9bYLgIbkAUCAKRWChf
         MvUk0smn/LOzqxnzYknJHxB+ensCvtIRNNHFhPz548Rh4U6n7/k6MocsZTmYLSqTfHxs
         B5mpUA2mtNB1P13WdgQvHreBYr9+GnNdiJ/lNK3Pko8AqYdfgFvqO7kZgZ02zcPcAHnO
         1Gqg==
X-Gm-Message-State: APjAAAVN18O3FSntHl1C/4hJLqN1aIhaA5jsILxnNPiJj/xuNZ1+xktF
        XHYyo393rZcUxaqDGL6sE7ENqxh4ztywWiNSJmG3VA==
X-Google-Smtp-Source: APXvYqzxAmZHmgdppWLSwzJ8z6LS1RNMsDSWdXzZNhIxbL6muJXHr3snth4+9kFim+A0KHQR+fGA6ETjYsUICdwc1Rg=
X-Received: by 2002:a63:480f:: with SMTP id v15mr18178906pga.201.1580118396834;
 Mon, 27 Jan 2020 01:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com> <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
 <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
In-Reply-To: <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 27 Jan 2020 01:46:25 -0800
Message-ID: <CAFd5g454tX9zxRAq5T_pDGzcWt7u5r119wjo-BCGVq+=Ej4bGQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>, linux-fsi@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 4:30 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 4:12 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Wed, 11 Dec 2019 at 19:28, Brendan Higgins <brendanhiggins@google.com> wrote:
> > >
> > > Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
> > > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > > the following build error:
> > >
> > > ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
> > > drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'
> > >
> > > Fix the build error by adding the unspecified dependency.
> > >
> > > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Nice. I hit this when attempting to force on CONFIG_COMPILE_TEST in
> > order to build some ARM drivers under UM. Do you have plans to fix
> > that too?
>
> The only broken configs I found for UML are all listed on the cover
> letter of this patch. I think fixing COMPILE_TEST on UM could be
> worthwhile. Did you see any brokenness other than what I mentioned on
> the cover letter?
>
> > Do you want to get this in a fix for 5.5?
>
> Preferably, yes.
>
> > Acked-by: Joel Stanley <joel@jms.id.au>

Hey, I know I owe you a reply about debugging your kunitconfig (I'll
try to get to that this week); nevertheless, it looks like this patch
didn't make it into 5.5. Can you make sure it gets into 5.6? It
shouldn't depend on anything else.

Cheers

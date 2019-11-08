Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A2FF3F13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 06:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfKHFBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 00:01:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38942 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHFBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:01:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id t8so5091545qtc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 21:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzvfMWm6lZTVenEz2A6tfcXxFYBZS2NeEfsJ5Lwl6mU=;
        b=AzLFd+Cb5WJAEHsyabvIPlF0a7RZVRiSU5hO06pXcPIiMFJDYhjlrUIjq6QL3fT5QN
         bk5cziYWINSekUHNpsa1t+vBMEzyaYlG2mxE0zu+Bw1PQhCLLF26w5Fipfx5WTql/Pdf
         yAiSutINib4a8E0u6unKohosDbgbb4NPODr44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzvfMWm6lZTVenEz2A6tfcXxFYBZS2NeEfsJ5Lwl6mU=;
        b=ar/nrkj4EHpLUYQw2PN/rUXxbZZ8S1sNO0DNkbfW3WPHKzZGHk6GdGnB2WMDPozUH1
         aT7e/GQm3el1Ltt/BXBcPuxKzOTYxDhOFuui69g8FrsM2LPAX0KRq4I2BR7upyrIv7bc
         i5bgHV6jFHQX7/3wFRQPBJLnZMlwAsum1Z81Op+GXJjYjMq9+YW2LrF45H0w24TuxXV4
         /afpGI6+5zgeXRt5RBp3PriTJb/jiKgL6l+YgDCHqnIznbKSCf8qtUmKUwIeYkczSPk3
         qdRKrm0SJ511SwMkLv4iXEW5UF5jQSnthUVgFaZH6/K+72F40WIuOkCha56tefZzXW1K
         sADw==
X-Gm-Message-State: APjAAAXs+so5ZvjG19iz+siOJVk8pbYcgi4vUauU2nOx4p5hXczRjHES
        QnzBQfFdS398NuhS6qVbhWdbCHg1I7PBWA97Usc=
X-Google-Smtp-Source: APXvYqwvg0y+AJatjjjsSTKJ+mkQ8J2a0Hivs0KSjM7GMpfAoNbYepX0PslWxlvr7BgidrfQr9iUe4b7H1gJwQufsec=
X-Received: by 2002:aed:3baf:: with SMTP id r44mr8335775qte.255.1573189261694;
 Thu, 07 Nov 2019 21:01:01 -0800 (PST)
MIME-Version: 1.0
References: <CACPK8XdtyQhK6OHJKbP=Fk50jRQQZeWzxqKDbX6kW0S5=eGuTg@mail.gmail.com>
 <20191107141736.GA109902@kroah.com>
In-Reply-To: <20191107141736.GA109902@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 8 Nov 2019 05:00:49 +0000
Message-ID: <CACPK8XdCwjtwXGmXs-F__sGA7ux_WVSFgGM72LQ0+9xDXVgSww@mail.gmail.com>
Subject: Re: [GIT PULL] fsi changes for 5.5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsi@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 at 14:17, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 07, 2019 at 12:09:50PM +0000, Joel Stanley wrote:
> > Hi Greg,
> >
> > Here's a set of changes I'd like merged for 5.5. They've been well
> > tested in the openbmc tree over the past month or so as we've done
> > hardware bring up using them. Aside from the three fixes I applied
> > today they have seen time in linux-next too.
> >
> > This is the first time I've sent you a pull request, so please let me
> > know if you'd prefer it done differently.
> >
> > The following changes since commit 755b0ef68f1802c786d0a53647145a5a7e46052a:
> >
> >   fsi: aspeed: Clean up defines and documentation (2019-11-07 22:24:18 +1030)
>
> The pull request looks good, but some of the individual patches, I have
> questions on.  Also, a diffstat would be good so that I know I got it
> right for the next time you send this.

>
> As they aren't here in the emails, let me try to figure out how to
> respond:
>         - You have new dt bindings, yet no review from the DT
>           maintainers.

That was a mistake. I had it on the list but Rob must have not seen it
yet, as he's reviewed other patches of mine in the mean time.

>         - you move things around in sysfs, yet no documentation updates
>           happen

The documentation was incorrect, and these changes make the layout
closer to what is described in Documentation/ABI. I will include a
patch to clarify.

>         - in 0005-fsi-Add-ast2600-master-driver.patch you have lots of
>           dev_dbg() lines left that shoudl be dropped as that's what
>           ftrace is for
>         - you don't have any reviewers for some of these patches, that's
>           not good to stick in a pull request.

To give you some background, the code has all been closely reviewed as
it underwent development on the public openbmc list. We discussed
sending all of the patches with history preserved, but decided there
was very little value in having that history in the mainline kernel,
with the exception of patch 7 I mention below.

Unfortunately my co-developers are on leave or snowed under, so they
didn't get a chance to respond with r-b tags to the series I sent out
last week:

https://lore.kernel.org/linux-arm-kernel/20191101112905.7282-2-joel@jms.id.au/

>         - 0007-fsi-aspeed-Fix-OPB0-byte-order-register-values.patch does
>           not have a Fixes: tag, nor a stable@vger cc:, why not?

This patch is a fix for an earlier patch in the series. I did not
squash it in as I wanted the commit message to be part of history.

>         - 0010-fsi-fsi_master_class-can-be-static.patch has no changelog
>           text at all, which is not ok.
>
> Can you fix all of this up, and send it as a set of normal patches so at
> least I can review the things that do not have any other reviewers on
> it?

I will do this today.

Cheers,

Joel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB616F15B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 22:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgBYVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 16:46:18 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34630 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYVqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:46:18 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so899454oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaHhaeQJNk3b1iGwrho9OQW7vTtILFRlnGdHwBGHiXA=;
        b=qEa2RI30+eu6y+QG1RZcKaHE63SwriP8FaoGgwhahp/jQ21rAuyfZyhnI39ZaQZPTK
         x+hjX7xFI4kZoMYbClW5pfDwOlru9laun8LG52dDvbs36nVfcRIuXJFMcetpsWABJkwy
         joYb3JrrYXZ548+Zal0Q8PMlSZGWpJ8BEpfeWWDdjA3JtgPwNzcOW3qFf8maZZdozYQU
         ux2WYmwTQB3ZIWRqlN5rqV5Jog6VUM0bEhy9mjUk2yD89nAIT8/dEbYlqT+pKaj4U2Dn
         0bRx+Fv2YVyzelsP/9ttTUm4knli3ewZHxsXIwT+oFehxZ9gsP9iP/b8vez+UUdwDQE0
         +OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaHhaeQJNk3b1iGwrho9OQW7vTtILFRlnGdHwBGHiXA=;
        b=E8qmpljjsiZwoVTVAYVrXx9njoPeQXBHpFawkclTcXhF1wKfl+uz2KfS2rjdSyQWBV
         U9TjsQyjMug3RipW+a2tLAGTH5MnqzYshfIiffMQpP5UDhkxQNLEyZit4GHdF4ZsPnuM
         2vbOYYfuqz4HzLQNAXAMt0lz7Y7hPJUlo2R3E5cMeODxArLW01qdyPeAcDcELjLWlWd5
         kBCfnu61/q/Er9rTADk4LgeIVvlTrJ5ILSYONiggvRidFk+LpWoxQGDHoJdvrWJDqBWI
         mgqd6RNnc1EpXTLg3gyhwYOxBudb4C2k/E3P2mCplPEqdXK2gslcbnyTUEFNxD0iJKvp
         NCbA==
X-Gm-Message-State: APjAAAV6tjJuv9to2yCKdnaFg4ImLrynGYaQkBJZthLbLzEAU14Ev9zM
        qF7UgL/B2zL/2DMuHX7vbAT6/P4300dfgSrfyu/XBA==
X-Google-Smtp-Source: APXvYqzYfJMSifN7KgTz+K+MGlTU91tf+QULFSdmvn4DI2zL4yI7bwfwIGxnV/JfXP88xbSYOEqcTpG9Tgu9zHpTakg=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr786584oih.30.1582667177181;
 Tue, 25 Feb 2020 13:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20200220055250.196456-1-saravanak@google.com> <CANcMJZBQe5F=gbj6V2ybF-dK=kRsGZT2BX9CBJiBFoK=5Hg-kA@mail.gmail.com>
 <CAGETcx88H+aFTt=Vp8Q1KVOZYEaD3D6=i5WN8tWmnBAs1YdY1g@mail.gmail.com>
In-Reply-To: <CAGETcx88H+aFTt=Vp8Q1KVOZYEaD3D6=i5WN8tWmnBAs1YdY1g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 25 Feb 2020 13:45:41 -0800
Message-ID: <CAGETcx_n=fZYaY5q6yZRJR9daTXm2Ryz5frfZr3n1BKf-pXCEQ@mail.gmail.com>
Subject: Re: [PATCH v1] of: property: Add device link support for
 power-domains and hwlocks
To:     John Stultz <john.stultz@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 3:30 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 20, 2020 at 3:26 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Wed, Feb 19, 2020 at 9:53 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Add support for creating device links out of more DT properties.
> > >
> > > To: lkml <linux-kernel@vger.kernel.org>
> > > To: John Stultz <john.stultz@linaro.org>
> > > To: Rob Herring <robh@kernel.org>
> >
> > Just as a heads up, git-send-email doesn't seem to pick up these To:
> > lines, so I had to dig this out of an archive.
>
> Weird! Left out the main person who'd care about this patch.
>
> >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Kevin Hilman <khilman@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Todd Kjos <tkjos@google.com>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/property.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> >
> > This does seem to work for me, allowing various clk drivers to be used
> > as modules! This removes the functional need for my recent driver core
> > patch series around the deferred_probe_timeout (though the cleanup
> > bits in there may still be worth while).
> >
> > Tested-by: John Stultz <john.stultz@linaro.org>
> >
> > Thanks for sending it out!
>
> Thanks for the Tested-by!
>
> Rob,
>
> Can you pick this up for the next rc?

Friendly reminder.

-Saravana

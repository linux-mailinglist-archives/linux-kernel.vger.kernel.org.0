Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F7E8DF98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfHNVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 17:03:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44500 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfHNVDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:03:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id k22so39548oiw.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQvw6+Cysy9DNZAaud1joF+LzoMS/HD7HFa+/9L4GG0=;
        b=jPBf3uDulUcoKNAc5FGbcIPpld5MB7MguGlABvefio2QnWvJq/obtoqu6LpahFZIkQ
         rM/GMVkfcRxE3U1bulrtw0Zs/k9utF6dZSbCwlX6WycAAjJgYMSbiXmThaLHRA6xThco
         HZWYFDFuZtVUJTvJgk524nTNZRqlxLibSrVV+70Nyx4Ob47dkyLqrBabX24h5YgReC+W
         t0UblEXnsWwaot5BRaD5GakbpFUgKWjS0dCY/pj1V7gaFj+wT35TLpg0S7O+vFDCztih
         CI9HH/dfo1Rjqicz02DtjCrRt8heoR+3fKr4BErk1UwzCeCQ4BdkjzhheZqxAUuD1PVj
         0IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQvw6+Cysy9DNZAaud1joF+LzoMS/HD7HFa+/9L4GG0=;
        b=J5bk6Q+XYGNScmBJMeMI8Tax5PVOh8U9ayNtv1HkdSF5KWZOuAbY85OYftJg/nUWS5
         Ys9nd6qypsavX5kWivFK5OYlUyPn3Q5x8qK8mgOsKdD3CQ/wR7de5CpmeCnuwoTNj7xd
         djnf/KbCkpPFtvZWLer6NEeB+H7gPTQAsFeqHWjvO0Zj/+tDpczan6svwLf4zn61PO9j
         0Ul2joOsmxXBWffq+kq9R5a+NeHQHsuYk4zlbS/PTW4wiVnAnqvqwqNR5gjLTeRqKDc2
         VNNXqY8grYOm5EoqJHVWUWSJolnfUdp9cpcwo3StrgKZonTvGUSIMoe5c9UPWnZEwyN9
         nMBw==
X-Gm-Message-State: APjAAAXzcvEWmnsd1nFzHDoT2iZDSVF5W9VQ1UELYvpROMeTa5N7eOjx
        KGmZd5ZX4ux6UwRjm1lo90yL4cojyglT5UV5mvE58w==
X-Google-Smtp-Source: APXvYqx3dcBMnUheir3gSBs9xUQOcTyId+C2d3MDO2QXd53RNomRiQfCtM0IPYyzSOLbYGH7WOVy7saGs2fKzMZzluQ=
X-Received: by 2002:aca:6104:: with SMTP id v4mr1341676oib.172.1565816597247;
 Wed, 14 Aug 2019 14:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com> <20190806192654.138605-2-saravanak@google.com>
 <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com> <CAGETcx8+EETv6nSu+BEBStKvbmBs+tZZgo1u_Pw8SNu+7Urq1Q@mail.gmail.com>
In-Reply-To: <CAGETcx8+EETv6nSu+BEBStKvbmBs+tZZgo1u_Pw8SNu+7Urq1Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 14 Aug 2019 14:02:41 -0700
Message-ID: <CAGETcx89sjoT0OWjhJyWtCfB_dBFTzwS9+bSSSXEbTUFygmuvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/platform: Disable generic device linking code for PowerPC
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 3:04 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Aug 6, 2019 at 2:27 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Aug 6, 2019 at 1:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > PowerPC platforms don't use the generic of/platform code to populate the
> > > devices from DT.
> >
> > Yes, they do.
>
> No they don't. My wording could be better, but they don't use
> of_platform_default_populate_init()
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/platform.c#n511
>
> >
> > > Therefore the generic device linking code is never used
> > > in PowerPC.  Compile it out to avoid warning about unused functions.
> >
> > I'd prefer this get disabled on PPC using 'if (IS_ENABLED(CONFIG_PPC))
> > return' rather than #ifdefs.
>
> I'm just moving the existing ifndef some lines above. I don't want to
> go change existing #ifndef in this patch. Maybe that should be a
> separate patch series that goes and fixes all such code in drivers/of/
> or driver/

Bump. Thoughts? I don't think changing the existing if(n)defs should
be part of this patch series.

-Saravana

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A8A3CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfH3QwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:52:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38678 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3QwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:52:11 -0400
Received: by mail-io1-f67.google.com with SMTP id p12so15391599iog.5;
        Fri, 30 Aug 2019 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFX0aYjr12ElBxGUUuhmY02XvhQTT8mqSM2FhQu+1yo=;
        b=HwFFZ19rxfnn+04b1Fr5rxhs3yfgcYVDVOTgKOICvS7Vje0P49EkKSbtocdc/9zLWl
         dxGRUNg782DyUerU+Dqk1UqTnHE6f8Ek6Te/hEbgue33eB2Du0Qs7yeWFz9gvDwFOOoL
         0wt61hfVhfQ+FcEv88vCKbX1sY4EZ0cV28FsfNkpaqgL5vHT7QeQb5m2jZXo/c/99jVz
         Qg45hz8w9fCRCb9H+9mJbJCN06R35ff7rer6FTu9xUvDSd1hTLhKsxdnIgyBonUm7QFy
         jlqtnwF1BuJy743RtUXI/EitGhKAHOIRr45QoooQUG3Sd9xyqJQa1bYTs8EDTTFUcGUn
         88Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFX0aYjr12ElBxGUUuhmY02XvhQTT8mqSM2FhQu+1yo=;
        b=cexcl1E8p71H6ubfbGbZb1KlJmSpngWTj7l73VZrdLq4ujcmO+qEjsljVShgWYEtSC
         ctQrrn0bSw1pQwW/BDZqSj+/0gekde0zZoTkRAhGiRWyNawbEqb2PfKj7mX/IHHcgYMR
         n5Ki0FYicgPSNvlb5QxoqDoH+/PqMyKGFlJgm7M11oKkcsG+uCNCcjIqBBFgSgb6QmOT
         Tcifg1lBgdCoCV21s+0aUBtGAchSjGWJlWyVuYKTca+/VTpqzjU3IXWpOVK6Eq15DNTe
         MytjwzuLlZ4cDDjx1XIqxdrA1oXVZQiZROYN5Ejw0n22zqmt6vCxk6WQKyCz2kaWcmSs
         tugQ==
X-Gm-Message-State: APjAAAVPeavTRXssxcYKRbt5IxbPa2golIUQbaSWToZKxi1G1KfrNRCl
        D4BLmT3vrWTJAJZNiBxTxOv0g0YykAvmgrMQ9nc=
X-Google-Smtp-Source: APXvYqzlWKFgDjjTrfQIk2y6OxaZynvy50zrh4t0KFl0mhFUbX+7qbK9xlyq9+st7WcODuPeEFGuzw0P4nS0q6CRW4k=
X-Received: by 2002:a05:6638:143:: with SMTP id y3mr16244129jao.68.1567183930478;
 Fri, 30 Aug 2019 09:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
 <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com> <20190830093224.GB31297@bogus>
In-Reply-To: <20190830093224.GB31297@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 30 Aug 2019 11:51:59 -0500
Message-ID: <CABb+yY1cpGVHvHz4MCwpmVXSYayWt3HWMLJKZTrCb_LXroBc_Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:32 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Aug 30, 2019 at 02:52:40AM -0500, Jassi Brar wrote:
> > On Fri, Aug 30, 2019 at 2:37 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> [...]
>
> > >
> > > If I get your point correctly,
> > > On UP, both could not be active. On SMP, tx/rx could be both active, anyway
> > > this depends on secure firmware and Linux firmware design.
> > >
> > > Do you have any suggestions about arm,func-ids here?
> > >
> > I was thinking if this is just an instruction, why can't each channel
> > be represented as a controller, i.e, have exactly one func-id per
> > controller node. Define as many controllers as you need channels ?
> >
>
> I might have missed to follow this, but what's the advantage of doing so ?
> Which can't single controller instance deal with all the channels ?
>
There are many advantages ...
1) Design reflects the reality - two smc/hvc instructions have nothing
tying them together.
2) Driver code becomes simpler - don't have to pre-populate channels,
deducting from the size of func-ids array.
3) Driver becomes more flexible - We can have channels that pass
func-id runtime and channels that pass via DT (if we must have the
option of DT property).

-jassi

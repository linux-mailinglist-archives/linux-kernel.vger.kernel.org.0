Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C952079C50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfG2WOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 18:14:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34113 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfG2WOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:14:11 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so64269126otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srsaV7rzeEymjAzgSWNLmNrniFdnk6Pa83TgYZnyX/o=;
        b=GDOHpV5z0vkTp/Hi9k2G9RgZZVziD9cVw4u/mDbabUF6fthqBEpD/8MLgeaoZ54AXl
         gp0l4hXk6AWGC2IzW4ii/4UQEBxzajmUlkfHWmKxGm24d+k5C45V0pg1L+oyVAX4YD7u
         h8NXxkhTqhfvFrBdj6h4GOpXGJxxrvxpRVDn2kNMV7WMhIA18dWbtiofquPD9NoIBfQ7
         zUVtuqXW4rzQFaGb7Feac5wlgC92z0LPraATDJ2Qo9/hSoW6qpBPmDv2n5UdUAi0DT04
         q2OHystI5so/Rgnn1bJznS4CHAiSrfhiNNdMDQZ4lT+pZ8/1qrm3uIT8I4LhsfaGG8f7
         F5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srsaV7rzeEymjAzgSWNLmNrniFdnk6Pa83TgYZnyX/o=;
        b=HOq+N7l88ll0S4cPwpBi+rEnJGmaTt2y1lCjzx1FOZxL1yWhxRDF2OdtgcUEGVatUh
         X0x+WgIm1FoP/krrnGB1erzCww09pJg5jz7DThjPcxoYMLL9rv7SEHfWby2YuUaEqh+M
         miz9jCHUjkvc0jG20hsNEzqQGAXJ0HomLNyBepvger8gVzr4WwViwyUHykrNwcd7XGov
         q482Jm72v3InquKfShCbaMg30FsKv0dTX460rzWMedG8obgX3xuBnR8FECGVzNKYc/A4
         WuP4/XnjCvKY8z/at8MOsGnLJu2kelcQU9jnHMcJZAGWrmX3llDG7ULS1qFxgfd6mYX/
         gQpA==
X-Gm-Message-State: APjAAAVNSMsKgeKo74TZZy5FWTj1dSjwePeFq5mharK9+0CTVycANa1h
        LDwAHF2iZvam59VasQIZwfdThQeRFvbBcObvc9rX+Q==
X-Google-Smtp-Source: APXvYqyuO53DWB1GnZbL8WPgAO6wYlxjhUKdDeUSsQXNzJYXk94EMFolKbpzDqKJBJk8IqgjhsI+ynp/TAB7yS3S1qk=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr85088815otj.195.1564438450498;
 Mon, 29 Jul 2019 15:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <2305283.AStDPdUUnE@kreacher> <c8960d91-4446-9acf-5575-e442a652bd05@gmail.com>
 <CAGETcx_+i6_0Q2rf-UdzZ3bCPUos9Tu4JmvvO0zUoy5gB8_ESQ@mail.gmail.com>
 <CAJZ5v0h5U60yCyaHeHVbWmwWDa4NBnuhgsV022nZm5HuGgV7ow@mail.gmail.com>
 <CAGETcx9oqAJ-VoJnD0Y8k+W8cCGPDz--=amktSgW_sB4MEngDA@mail.gmail.com> <CAJZ5v0gSyPn8sZ2jJ+nZ_nu1Y=8+7Pg+pPvKGSijUm_sKitk4Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gSyPn8sZ2jJ+nZ_nu1Y=8+7Pg+pPvKGSijUm_sKitk4Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Jul 2019 15:13:34 -0700
Message-ID: <CAGETcx-g+gbzgy0ZDKdMreRVWqnQyXLmuLRC4g5Zexyj5yThnA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Remove device link creation limitation
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 3:03 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jul 29, 2019 at 11:43 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jul 29, 2019 at 2:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Jul 29, 2019 at 10:47 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Rafael,
> > > >
> > > > This is the fix you need. Or something link this.
> > > >
> > > > I had asked you to reject DL_FLAG_MANAGED as an input flag if you are
> > > > marking it as internal (in the comments). But looks like you were also
> > > > trying to check for "undefined" bit positions. However, the check
> > > > isn't correct because DL_MANAGED_FLAGS doesn't include (rightfully so)
> > > > DL_FLAG_PM_RUNTIME and DL_FLAG_RPM_ACTIVE .
> > > >
> > > > I tried to write a DL_FLAG_EXTERNAL to include all the external flags,
> > > > but that felt like a maintenance headache that's not worth carrying. I
> > > > think it's simpler to just error out when internal flags being passed
> > > > in and ignore any undefined bit positions.
> > >
> > > Well, IMO it is better to prevent people from passing unrecognized
> > > flags to device_link_add() at all, even if that means some extra
> > > effort when adding new flags.
> >
> > It isn't so much the extra effort that's a concern, but people might
> > miss updating whatever grouping macro we use.
> >
> > >
> > > I'll post an alternative fix shortly.
> >
> > You might want to move the MANAGED_FLAGs and other grouping macros
> > into the header file then? So that if someone is adding new flags,
> > it'll be less likely they'll forget to update the grouping macro?
>
> They would need to update device_link_add() itself, so updating a
> thing next to it does't seem to be so much of an issue.
>
> Moreover, the "grouping macro" is not relevant for any users of the
> API, just for device_link_add() itself, so I'm not sure how much
> better it is to have it in the header.
>
> And, of course, if anyone forgets to update the "grouping macro", they
> will find that the new flags are rejected immediately.

Sounds good.

-Saravana

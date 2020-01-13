Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF01394D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgAMPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 10:32:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727222AbgAMPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578929563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElsdEkFyMX9PyqBKUyWZEu82iD4Q0YddLseGJka/eAI=;
        b=Ooaz6XlFmNrVJKmco00BzFbmOs7B+48bssYuHOkNAAc1PzDKN0hdLlgJvgLnBUc/n1xz/M
        X3Jd4I/iD9dQvNez1/gNr12YOpMEuhCeozBKDOTQUgMZO0e5vbYWqxsSrIh6mdfWt1wNtM
        KKArvcBTW+5ngXyzgAwsDm+UXV30GfM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-PlcLqXMtPVCMZaGERpaRRw-1; Mon, 13 Jan 2020 10:32:40 -0500
X-MC-Unique: PlcLqXMtPVCMZaGERpaRRw-1
Received: by mail-qt1-f197.google.com with SMTP id m30so6768583qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElsdEkFyMX9PyqBKUyWZEu82iD4Q0YddLseGJka/eAI=;
        b=IYm+OyL17B/+2r7oH8DBoeXhGSql/Nmr/33PZYjsT1i1UpuJsxf6ZjWfJy/zRg8wzm
         21TUjpkOtAZokPIm1TDjN9pycXlac7JV8p9LTwNcKMO6OZfpAY4Ac0M4bTKxDuxloIT+
         CGntPB8uFibJG/0VGapiZZW4KNfUq2JacQbDjFinKZl8pcXhF5jAbFFKcQ6N29+pJkRD
         jdclfQo2ILeUH0YrOJRX/N/l01bsdUlzW9X/8l6pygKIH9Serx1/Tj+Rn678yowmsT2S
         C5219WDGLfRGyVqeF0wMOtq/25wYKs8rkszZI+PUeMbPdRtU4lfn9iHl4M2uZfiEg6q2
         6ihg==
X-Gm-Message-State: APjAAAUyAkayUnzdhGDJtsnXGgKNFf/HQxHYi8SNjg+5Au7hWQXTjtn/
        aiAIQllLvY2KJZNbhlkd0lbiie1yUPyfG+JjhEEFdZACmsauo+UpbAoaYf4/0VOXVCweYsGsBZj
        Y4s9qjcZV/pChLzhrPcBwx64DZ4vppYuHeUMDfXOG
X-Received: by 2002:a37:9245:: with SMTP id u66mr12325311qkd.102.1578929560037;
        Mon, 13 Jan 2020 07:32:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqytL56xMC0vF1glxTM38WsY2Ix40Z1naBdqh2T+YigaQEOs8RJRhNMIOMubvldRvknv5G4xQqo3cppMYY9Rex0=
X-Received: by 2002:a37:9245:: with SMTP id u66mr12325263qkd.102.1578929559700;
 Mon, 13 Jan 2020 07:32:39 -0800 (PST)
MIME-Version: 1.0
References: <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
 <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
 <CACO55ttBkZD9dm0Y_jT931NnzHHtDFyLz28aoo+ZG0pnLzPgbA@mail.gmail.com>
 <CAJZ5v0jbh7jz+YQcw-gC5ztmMOc4E9+KFBCy4VGRsRFxBw-gnw@mail.gmail.com>
 <e0eeddf4214f54dfac08e428dfb30cbd39f20680.camel@redhat.com>
 <20191127114856.GZ11621@lahna.fi.intel.com> <CACO55tt5SAf24vk0XrKguhh2J=WuKirDsdY7T+u7PsGFCpnFxg@mail.gmail.com>
 <e7aec10d789b322ca98f4b250923b0f14f2b8226.camel@redhat.com>
 <CACO55tu+hT1WGbBn_nxLR=A-X6YWmeuz-UztJKw0QAFQDDV_xg@mail.gmail.com>
 <CAJZ5v0hcONxiWD+jpBe62H1SZ-84iNxT+QCn8mcesB1C7SVWjw@mail.gmail.com>
 <CAPM=9txefUg9_EO82an3b313mZz7J7-ydTuJtWD-hOQwE4QXkQ@mail.gmail.com> <CACO55tvhSM0aATBOK05-05aOc6LeN67=US2zO2jqXKWGTpUZFw@mail.gmail.com>
In-Reply-To: <CACO55tvhSM0aATBOK05-05aOc6LeN67=US2zO2jqXKWGTpUZFw@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 13 Jan 2020 16:31:50 +0100
Message-ID: <CACO55tsCRzSOz4GcLuuvGP3hfbz8gYtYXqtYHy5XCpCi3tmPeA@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Dave Airlie <airlied@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

okay.. so checking whatever is the difference with _REV being 5
(meaning the firmware uses the legacy paths) doesn't help in any way.
It's using a different method to turn the link of and the other ACPI
variables touched either point to undocumented registers on the PCI
bridge or internal ACPI memory...

so, anybody with any other ideas? I really wished the nvidia driver
would enable runpm on pre turing GPUs, but that's sadly not the case
and on Turing things seem to be totally different, so it wouldn't help
to check there as well... *sigh*

On Tue, Dec 10, 2019 at 9:49 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Tue, Dec 10, 2019 at 8:58 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Mon, 9 Dec 2019 at 21:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Mon, Dec 9, 2019 at 12:17 PM Karol Herbst <kherbst@redhat.com> wrote:
> > > >
> > > > anybody any other ideas?
> > >
> > > Not yet, but I'm trying to collect some more information.
> > >
> > > > It seems that both patches don't really fix
> > > > the issue and I have no idea left on my side to try out. The only
> > > > thing left I could do to further investigate would be to reverse
> > > > engineer the Nvidia driver as they support runpm on Turing+ GPUs now,
> > > > but I've heard users having similar issues to the one Lyude told us
> > > > about... and I couldn't verify that the patches help there either in a
> > > > reliable way.
> > >
> > > It looks like the newer (8+) versions of Windows expect the GPU driver
> > > to prepare the GPU for power removal in some specific way and the
> > > latter fails if the GPU has not been prepared as expected.
> > >
> > > Because testing indicates that the Windows 7 path in the platform
> > > firmware works, it may be worth trying to do what it does to the PCIe
> > > link before invoking the _OFF method for the power resource
> > > controlling the GPU power.
> > >
> >
> > Remember the pre Win8 path required calling a DSM method to actually
> > power the card down, I think by the time we reach these methods in
> > those cases the card is already gone.
> >
> > Dave.
> >
>
> The point was that the firmware seems to do more in the legacy paths
> and maybe we just have to do those things inside the driver instead
> when using the new method. Also the _DSM call just wraps around the
> interfaces on newer firmware anyway. The OS check is usually what
> makes the difference. I might be wrong about the _DSM call just
> wrapping though, but I think I saw it at least in some firmware at
> some point.


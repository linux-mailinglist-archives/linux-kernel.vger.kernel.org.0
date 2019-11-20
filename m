Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189EA1039EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfKTMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 07:19:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41723 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfKTMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574252383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tQSiatJZXoqislkFRtZVMOCpA4DqNNH30wH7vD5XN4=;
        b=iY+OI6TPbugU8YrTnWQQan/nA0tydHqH4MYa5t0Ks16kFz5+RDjBezCIDRyLqnpl5PdQBZ
        SHv/eNwrdJgJRkUU4L2Fl1xJ+ehB5cyJYw9iWBmMVWbX4t5fYTRtgrolCwbXsKzIoRZ5Pm
        aBzuDxx9Kp6ww54WsJtEUQw4+fILJ0g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-_ispdzZQOnyNvwnHA8MDFA-1; Wed, 20 Nov 2019 07:19:42 -0500
Received: by mail-qv1-f71.google.com with SMTP id d12so16981278qvj.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWs1Gk0ow9/Ugo0hlEi2MnfVfxY0H34jjDGUnWVNnGE=;
        b=fsGZGWJnDqAvhsustT8MJ9I/moBsR3OSwrm380yRt0k9+/lFXwFXecqjEdZxwg5MX8
         bUg+OYbSjqWW/gLmIU9d2NyJg1lY2FUUoo0CrGqYcSnN3oWSkqB+52qitJc9oHrORs4M
         +eJfIqtxz2wskqP01lmf/F29Lefw6T6HAkBraw6XUetNo4GWpDmk7KA/8YoZp+DLv6un
         DJobQF5vk9OUvzm2KT/IEKgycWHx0uK++4CaxfXWCZomnxa051jc/09BiDx4HaSCamjt
         zIo3MLPhpfcXgfeTDYiqpo8gb33Owa4bR4zhbTzfMRbAsoHLbqhEwkEEfh1187HU8wUP
         49fQ==
X-Gm-Message-State: APjAAAV1bNZUEeQilF++EYR1bMayGXAu8ULyHgBq0qViP4Ohbe5pFnBx
        Z5QckT+nmJdNPd/GL+7PPC73Py0TUJpEa7aM5IwlGuBbwYI4/mnb02umDHpUsGsRAIRMCdpzrr4
        yhtgX9TEUbt4fMwuCAN2KTPfwRwxsWgWbF/aGIMcn
X-Received: by 2002:ae9:f511:: with SMTP id o17mr2053121qkg.157.1574252382239;
        Wed, 20 Nov 2019 04:19:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYYwY32hdZJpgO9a9F96+AV3XWlzoWfPmJ3+IXJz1kjQ4tZP3raHWzLm6tC4nakFswJXw9vp47sPBOfFGfJkw=
X-Received: by 2002:ae9:f511:: with SMTP id o17mr2053086qkg.157.1574252381985;
 Wed, 20 Nov 2019 04:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com> <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com> <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com> <CAJZ5v0in4VSULsfLshHxhNLf+NZxVQM0xx=hzdNa2X3FW=V7DA@mail.gmail.com>
 <CACO55tsjj+xkDjubz1J=fsPecW4H_J8AaBTeaMm+NYjp8Kiq8g@mail.gmail.com>
 <CAJZ5v0ithxMPK2YxfTUx_Ygpze2FMDJ6LwKwJb2vx89dfgHX_A@mail.gmail.com>
 <CACO55tupFbq0T1DcR+C+YxtPR=csPBQhwVXz_SHWT5F8bRK8JA@mail.gmail.com> <CAJZ5v0h_ymqsoOVm9s2h5X0ejYdM4x03H7xPQ38uiO009OVgpQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h_ymqsoOVm9s2h5X0ejYdM4x03H7xPQ38uiO009OVgpQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 20 Nov 2019 13:19:30 +0100
Message-ID: <CACO55tu9PqhgjCEB0psaqnh+-FEOj7Y+sB_So56iHnE2kj9Z+A@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
X-MC-Unique: _ispdzZQOnyNvwnHA8MDFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It depends on the kernel being built with ACPI_REV_OVERRIDE_POSSIBLE=3Dy
and acpi_rev_override=3D1 being set on the kernel command line

On Wed, Nov 20, 2019 at 1:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Nov 20, 2019 at 1:10 PM Karol Herbst <kherbst@redhat.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > >
> > > On Wed, Nov 20, 2019 at 12:51 PM Karol Herbst <kherbst@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Nov 20, 2019 at 12:48 PM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> > > > >
> > > > > On Wed, Nov 20, 2019 at 12:22 PM Mika Westerberg
> > > > > <mika.westerberg@intel.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 20, 2019 at 11:52:22AM +0100, Rafael J. Wysocki wro=
te:
> > > > > > > On Wed, Nov 20, 2019 at 11:18 AM Mika Westerberg
> > > > > > > <mika.westerberg@intel.com> wrote:
> > > > > > > >
> > >
> > > [cut]
> > >
> > > > > > >
> > > > > > > Oh, so does it look like we are trying to work around AML tha=
t tried
> > > > > > > to work around some problematic behavior in Linux at one poin=
t?
> > > > > >
> > > > > > Yes, it looks like so if I read the ASL right.
> > > > >
> > > > > OK, so that would call for a DMI-based quirk as the real cause fo=
r the
> > > > > issue seems to be the AML in question, which means a firmware pro=
blem.
> > > > >
> > > >
> > > > And I disagree as this is a linux specific workaround and windows g=
oes
> > > > that path and succeeds. This firmware based workaround was added,
> > > > because it broke on Linux.
> > >
> > > Apparently so at the time it was added, but would it still break afte=
r
> > > the kernel changes made since then?
> > >
> > > Moreover, has it not become harmful now?  IOW, wouldn't it work after
> > > removing the "Linux workaround" from the AML?
> > >
> > > The only way to verify that I can see would be to run the system with
> > > custom ACPI tables without the "Linux workaround" in the AML in
> > > question.
> > >
> >
> > the workaround is not enabled by default, because it has to be
> > explicitly enabled by the user.
>
> I'm not sure what you are talking about.
>
> I'm taking specifically about the ((OSYS =3D=3D 0x07DF) && (_REV =3D=3D 0=
x05))
> check mentioned by Mika which doesn't seem to depend on user input in
> any way.
>


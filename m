Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A716E43BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 08:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405562AbfJYGrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 02:47:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46869 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405515AbfJYGrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:47:31 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so1122513ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FMGu1n8QDQXe7AgLj4DxpaYTvWlcS+srDbrNrliLgPc=;
        b=nNTG6fyOcQo7NQ1rdd1b0CiDebI15NvnXi3ZsV/JBm6CT2uZ9HvA/DuJRGRmGcY/EK
         Hpx+uS9geVDmKyp4YPzDtU4WPioOK0VBJgaFG4tHtQ0wlFPoreS5IiCxz7xPx3N7VPki
         tbqJDSr+UM6a7Ty6xwKIRROtO3orSO0eKRytOp7vGlScG5Oz+vhMQRvuronjn9UUYjZJ
         5Kx/u/5Dt1e91jJjjr+9OHgbrUAfEOm2HMdovOUFIIQE+DfLR0Ye+8Yk+13uJBxjSoNs
         n3yjYt/tonPA4rFIF2+5bboppjgf0wemnXmdv3LMy8nUYfRieIYdGW9Cyceq0LDi23FP
         ebYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FMGu1n8QDQXe7AgLj4DxpaYTvWlcS+srDbrNrliLgPc=;
        b=oozYNR4dL5g76dq5iBYYNfpsh1RT2NY00eYA1VQd7CqsJgXvbRdFD3YbY7yrlOzTXf
         rDAtRJ71OTZIhl09SDnfrTKLM4z6cmTuaruHZNPFjbn3O6jsLJE6Yxo5b1uhaxVdFcBE
         7u8C1ajk7HZ+o+DwcztHbwswCmrYESCtAzmcWMpbdTjNqFH25uIMUbJtTBVpJPvPRxVS
         v0BVJdnOjFf8+nVphIt3aSFFmOlr3PiPuJy3v7bppkOIfDueDERkyZJcUCp3UnlUnryR
         pN4LgUqnH7TwEQ9MOgT/CKjii5of/bUY6/Rt1PSMtJM+JShFkLw4RH11B9kwKMMlwU8B
         e5wA==
X-Gm-Message-State: APjAAAURpbS8rchcDgheZu9O4ifeo2wvh7a4d5vzOcyKepDaYXFEYHSJ
        wEHWsZC59etVALTz0yNCo+WeDQ/WJciinexnFgmxBQ==
X-Google-Smtp-Source: APXvYqwhspaNevR5WIUbk2S64QS6sKv09/9BGDd5Svp5tyDQlxLwttxMpz8aj5eYsEfBMoTFtJb2genRYVLO64i0I60=
X-Received: by 2002:a5e:c303:: with SMTP id a3mr2046955iok.175.1571986050284;
 Thu, 24 Oct 2019 23:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191022085924.92783-1-pumahsu@google.com> <20191023083221.GB8828@kuha.fi.intel.com>
 <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net> <20191023142900.GA15396@kuha.fi.intel.com>
 <20191023150126.GA16612@roeck-us.net> <20191023155757.GB15396@kuha.fi.intel.com>
 <CAGCq0LZGz04JCTEJXrBqs4ENybQih6zKWTacq9T9DKPNOQAfMw@mail.gmail.com> <20191024120346.GC15396@kuha.fi.intel.com>
In-Reply-To: <20191024120346.GC15396@kuha.fi.intel.com>
From:   Puma Hsu <pumahsu@google.com>
Date:   Fri, 25 Oct 2019 14:46:54 +0800
Message-ID: <CAGCq0LZcZUD6jUhcnRTQqtoO2MzCuv8hUndkv5Ekcq=sX7oT4w@mail.gmail.com>
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector orientation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Albert Wang <albertccwang@google.com>,
        Chien Kun Niu <rickyniu@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Sure, I will check about this.
Thanks for advising me.

Thanks in advance.
Puma Hsu



On Thu, Oct 24, 2019 at 8:06 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> On Thu, Oct 24, 2019 at 05:02:18PM +0800, Puma Hsu wrote:
> > Yes, generally this might be purely informational or be a dynamically
> > debuggable
> > mechanism for end user as I mentioned in previous discussion
> > thread(https://lkml.org/lkml/2019/10/22/198).
> > Could I know if it is not suitable that we expose a file for
> > informational usage?
> >
> > If everyone agreed above, about the definition of =E2=80=9Cunknown=E2=
=80=9D and the condition
> > =E2=80=9Cdon=E2=80=99t know the orientation=E2=80=9D, what about adding=
 additional return value?
> >   1. For original =E2=80=9Cunknown=E2=80=9D, it is a generic unknown st=
ate which can
> > indicate no
> >       matter connector is disconnected, cannot specify which cc side
> > is configured(such as Ra-Ra),
> >       or even driver can not know the orientation.
> >   2. New additional value =E2=80=9Cunavailable=E2=80=9D, it can be used=
 to
> > specifically explicate that
> >       driver can not know the orientation.
> > Take UCSI as example, it can use generic =E2=80=9Cunknown=E2=80=9D or =
=E2=80=9Cunavailable=E2=80=9D if
> > it wants.
> > But if it exposes =E2=80=9Cunavailable=E2=80=9D, then application in us=
er space can
> > know that this attribute is not useful.
> >
> > I summarize the proposal definition below:
> >  - unknown (generic unknown. driver don=E2=80=99t or can=E2=80=99t know=
 the polarity,
> >                       e.g. disconnected, both cc1 and cc2 are the same,=
 )
> >  - normal (configured in cc1 side)
> >  - reversed (configured in cc2 side)
> >  - unavailable (not support the polarity detection)
>
> Now the attribute would be supplying two types of information:
>
>         1) Does the driver know the orientation
>         2) The current orientation
>
> Let's not do that! If you really need this, then just implement the
> ".is_visible" callback with it. You just need to add a flag to the
> struct typec_capability that tells does the driver know the
> orientation or not. Something like:
>
>         unsigned int orientation_aware:1;
>
> We already "hide" the identity information if the underlying driver
> is unable to supply it. By making this attribute optional as well (by
> hiding it when it's not known), the style of exposing the information
> is kept the same throughout the class.
>
> thanks,
>
> --
> heikki

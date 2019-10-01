Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B9C2F52
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbfJAIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 04:54:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39363 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJAIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:54:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so2270386wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCMVcJHTL1rAZzsr8sC7UBxH5shgJjc8cOwozajIRmU=;
        b=uFyk/p3bEIkTDdel/ZCSZdqV7nMh2YBxg0Lzcp/K0V07uZvkv3pN1YJJebLzjgYd6N
         tDj/bBmdRRq5q6K9i4BXzb2dJ8F7RLKA4oORNy5o6+C/yWJ8RUTubCLj7vkrserUvACl
         GoGIG3aFLT4z1twhfPXk8SacX1BseglsI64eXx7wB9gM9KcXXxhjay3OEvMfdD4MBtEK
         8susq8F32cbzP+8K1Lik32U0pvsgDZO2NXxOhfzjetU6kBU7//fz+k354MP9Q1UlfvIG
         kEUEUc2WcKPHQp0bIfoHYl+YEjNy6SKIC43iwR9+Sg0n0F1pJVtvQZXJ/xB5IlWpwELK
         CszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCMVcJHTL1rAZzsr8sC7UBxH5shgJjc8cOwozajIRmU=;
        b=NgNmXmhjCWKMypLjx4qF08MLMEWm8hkRCZKbsQ9Ezkzw4Lm1b7Vz5XgtAvbDaQ0cPr
         jYAJ+MmsoZmUGgf7GBr+hcdVHbHCKmNvtnvHWT0nqnsVzATtksqKdkyWZQrG7uSMigA5
         7x1CkKbWsMKvga2BvrbRVO7KA64F7QVVRjtbxDwdCB0c+5iYDN3Ru/duZ10qFAGDNn92
         nk/kwpnKQp3xPIb0O9QqspgrSY1GEH4wXYws5JRon+UF2NeLZdXbhp+GxLZ77NxWDhUw
         ZrNZPaLFv6ZmwN5YX9SP3c5ahiFOPnOI+IVddPipaOyXmWQk8otGHUhGY7oVyT+/h6eb
         r2HA==
X-Gm-Message-State: APjAAAUbpBljTkaufv++yQmDl/C6m0moeGfJyKSmNo2eWZSW5qYxZkav
        e5PGVNU8mCXkjPXkSoWAYOlG3hbam0UgSSjSPYtMYe86j9E=
X-Google-Smtp-Source: APXvYqyKcvl41Sw5NIkOgDT2b+yl0RkNvIrnfAAemKqyZcpgreGVpLtLWgKKUHFHIcLTVadVs6hMX38D1RSVozLO5Ls=
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr2551070wma.119.1569920093430;
 Tue, 01 Oct 2019 01:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
 <20190812150452.27983-5-ard.biesheuvel@linaro.org> <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
In-Reply-To: <CAMuHMdXY5UH4KhcaNVuxa8-+GN-4bjyvCd0wzPYuFBY5Ch=fNA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 1 Oct 2019 10:54:40 +0200
Message-ID: <CAKv+Gu-KPypju6roQaVKP0DHE3aZijVVqLGwNyhiRSNqn1r6-w@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi: Export Runtime Configuration Interface table to sysfs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Narendra K <Narendra.K@dell.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 10:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ard, Narendra,
>
> On Mon, Aug 12, 2019 at 5:07 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > From: Narendra K <Narendra.K@dell.com>
> >
> > System firmware advertises the address of the 'Runtime
> > Configuration Interface table version 2 (RCI2)' via
> > an EFI Configuration Table entry. This code retrieves the RCI2
> > table from the address and exports it to sysfs as a binary
> > attribute 'rci2' under /sys/firmware/efi/tables directory.
> > The approach adopted is similar to the attribute 'DMI' under
> > /sys/firmware/dmi/tables.
> >
> > RCI2 table contains BIOS HII in XML format and is used to populate
> > BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > The BIOS setup page contains BIOS tokens which can be configured.
> >
> > Signed-off-by: Narendra K <Narendra.K@dell.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Thanks, this is now commit 1c5fecb61255aa12 ("efi: Export Runtime
> Configuration Interface table to sysfs").
>
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -180,6 +180,19 @@ config RESET_ATTACK_MITIGATION
> >           have been evicted, since otherwise it will trigger even on clean
> >           reboots.
> >
> > +config EFI_RCI2_TABLE
> > +       bool "EFI Runtime Configuration Interface Table Version 2 Support"
> > +       help
> > +         Displays the content of the Runtime Configuration Interface
> > +         Table version 2 on Dell EMC PowerEdge systems as a binary
> > +         attribute 'rci2' under /sys/firmware/efi/tables directory.
> > +
> > +         RCI2 table contains BIOS HII in XML format and is used to populate
> > +         BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> > +         The BIOS setup page contains BIOS tokens which can be configured.
> > +
> > +         Say Y here for Dell EMC PowerEdge systems.
>
> A quick Google search tells me these are Intel Xeon.
> Are arm/arm64/ia64 variants available, too?
> If not, this should be protected by "depends on x86" ("|| COMPILE_TEST"?).
>

Hello Geert,

The code in question is entirely architecture agnostic, and defaults
to 'n', so I am not convinced this is needed. (It came up in the
review as well)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1434F1361A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 21:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgAIUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 15:16:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50430 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgAIUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:16:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so4409262wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E+lwrXE3aZ94AXYYIKmBRrTAemPYlA5yIdzG6bHrsbM=;
        b=juSyx3fIemNz4CfhuztJJRSl/hZcSdBYYxa82QRPNc5ezugZgpxWIbJe8ZOAo3Y/OG
         Zh/nnA/LwkmeHKVD7+fhrraxUqdbXkIy/yzqfxMcPcER5SXWrAyKbodbiHRcDIH+Ljuw
         jaBKurW4cZD1tlk6qEhW+vkbcwBOHdbuGU5V8qYp+1KFz7/RUTucBBwEzhMSINlLG5X5
         6mNdA+hmav+o0Q3JCRsTmjgEwgDdMmcRrPQZd8Jft6uVqLuSaSZ16wAOs8zaI4+CzvDb
         Xr4BLxh34hH4LHKSqjloscJkcH30Dm0S74Y+WMf0O9hOYJc8+JEZJDiZ/iwgImwD7e0k
         R50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E+lwrXE3aZ94AXYYIKmBRrTAemPYlA5yIdzG6bHrsbM=;
        b=fU5SCFPd9tgp/FeGOqF1cieWPoTiZ5OfljX1v3AVJhdySJRh4X3DehXBPW+w6iinXe
         9Z+4lm/6V3Q+6Mp90MhcPARfrZ1XeNKWhB9qH1mg08CBCXRLXKcqjl4bsQ1E1VG+ZV2K
         m2gus72dP75qP6assUKQQATuQrYRg5vahJiH+xdID4YIwOOTgyKHPDks+wjpI1R5WnF9
         3ec7oIpqQ2aCVsAsR1JUpYklBZ3ffwgEQiWyU0VrB4O8eXtlcaPFdpanBwRNT99zdwuZ
         UU6AUfzUUcNa2miC2P6Lf3OJlwkGRV5le0pqI996cxRAGX8W2De4KMaji6iHiCzGyqtw
         CAdQ==
X-Gm-Message-State: APjAAAV1VG/RYFCjt4mNmD91gEwwNPCEnBs1Cwjqx1c2BUB2ZPAcd7Z/
        tmX9LsGqe9bXqmKwfccEjz1GTPmNdfYEWC2nkjQ=
X-Google-Smtp-Source: APXvYqyRBoQWA0EPa3ebhHv8AejJlhOoyhlMvK0QfxIl4zgcvvSGuHQ4BPXGpoSdlb3wsdh6/KtNAXpvrLOLks96BXo=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr6727312wmb.143.1578601016498;
 Thu, 09 Jan 2020 12:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20200107192555.20606-1-tli@digitalocean.com> <b5984995-7276-97d3-a604-ddacfb89bd89@amd.com>
 <202001080936.A36005F1@keescook> <CADnq5_NLS=CuHD39utCTnTVsY_izuTPXFfsew6TpMjovgFoT5g@mail.gmail.com>
 <a2919283-f5aa-43b2-9186-6c41315458c4@amd.com> <505a76a9-6110-3ddb-0f15-059b60922482@suse.de>
In-Reply-To: <505a76a9-6110-3ddb-0f15-059b60922482@suse.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Jan 2020 15:16:44 -0500
Message-ID: <CADnq5_NH0Xwhr3YjT5Ax-45-f8mmCxvfUPb8V6i34TY44BJPOA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/radeon: have the callers of set_memory_*() check
 the return value
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tianlin Li <tli@digitalocean.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 5:49 AM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 09.01.20 um 11:15 schrieb Christian K=C3=B6nig:
> > Am 08.01.20 um 18:51 schrieb Alex Deucher:
> >> On Wed, Jan 8, 2020 at 12:39 PM Kees Cook <keescook@chromium.org> wrot=
e:
> >>> On Wed, Jan 08, 2020 at 01:56:47PM +0100, Christian K=C3=B6nig wrote:
> >>>> Am 07.01.20 um 20:25 schrieb Tianlin Li:
> >>>>> Right now several architectures allow their set_memory_*() family o=
f
> >>>>> functions to fail, but callers may not be checking the return value=
s.
> >>>>> If set_memory_*() returns with an error, call-site assumptions may =
be
> >>>>> infact wrong to assume that it would either succeed or not succeed =
at
> >>>>> all. Ideally, the failure of set_memory_*() should be passed up the
> >>>>> call stack, and callers should examine the failure and deal with it=
.
> >>>>>
> >>>>> Need to fix the callers and add the __must_check attribute. They al=
so
> >>>>> may not provide any level of atomicity, in the sense that the memor=
y
> >>>>> protections may be left incomplete on failure. This issue likely ha=
s a
> >>>>> few steps on effects architectures:
> >>>>> 1)Have all callers of set_memory_*() helpers check the return value=
.
> >>>>> 2)Add __must_check to all set_memory_*() helpers so that new uses d=
o
> >>>>> not ignore the return value.
> >>>>> 3)Add atomicity to the calls so that the memory protections aren't
> >>>>> left
> >>>>> in a partial state.
> >>>>>
> >>>>> This series is part of step 1. Make drm/radeon check the return
> >>>>> value of
> >>>>> set_memory_*().
> >>>> I'm a little hesitate merge that. This hardware is >15 years old and
> >>>> nobody
> >>>> of the developers have any system left to test this change on.
> >>> If that's true it should be removed from the tree. We need to be able=
 to
> >>> correctly make these kinds of changes in the kernel.
> >> This driver supports about 15 years of hardware generations.  Newer
> >> cards are still prevalent, but the older stuff is less so.  It still
> >> works and people use it based on feedback I've seen, but the older
> >> stuff has no active development at this point.  This change just
> >> happens to target those older chips.
> >
> > Just a few weeks back we've got a mail from somebody using an integrate=
d
> > R128 in a laptop.
> >
> > After a few mails back and force we figured out that his nearly 20 year=
s
> > old hardware was finally failing.
> >
> > Up till that he was still successfully updating his kernel from time to
> > time and the driver still worked. I find that pretty impressive.
> >
> >>
> >> Alex
> >>
> >>>> Would it be to much of a problem to just add something like: r =3D
> >>>> set_memory_*(); (void)r; /* Intentionally ignored */.
> >>> This seems like a bad idea -- we shouldn't be papering over failure
> >>> like this when there is logic available to deal with it.
> >
> > Well I certainly agree to that, but we are talking about a call which
> > happens only once during driver load/unload. If necessary we could also
> > print an error when something goes wrong, but please no larger
> > refactoring of return values and call paths.
> >
>
> IMHO radeon should be marked as orphaned or obsolete then.

As I said this covers about 15-17 years of GPUs (~60 asic families).
The older stuff is hard to test these days because it's PCI or AGP
hardware.  So far it works for most people.  The newer stuff is still
tested as used regularly.

Alex

>
> Best regards
> Thomas
>
> > It is perfectly possible that this call actually failed on somebodies
> > hardware, but we never noticed because the driver still works fine. If
> > we now handle the error it is possible that the module never loads and
> > the user gets a black screen instead.
> >
> > Regards,
> > Christian.
> >
> >>>
> >>>> Apart from that certainly a good idea to add __must_check to the
> >>>> functions.
> >>> Agreed!
> >>>
> >>> -Kees
> >>>
> >>> --
> >>> Kees Cook
> >>> _______________________________________________
> >>> dri-devel mailing list
> >>> dri-devel@lists.freedesktop.org
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D02%7C01%7C=
christian.koenig%40amd.com%7Ca542d384d54040b5b0b708d794636df1%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637141027080080147&amp;sdata=3DEHFl6YOHmNp7=
gOqWsVmfoeD0jNirBTOGHcCP4efC%2FvE%3D&amp;reserved=3D0
> >>>
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>

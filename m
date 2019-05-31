Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460F930829
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 07:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEaFyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 01:54:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46809 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 01:54:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id m15so72150ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 22:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GllCVJwBmSJ5xm+XHz/j+wcFQRvZuHF7tMv6o6dZGIk=;
        b=mjoJn31R+qYwPa3s/SdgvH564zjFYyLEr/g9MbeCd9OXUDomc8c8QPyKC6p+oLf6VD
         dTZZM6Kx7Wcj5ziRyiCXUAkB4YGnjauwKdwnAKNeFt33o/bA+CMBPHOUJllIhMyxO2HI
         W8S/exYTZf1wc6/vlkjohmhBFF5gWZzuU0Ee9OF5rN0272fybN76znLWnRyCLTA+tSLR
         rO/YAjJ0wMyMtKApbulldIBA+IgjaW447dq/ObfVdKrny+UAeRST69WdyCgn2X9E4BCm
         FJsIQZUINV9ZUBNfg9p4dsDhX44x5fJc+ma1g3VqkQgoApaN7UXT+40dj0EhGGQYEYlr
         ZGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GllCVJwBmSJ5xm+XHz/j+wcFQRvZuHF7tMv6o6dZGIk=;
        b=qUnBXn8vmTPLu9zcoIKFGsTFdfSTqeQY+4T2jp9917f62UfHuNy8p5DyXc7r3DmT1A
         x5+NxKNAWR4ZknoVj21oz0gLPrAuDvNYFGB4s+WH09VWq+otdmG3Ie2WUaAbWtt1MDPK
         kan3YDNQxYhsjm1RN0Zi0gwxmWIBr0UfcnUWvFCTQUPDUYDZdf/qIt8Six66g2sf5GO3
         fdd57uazIAG+10UFiKJqyj5MbFEJN749KFrFUemO/1OPWlqHO9kWYMIJYszA1+CYJA3a
         dFrHqYiZmBNI+38PuXuCqkj4lVOS6xcGf6YZZLJg8BsAeXbxDCq5ILBQ6y4fYyeedgVl
         ht9g==
X-Gm-Message-State: APjAAAVuo9veAlekqd60lgTv7KwxX0DKQRAYGB5rztZFCIbw9qYTVMHu
        3Qeae1KebtX4VGRUfCboOoXMz/k79CFlJOh0vdbetYH+u40=
X-Google-Smtp-Source: APXvYqxMB0mEi9bZJgUS4OWjsOD8NP3QGbTE7NULcHFSyr+5IJY05+d21P9f5CRoq8WqrMPe26DeI1GoU1EgDnOxXbI=
X-Received: by 2002:a2e:92cc:: with SMTP id k12mr4531794ljh.16.1559282087733;
 Thu, 30 May 2019 22:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190529224350.6460-1-mikewu@google.com> <20190530192208.99773-1-mikewu@google.com>
 <alpine.LRH.2.21.1905310611190.26428@namei.org> <201905301921.AE6D8D1@keescook>
In-Reply-To: <201905301921.AE6D8D1@keescook>
From:   Ke Wu <mikewu@google.com>
Date:   Thu, 30 May 2019 22:54:36 -0700
Message-ID: <CANRnR9TTCnyfCJ0bFu9F1m_J=31bE30=DASUUKAJByEDWbD4nQ@mail.gmail.com>
Subject: Re: [PATCH v2] Allow to exclude specific file types in LoadPin
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Jonathan Corbet <corbet@lwn.net>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for pushing the patch!


On Thu, May 30, 2019 at 7:23 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 31, 2019 at 06:11:44AM +1000, James Morris wrote:
> > On Thu, 30 May 2019, Ke Wu wrote:
> >
> > > Linux kernel already provide MODULE_SIG and KEXEC_VERIFY_SIG to
> > > make sure loaded kernel module and kernel image are trusted. This
> > > patch adds a kernel command line option "loadpin.exclude" which
> > > allows to exclude specific file types from LoadPin. This is useful
> > > when people want to use different mechanisms to verify module and
> > > kernel image while still use LoadPin to protect the integrity of
> > > other files kernel loads.
> > >
> > > Signed-off-by: Ke Wu <mikewu@google.com>
> > > ---
> > > Changelog since v1:
> > > - Mark ignore_read_file_id with __ro_after_init.
> > > - Mark parse_exclude() with __init.
> > > - Use ARRAY_SIZE(ignore_read_file_id) instead of READING_MAX_ID.
> >
> > Looks good!
> >
> > Reviewed-by: James Morris <jamorris@linux.microsoft.com>
>
> Thanks! Applied to my for-next/loadpin branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
> and should be visible in linux-next in a few days.
>
> --
> Kees Cook



-- 
Ke Wu | Software Engineer | mikewu@google.com | Google Inc.

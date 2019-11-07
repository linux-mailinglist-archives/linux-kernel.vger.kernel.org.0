Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9011AF3BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 23:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfKGWta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 17:49:30 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34110 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfKGWta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:49:30 -0500
Received: by mail-il1-f195.google.com with SMTP id p6so3383656ilp.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 14:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ffzpUwIorM0GYm+otb4yX6nA1X5rclBWmv4V/VNNQzk=;
        b=egbcvsTLdseg/9piyzK+5ahhYoTrNpWwJ3jxektx+Gk/J8c2U6vNqUFHkU5uM/SwnN
         8jAh6qpHN6CSM4bM6olgDTM0ofDGFafXENoH5j4qD1QO2ghR2Eh4up3fAz3TFiAEvaUU
         Qb9irL/Xhk3/6jrfaYvAKrryE0NJCJ0aR0W8SwacAQUKX4KkFSWH0qH4NkLRrkzdW7f5
         ytE0lO9Stvd4Bs2NedPSEWxJe4oybuX0E0sVgHs7VoTrrrbTEUhSHIywjVNCF4krP6uC
         015Xb03w5dFFbvcYtWWAHSAy3mM63YxAIk+zcLjOydWc3xbXdWGEgzthZUZt/PtXsNJ6
         mUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ffzpUwIorM0GYm+otb4yX6nA1X5rclBWmv4V/VNNQzk=;
        b=RLadVPgLPF/OGdipXfjpuJtje5c0OYz//d6AyVOsy49tb3CPsZPzH+EpoU4YguieID
         T4a10beqrpIx2ZCOs3EFKyMKXxJ1OGQ2HGyVfT8bhSsJalHhPjxwNM+KQobWEEV1L3J/
         UIwj9UhYZKh38pEunbFy3gf5VyCj2QWsK4wtDmje5uGlWtVksjwxuyIDgKmqjoQceWVX
         fO0rnaDmxH5reA/6QJwTXUHV2Zx4dRfvsoynUH1PBoQ5dMOoi7iaffZjfxw1gn5O6YQF
         GHKtXJF3WZpb1UddDPy4OIliYpXw0Wq+sikv337k90lPSTmdu5FG9dw3VaLRtyiC+m5O
         Iqqw==
X-Gm-Message-State: APjAAAWq5jHQ7xKx3OA/iTHZqDVWa/eOCE0zK9CRL/SSc5Tce9HV+TvW
        iiBH6SEkZub+0MeKGXcklS2CNl/x6Hf9IS/aCJk=
X-Google-Smtp-Source: APXvYqxSPQJatDOPCGIaQj/EifeCJ7gwe6kD7ks74Sjs6Z494AAHFaH4vrmZdLR3Ex/RpgwKGevVhQ4/EBGsMLNNvVs=
X-Received: by 2002:a92:9ecd:: with SMTP id s74mr7972872ilk.145.1573166968704;
 Thu, 07 Nov 2019 14:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20191107222047.125496-1-helgaas@kernel.org> <20191107222047.125496-2-helgaas@kernel.org>
 <CAKb7Uvjj+18cAFW+yBEHWkJLXVTHVMW=zJ-V+uqpzdbcEKsHrQ@mail.gmail.com>
In-Reply-To: <CAKb7Uvjj+18cAFW+yBEHWkJLXVTHVMW=zJ-V+uqpzdbcEKsHrQ@mail.gmail.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Thu, 7 Nov 2019 16:49:17 -0600
Message-ID: <CABhMZUWFZ7M1wpnWaTs3+OsWqN8Nq6c8zyCCSxXbq0qZSjvgnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: replace Compliance/Margin magic numbers with
 PCI_EXP_LNKCTL2 definitions
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederick Lawler <fred@fredlawl.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 4:30 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Thu, Nov 7, 2019 at 5:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 29d6e93fd15e..03446be8a7be 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -673,6 +673,8 @@
> >  #define  PCI_EXP_LNKCTL2_TLS_8_0GT     0x0003 /* Supported Speed 8GT/s */
> >  #define  PCI_EXP_LNKCTL2_TLS_16_0GT    0x0004 /* Supported Speed 16GT/s */
> >  #define  PCI_EXP_LNKCTL2_TLS_32_0GT    0x0005 /* Supported Speed 32GT/s */
> > +#define  PCI_EXP_LNKCTL2_ENTER_COMP    0x0010 /* Enter Compliance */
> > +#define  PCI_EXP_LNKCTL2_TX_MARGIN     0x0380 /* Enter Compliance */
>
> Without commenting on the meat of the patch, this comment should
> probably read "Transmit Margin" or something along those lines?

Indeed, thank you!

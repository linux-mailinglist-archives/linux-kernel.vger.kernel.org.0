Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF651AB948
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393326AbfIFNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 09:31:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45851 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388784AbfIFNby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:31:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so1920787oti.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2e7BdIjA7tp8BLDXeTA/WaYjf5EqoeihfbnfZF6VGmM=;
        b=PHfICUeS2mGCEh2CUf3C4hLmGAZ/WIw5tAL4fbOBgvE0Y8Ltf9mXNE3/ktZvwiHkB/
         dFroiYLtzUzJrSiZFcu/QpXoDOSrvwWUQ0H3FFFkdXSseWIf2bDhqlGbc2qbRZ9oAXuP
         MGgVx6djL4ok5HVHhvhpy0lUn0ocg2WuN1gW/IIFZ0ZI3Uw3w4gBtrrG1ljJIdFozS4J
         E3gb7oNUQcRxPkaKWpXR2gFZt3fZqSNRuQUOxJFDOyVR6ESPYtAdrOdZvsgasgM/e3uv
         S9KxhITdI8qURQHjP4qbzOcYpPXrElyuyt6BAQB+J1zNYBrAx+CQZoknoBo6x+/jcUvZ
         5lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2e7BdIjA7tp8BLDXeTA/WaYjf5EqoeihfbnfZF6VGmM=;
        b=tIE7zdQ2IagwjFCdnZRaNpJzqZlFOAGY+GniYi6k/r1y7LLT6R+8AAz7JinLf0gBPD
         i4aCILpJESEhWlaN5Wi2VNg0LpQob8orWhsROvxv2iGKjYVg7amoIYIG/aQcJ11gT5ut
         om6L1WBn3gquQHzhuNbCSFGiELJnd+MzH8GMgafDs+JrDl/IXQHrOEdGyGCXoYOz+pmS
         5mrM+nBZhu/OHvFKbWsbp3mKyZRqjflnhnUnZqlzyiOJ6widy5Tjv5nahAQhn6evH5bT
         f+LrKBqk2rJqCNYKftJnRtsmn7FmGvKJ+Lu3CSESpwBsmWBWq6cNpbuI6eXcX1dKDwa+
         aPbA==
X-Gm-Message-State: APjAAAXk9sB0pTv86blkH9yla1XU6ztsi2WldiITLYYj6cJKxmsBoqJT
        6ZlCzqiCJHqxMXQ2lTJvxBJd/nYkT8T03+IS8rDq5A==
X-Google-Smtp-Source: APXvYqwHxB0tCnJPTv4Q3uXRBF5mEn1yIopnVEF/pkDXQ5Kdt3akKBuuprc79qQjbky6hEBpVz6/HyR6CfvcxPFrepI=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr4739602otq.97.1567776713698;
 Fri, 06 Sep 2019 06:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190904180736.29009-1-xypron.glpk@gmx.de> <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
 <86mufjrup7.wl-maz@kernel.org> <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
 <20190905092223.GC4320@e113682-lin.lund.arm.com> <4b6662bd-56e4-3c10-3b65-7c90828a22f9@kernel.org>
 <20190906080033.GF4320@e113682-lin.lund.arm.com> <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
 <20190906131252.GG4320@e113682-lin.lund.arm.com>
In-Reply-To: <20190906131252.GG4320@e113682-lin.lund.arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 6 Sep 2019 14:31:42 +0100
Message-ID: <CAFEAcA9vwyhAN8uO8=PpaBkBXb0Of4G0jEij7nMrYcnJjSRVjg@mail.gmail.com>
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be decoded
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     Alexander Graf <graf@amazon.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 at 14:13, Christoffer Dall <christoffer.dall@arm.com> wrote:
> I'd prefer leaving it to userspace to worry about, but I thought Peter
> said that had been problematic historically, which I took at face value,
> but I could have misunderstood.
>
> If QEMU, kvmtool, and whatever the crazy^H cool kids are using in
> userspace these days are happy emulating the exception, then that's a
> viable approach.  The main concern I have with that is whether they'll
> all get it right, and since we already have the code in the kernel to do
> this, it might make sense to re-use the kernel logic for it.

Well, for QEMU we've had code that in theory might do this but
in practice it's never been tested. Essentially the problem is
that nobody ever wants to inject an exception from userspace
except in incredibly rare cases like "trying to use h/w breakpoints
simultaneously inside the VM and also to debug the VM from outside"
or "we're running on RAS hardware that just told us that the VM's
RAM was faulty". There's no even vaguely commonly-used usecase
for it today; and this ABI suggestion adds another "this is in
practice almost never going to happen" case to the pile. The
codepath is unreliable in QEMU because (a) it requires getting
syncing of sysreg values to and from the kernel right -- this is
about the only situation where userspace wants to modify sysregs
during execution of the VM, as opposed to just reading them -- and
(b) we try to reuse the code we already have that does TCG exception
injection, which might or might not be a design mistake, and
(c) as noted above it's a never-actually-used untested codepath...

So I think if I were you I wouldn't commit to the kernel ABI until
somebody had at least written some RFC-quality patches for QEMU and
tested that they work and the ABI is OK in that sense. (For the
avoidance of doubt, I'm not volunteering to do that myself.)
I don't object to the idea in principle, though.

PS: the other "injecting exceptions to the guest" oddity is that
if the kernel *does* find the ISV information and returns to userspace
for it to handle the MMIO, there's no way for userspace to say
"actually that address is supposed to generate a data abort".

thanks
-- PMM

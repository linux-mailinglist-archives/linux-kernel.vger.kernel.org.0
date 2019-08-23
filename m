Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01249AE0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 13:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfHWLZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 07:25:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37914 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387483AbfHWLZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:25:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so8740852wmm.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2op3y+Z3X9zLwGWh5yuPCvqGBI0kNPuqyjux0dDAk8w=;
        b=aXeXefReU5hfFqxXgBXsV18a8odcYZXiwtAX5xokTAFEUr8r7Lhl2b/S7YxXNi6r8p
         n6FaMzY3lRdWRdBYqzfE7s4dbycNU98P8HZEgR1PHig9lMZFRcat/YCPkdx10UjouI8s
         9xp6M1+9utA+35p2ezpNZMVjSe6v/haZnkoLjx8j+l08IPugdvYR2mAQ5LUodYmA13ly
         6p7z/nFxYGz5m3gbMXZiXMrDWmsGAy9gLrkt92WWuGjsypHaUfv56sNObKze+U88M+Vw
         fHGrSDzchUBtV7QgvNBWcX+LZCJTZUUZ8nlM6BT8hSmOKA/dTouDxvJ+7Mh8/oeavyIE
         yMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2op3y+Z3X9zLwGWh5yuPCvqGBI0kNPuqyjux0dDAk8w=;
        b=E6LstXjQftGJm9HOaAygVmJjwBIpxI4GUrofMjGtAYo1GoPc8tQYm1FRGUuo8dR/tR
         X45UHfrwG3gF/McUEyPT6S5oKYtYWszt70lRzozOAbBN5/SrCsRQE5vxETUpUZzoBFUl
         5mmGE6Gxf7ozhTeV0R/3ysUI1MRY6id0TI9P6buF0qzv0YIqDIccbmo3IuunpnOwvsnF
         NhJSLwNDQ0+LEX4WXo6Qd7+ChfBkRs9fLbysyHKwWQmycuEi/rMA/obA4Le7Qp6qHBvJ
         kWZACPElnztYuu8pXPK2iKOjM9C8eRvkkl4d6KDOdGya6MAhSmdwo+/NSzQ54vsPEInh
         jG+A==
X-Gm-Message-State: APjAAAX7HqiC0JGoSEcTKNe8G1erqNjogxXyNERxZrCt/dOF4S0QsCo1
        RHt965mtEnBY/S24G4VCmyslLAr/E8jIHP/JG0xzBA==
X-Google-Smtp-Source: APXvYqycI41rK57NbAfGj4CZHgSbW6grDpjvAoH0BFDYwOsJIrsS4OcpuzhTo+8XrddhShRkR73OeGttOUX30LY+zAU=
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr4648907wme.103.1566559546115;
 Fri, 23 Aug 2019 04:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190822084131.114764-1-anup.patel@wdc.com> <8a2a9ea6-5636-e79a-b041-580159e703b2@amazon.com>
In-Reply-To: <8a2a9ea6-5636-e79a-b041-580159e703b2@amazon.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Aug 2019 16:55:34 +0530
Message-ID: <CAAhSdy2RC6Gw708wZs+FM56UkkyURgbupwdeTak7VcyarY9irg@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] KVM RISC-V Support
To:     Alexander Graf <graf@amazon.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 1:39 PM Alexander Graf <graf@amazon.com> wrote:
>
> On 22.08.19 10:42, Anup Patel wrote:
> > This series adds initial KVM RISC-V support. Currently, we are able to boot
> > RISC-V 64bit Linux Guests with multiple VCPUs.
> >
> > Few key aspects of KVM RISC-V added by this series are:
> > 1. Minimal possible KVM world-switch which touches only GPRs and few CSRs.
> > 2. Full Guest/VM switch is done via vcpu_get/vcpu_put infrastructure.
> > 3. KVM ONE_REG interface for VCPU register access from user-space.
> > 4. PLIC emulation is done in user-space. In-kernel PLIC emulation, will
> >     be added in future.
> > 5. Timer and IPI emuation is done in-kernel.
> > 6. MMU notifiers supported.
> > 7. FP lazy save/restore supported.
> > 8. SBI v0.1 emulation for KVM Guest available.
> >
> > Here's a brief TODO list which we will work upon after this series:
> > 1. Handle trap from unpriv access in reading Guest instruction
> > 2. Handle trap from unpriv access in SBI v0.1 emulation
> > 3. Implement recursive stage2 page table programing
> > 4. SBI v0.2 emulation in-kernel
> > 5. SBI v0.2 hart hotplug emulation in-kernel
> > 6. In-kernel PLIC emulation
> > 7. ..... and more .....
>
> Please consider patches I did not comment on as
>
> Reviewed-by: Alexander Graf <graf@amazon.com>
>
> Overall, I'm quite happy with the code. It's a very clean implementation
> of a KVM target.

Thanks Alex.

>
> The only major nit I have is the guest address space read: I don't think
> we should pull in code that we know allows user space to DOS the kernel.
> For that, we need to find an alternative. Either you implement a
> software page table walker and resolve VAs manually or you find a way to
> ensure that *any* exception taken during the read does not affect
> general code execution.

I will send v6 next week. I will try my best to implement unpriv trap
handling in v6 itself.

Regards,
Anup

>
>
> Thanks,
>
> Alex

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5551C131934
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgAFUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 15:19:04 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44077 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgAFUTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:19:03 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so7175395iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=On8S/jqcqhWm1gA75kni93hxDaFgmyxXA8OYLeg6pRw=;
        b=pj5xEWC2k1f0PDOEDl4ycNhV9/3mEeqCFoZlQ6jKJtbe77lzXp8pzFq26ztwSG9V+V
         Kq/A6Em27Lt9MrhZKAC3Nw+qJogSJDU9M+w73gCuds+KJEOjYORSWyCbiG2QNVIx8nAX
         MZk0LhnqI+m2EvlcOCUkv20bX9qw8Cv39Bbtnby/EMmb+Sz8+HwI13s1a8U7X01f3Hq1
         Dxc9ndFQw4DlH2N3jG1H/6eSOiNhnSd90uRIh8ZzcvSAmwqHzqDwPOL5T3ZPKWp5y7bf
         QZqCDDlB3FxjzOcqPePxq8ksuPYFPL0YS0AO41kD+eoBlTCpPDcnrZYkyCnkzbl5sgLy
         OJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=On8S/jqcqhWm1gA75kni93hxDaFgmyxXA8OYLeg6pRw=;
        b=EUo3kEERnAlJQ+criiZIt7FV4fHjU47Yb07+tnlQSSBbvNz+vwrnQJkrfTWzQAz35j
         cGrEPFXgqLqf/Qsfg6FhkGWPIwd9xdbtOa/GVqoz07GwONTm7aSU9wMDRgpxRr6kewCN
         O47GgJLAE+avdhRS4L4EkK0VD9B+YJxWiN5bGMmSuND/qBOSGIxPYZqqt1+VpffwxsOQ
         HC68WBeTbko14wIsJCdxgfB1RfL874XyiVJVTea5jLtFxpXTHD1BA2HjA2ZRMSFGaL3w
         TZsnZ9/teiVsyIUI70OpZqsabgY+WMNa6yzN9U8+VXBpjl3Jh0Hfar3uarmZO/TOXdRK
         sJNQ==
X-Gm-Message-State: APjAAAXuTIJrWmEHwznEzbD+wo57iaX2COeA4uXBYmh4LSxtpGnKCeuo
        mY5KGxa2hlpCXELUT8V+R2grcuDbR+m3yB+MJtaj0A==
X-Google-Smtp-Source: APXvYqw/uA456NSw77dxi0HDBubRLZXT5catRpIZeEV7h/AuDPtK8k5E+UuB/HK9diCwlWzkyenxKNoQyTYwehnh+ls=
X-Received: by 2002:a92:3b98:: with SMTP id n24mr67439328ilh.108.1578341942677;
 Mon, 06 Jan 2020 12:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-10-pomonis@google.com>
In-Reply-To: <20191211204753.242298-10-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:18:51 -0800
Message-ID: <CALMp9eRTLMM17nVvGD9P38uP=886hgck1YabpnPXqyuFb1n0Jg@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] KVM: x86: Protect MSR-based index computations
 from Spectre-v1/L1TF attacks in x86.c
To:     Marios Pomonis <pomonis@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:49 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes a Spectre-v1/L1TF vulnerability in set_msr_mce() and
> get_msr_mce().
> Both functions contain index computations based on the
> (attacker-controlled) MSR number.
>
> Fixes: commit 890ca9aefa78 ("KVM: Add MCE support")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>

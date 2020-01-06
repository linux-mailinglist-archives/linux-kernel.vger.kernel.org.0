Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87A131926
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 21:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAFURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 15:17:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33098 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:17:49 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so49947674ioh.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ns8GnqwvJg6p4W/syDLUnvePjgs3xerHY20r9Gnc+74=;
        b=clap+ZSlRXw7zp6m90XHVxIDTEjjE9mcltqn7nwhdOy1qAuizA7p54MDYDj3llqhCi
         nJzjNDYwgjjHbTHFIIjbXd9dbOFEWGnu0h83h98/mByZ9oQizwnh0Y5O0zE4RXdBf2E+
         8YrSYyt7ItVEBkpoa5mDBPnC50hGe0Gus6v0OSA9Va1MDXhWqTJxCeN7Cz8XtS890KKT
         NmByMQvlHmLA6ZVfU3rg/ij2JzS7BlH9Exko0AolIcxWcx521GuR3QaU+OCjwIjF9lx9
         /OYjh5668bwPU952Ni87MV/24z2NHt8c/rW0AQ06SmzZtKB/BqiJWof+ycJDMSFnQVrW
         pq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ns8GnqwvJg6p4W/syDLUnvePjgs3xerHY20r9Gnc+74=;
        b=neKXrQoF4hl1kKWAvs8FV2EGletlmedqS9TDndB0h81IZiUEi1GAPEj0Ua8+PVNNgf
         Vw9/ilZwsEXdFjTamfIFIkHUbvX301Lq9aDjqiQA4oi193lq4bNKZgtyR6Fo+eeCTjG4
         lN2af6yM90WNrEXzsRMPLwursTVxwcztTG8M3xnkQI0Vgs4CoetaQDmPNdcoylJqVlWS
         NCGRMad/tb/GHjJw36fgqZLLCko+cJMJLO6nwoexnFLUMtVKTbHfIGs+roJe3HlOrKes
         Mx9a80W5VgiuvIFmBVQ4QE+FP3ZBRkt+5x4Wur1iLA0eCrO4UoAF6nZ0rfdUC1Tzi36M
         a4KA==
X-Gm-Message-State: APjAAAXXGImXdOa14LdWHJePzqLKDZtQKd9QAuHR+EGlz3RqbSnG8l4i
        G4FSQadElCh7/xnXV4pt6y8pMJewhYs+TrF4mdNc1g==
X-Google-Smtp-Source: APXvYqxoZQ+6xjPL1kVSOGms8Zqaps/r0K/FNO33q2IPJVDh7QsN/goJF73XELIobJtwflx3BGbam+GNuwZyL1L5h7E=
X-Received: by 2002:a5e:924c:: with SMTP id z12mr69658990iop.296.1578341868753;
 Mon, 06 Jan 2020 12:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com> <20191211204753.242298-6-pomonis@google.com>
In-Reply-To: <20191211204753.242298-6-pomonis@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Jan 2020 12:17:37 -0800
Message-ID: <CALMp9eTrGnn7NmBS_-Zpxk0LP4b-NKCEYu46AoEGjH=k_=Hoxw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] KVM: x86: Protect ioapic_write_indirect() from
 Spectre-v1/L1TF attacks
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

On Wed, Dec 11, 2019 at 12:48 PM Marios Pomonis <pomonis@google.com> wrote:
>
> This fixes a Spectre-v1/L1TF vulnerability in ioapic_write_indirect().
> This function contains index computations based on the
> (attacker-controlled) IOREGSEL register.
>
> This patch depends on patch
> "KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks".
>
> Fixes: commit 70f93dae32ac ("KVM: Use temporary variable to shorten lines.")
>
> Signed-off-by: Nick Finco <nifi@google.com>
> Signed-off-by: Marios Pomonis <pomonis@google.com>
> Reviewed-by: Andrew Honig <ahonig@google.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Jim Mattson <jmattson@google.com>

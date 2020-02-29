Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE6ED1748CF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 20:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgB2TA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 14:00:57 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42034 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgB2TA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 14:00:57 -0500
Received: by mail-il1-f193.google.com with SMTP id x2so5802380ila.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 11:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPm3hrGauL8biCEinhFnHGuE8NuHgMpT90ceO6W2+s4=;
        b=QJRcbgBgFWGY+IrI2mhQ7YcO+C450KRWfGWjarnZjMkLID6dMBo3yjnc+lQd0ydDFn
         Klpp6Lriyv205JzqPsR25dMpi5rZ4lQ2RpeJeqCd19TrmhuTHzLDDTb5Nq/8PMZMN9Wn
         ugiLU+5PnffMZMQ26oBpkrsEmuM5q72VpN9VNh4jrHvx7liqcf5GMjVURgiRgRjV5FA2
         4ZXZKXSKZQnNOBnvBSiF0uqAwELvZbZjFgLwrwfB6WvEmoZGbcqZQGaotUqc1I0tMNOK
         3golkHykUqQeytTOq9wxrN+T+s2keqAK8gMUmLBCp9A8HSp6ARkP+5O0d0I3bDPu+sMM
         C0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPm3hrGauL8biCEinhFnHGuE8NuHgMpT90ceO6W2+s4=;
        b=QqBjq1e7eDh7DjukcVUGO8ljRSR8xXEES7ihwSxhUUUgVryiAfNc50WOtTO/KjBWmy
         BZ1bSIbUDjFJaY/IW4eWh2ebc2hEoNIjjQSuMHrWhJ1Pp68mrN5QZN0k8D3yP2hnQLZR
         kCB0KmXJ2f7iWo+M8CuMKWFJLDKh3fuKbVc99w3DHUDu8irYE4+6+2xEc+XtMxVSWNu/
         vUYkfC1fJVVTA8O4R7vbGCnQfBVzOLO4AiHdmI28wBJquEZaKq7tNch5fJ/dT2tcS9Qn
         6qpDlS1NJMHOTs+FRB4xpVFkRQl2oHz3yomyuLhuEsNjpsToQWe57zCStAAC4D+OI9yz
         Faxg==
X-Gm-Message-State: APjAAAXjfIRhGIA+PQ7Q2B6tnEer51JGddJPZYcBNKgbnec3m9397xcF
        hWDTdnRNI+RiIaa7t+yI/pEOiSCVpaNk6va+fS95/g==
X-Google-Smtp-Source: APXvYqzrtg94iuKISLZUq15kVQq0EevQ7IO9b8IvdausgoC11wtDjBdvYeDl00RI2xRJ3xxCbc1E/KnknBPk4DBeVq8=
X-Received: by 2002:a92:981b:: with SMTP id l27mr9968372ili.118.1583002855957;
 Sat, 29 Feb 2020 11:00:55 -0800 (PST)
MIME-Version: 1.0
References: <1582570596-45387-1-git-send-email-pbonzini@redhat.com>
 <1582570596-45387-2-git-send-email-pbonzini@redhat.com> <41d80479-7dbc-d912-ff0e-acd48746de0f@web.de>
 <CAOQ_QshE7SMX2cO7H+21Fkdpg53oE2D3xrHPJHR_MCfH4r9QCQ@mail.gmail.com>
In-Reply-To: <CAOQ_QshE7SMX2cO7H+21Fkdpg53oE2D3xrHPJHR_MCfH4r9QCQ@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 29 Feb 2020 11:00:44 -0800
Message-ID: <CALMp9eRETy1RLWHWKtFHqpcpFHbQKtPgJHDD_N+LPzaUPx-Jvg@mail.gmail.com>
Subject: Re: [FYI PATCH 1/3] KVM: nVMX: Don't emulate instructions in guest mode
To:     Oliver Upton <oupton@google.com>
Cc:     Jan Kiszka <jan.kiszka@web.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:33 AM Oliver Upton <oupton@google.com> wrote:
>
> Hi Jan,
>
> On Sat, Feb 29, 2020 at 10:00 AM Jan Kiszka <jan.kiszka@web.de> wrote:
> > Is this expected to cause regressions on less common workloads?
> > Jailhouse as L1 now fails when Linux as L2 tries to boot a CPU: L2-Linux
> > gets a triple fault on load_current_idt() in start_secondary(). Only
> > bisected so far, didn't debug further.
>
> I'm guessing that Jailhouse doesn't use 'descriptor table exiting', so
> when KVM gets the corresponding exit from L2 the emulation burden is
> on L0. We now refuse the emulation, which kicks a #UD back to L2. I
> can get a patch out quickly to address this case (like the PIO exiting
> one that came in this series) but the eventual solution is to map
> emulator intercept checks into VM-exits + call into the
> nested_vmx_exit_reflected() plumbing.

If Jailhouse doesn't use descriptor table exiting, why is L0
intercepting descriptor table instructions? Is this just so that L0
can partially emulate UMIP on hardware that doesn't support it?

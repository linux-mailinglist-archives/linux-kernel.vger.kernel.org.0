Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B694159BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 23:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgBKWMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 17:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBKWMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:12:18 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE7E20870
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581459138;
        bh=yNqZod946paujAdEqMRJ1ejAWBjSCe4eeJhwXaauReA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CIBIe+lFFTrJtJr5PAHqlakYHlpJHZ8/IxM6nu6BnvrvP7QlnGB0UYifJ+cLbPD1u
         h1S/MFtkHV/kfSrWKBYyT33E1VvxImKO4GN0JxCZomOMAUqT1BPCihhCIlujCDaFTm
         +HfJXF6DSOj/kVMp23bh1nYVKiS1eqyxL1JzNMCc=
Received: by mail-wr1-f41.google.com with SMTP id z3so14535033wru.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:12:17 -0800 (PST)
X-Gm-Message-State: APjAAAVqzWcHausQQ32fhuvb2s11PIhcsFZjgQLbZXmFOZ8XGwct8piG
        7TwUko/dkEfzbgx9Kb4xMLB6aVa/M+A1/AZqOcav7w==
X-Google-Smtp-Source: APXvYqx/FE/ZBM/IRE/iZmNcUdhlAsvuwyZQ8jxjO4FhrLlV/QjKqYE4nFeb7APUWZqWIeFWsWQE68sUQ55NIG/jAcY=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr10779334wrs.184.1581459136232;
 Tue, 11 Feb 2020 14:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20200211135256.24617-1-joro@8bytes.org> <20200211145008.GT14914@hirez.programming.kicks-ass.net>
 <20200211154321.GB22063@8bytes.org>
In-Reply-To: <20200211154321.GB22063@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Feb 2020 14:12:04 -0800
X-Gmail-Original-Message-ID: <CALCETrUtvd0OuLoo=ZBRmaJRFxgFWV9hSZyHBwmWCs2+b4J-sg@mail.gmail.com>
Message-ID: <CALCETrUtvd0OuLoo=ZBRmaJRFxgFWV9hSZyHBwmWCs2+b4J-sg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/62] Linux as SEV-ES Guest Support
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 7:43 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Feb 11, 2020 at 03:50:08PM +0100, Peter Zijlstra wrote:
>
> > Oh gawd; so instead of improving the whole NMI situation, AMD went and
> > made it worse still ?!?
>
> Well, depends on how you want to see it. Under SEV-ES an IRET will not
> re-open the NMI window, but the guest has to tell the hypervisor
> explicitly when it is ready to receive new NMIs via the NMI_COMPLETE
> message.  NMIs stay blocked even when an exception happens in the
> handler, so this could also be seen as a (slight) improvement.
>

I don't get it.  VT-x has a VMCS bit "Interruptibility
state"."Blocking by NMI" that tracks the NMI masking state.  Would it
have killed AMD to solve the problem they same way to retain
architectural behavior inside a SEV-ES VM?

--Andy

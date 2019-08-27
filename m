Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A479F690
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 01:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH0XIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 19:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfH0XIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:08:10 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA6422CF4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 23:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566947289;
        bh=esY6YjPvfKmvAp/kVRaTfdsUoSPjd12Fm5ETVPcKaGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tt+XgRGClLul3gO6DAKl61su1kaD7LBGAvpe/PWqJj0fKj/A4nEtdnEy04EQrIZON
         Vikvp1KrXf6b2A9nwhDzyZPu3y0xIgiA6xLH8wa2cWE6QmoUsyNfDDmmQumT74RxJ3
         f3AAIyaQRLJqhx9DdluNTv3jNwK/FjOWe+f9HJp4=
Received: by mail-wm1-f49.google.com with SMTP id o4so725923wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:08:09 -0700 (PDT)
X-Gm-Message-State: APjAAAW7IChsUUgn2Hs0tH0gcvabIigsYJhmSMjXehZU9VoJp88ZY57o
        eQf/61VrOxr4nN18LEXxuy0dU/6h1wC67dXTfVX8rg==
X-Google-Smtp-Source: APXvYqxQ99MDN+RYuiEsd0bHq5VQ47EUqgy9aOdbK2Oqr33cvhPEybYXj/l6IHq77t51KsA5bWEkHrleHX/n11gMNa0=
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr915368wmg.0.1566947287673;
 Tue, 27 Aug 2019 16:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190823225248.15597-1-namit@vmware.com> <20190823225248.15597-4-namit@vmware.com>
In-Reply-To: <20190823225248.15597-4-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Aug 2019 16:07:55 -0700
X-Gmail-Original-Message-ID: <CALCETrXjqa6pWpAgh7v-sttOwY0V2RUqQ_Vs-JQr7nFDYvrBpQ@mail.gmail.com>
Message-ID: <CALCETrXjqa6pWpAgh7v-sttOwY0V2RUqQ_Vs-JQr7nFDYvrBpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] x86/mm/tlb: Avoid deferring PTI flushes on shootdown
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 11:13 PM Nadav Amit <namit@vmware.com> wrote:
>
> When a shootdown is initiated, the initiating CPU has cycles to burn as
> it waits for the responding CPUs to receive the IPI and acknowledge it.
> In these cycles it is better to flush the user page-tables using
> INVPCID, instead of deferring the TLB flush.
>
> The best way to figure out whether there are cycles to burn is arguably
> to expose from the SMP layer when an acknowledgment is received.
> However, this would break some abstractions.
>
> Instead, use a simpler solution: the initiating CPU of a TLB shootdown
> would not defer PTI flushes. It is not always a win, relatively to
> deferring user page-table flushes, but it prevents performance
> regression.
>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/tlbflush.h |  1 +
>  arch/x86/mm/tlb.c               | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index da56aa3ccd07..066b3804f876 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -573,6 +573,7 @@ struct flush_tlb_info {
>         unsigned int            initiating_cpu;
>         u8                      stride_shift;
>         u8                      freed_tables;
> +       u8                      shootdown;

I find the name "shootdown" to be confusing.  How about "more_than_one_cpu"?

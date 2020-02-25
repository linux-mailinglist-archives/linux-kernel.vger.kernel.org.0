Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A716EAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgBYQJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgBYQJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:09:26 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67721218AC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582646965;
        bh=W/rw0F4TTsoGXD/Z2MUJTEHlnOmdJCQ0G4em+EqTpuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J9Sv0/poF8aA7uwh8lMKJ6OoRridBxV5Z4dxcHodYSgaSeD7fW6oLFX8F8hdtp/Qa
         173uhTAmQq4o5Aj0+q+4whY8pma0FlZzLZ3wFLeSAbkSZXKgdViMeQKG2cWqFVelgE
         OlAl0dYq+sUmGXs4xWEyJdpu4NY+MQXwlXNvgkpA=
Received: by mail-wr1-f48.google.com with SMTP id j7so2861433wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:09:25 -0800 (PST)
X-Gm-Message-State: APjAAAUMwIiZE1Y72jxHT0rrB5tMAPT0U5hNf+jOE1ghp0UR4/RtcFPf
        kXUgCSavmbaEmrDOSCQaXi/aBGE332WQZyaS4g2NpA==
X-Google-Smtp-Source: APXvYqwVI4inFI+B0x7wF3k23C+IuGuElA1cYhw8c3JE0QaDa2Qb6+TY4k2p3S+DgBhZ+NRHGQlB/mWJN/lN5efzFCA=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr73906218wrv.151.1582646963815;
 Tue, 25 Feb 2020 08:09:23 -0800 (PST)
MIME-Version: 1.0
References: <9b52495a2d8adfc8f2d731a0236c945196143ef4.1582644865.git.thomas.lendacky@amd.com>
In-Reply-To: <9b52495a2d8adfc8f2d731a0236c945196143ef4.1582644865.git.thomas.lendacky@amd.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 25 Feb 2020 17:09:12 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_3=u1S1dgmjMH+0-7GhD+v3YvgQvqEUx7QSDjPMW1HVw@mail.gmail.com>
Message-ID: <CAKv+Gu_3=u1S1dgmjMH+0-7GhD+v3YvgQvqEUx7QSDjPMW1HVw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Add additional efi tables for unencrypted
 mapping checks
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 16:34, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> When booting with SME active, EFI tables must be mapped unencrypted since
> they were built by UEFI in unencrypted memory. Update the list of tables
> to be checked during early_memremap() processing to account for new EFI
> tables.
>
> This fixes a bug where an EFI TPM log table has been created by UEFI, but
> it lives in memory that has been marked as usable rather than reserved.
>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks Tom

Mind respinning this on top of efi/next?

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/

Thanks,


> ---
>  arch/x86/platform/efi/efi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index ae923ee8e2b4..eba5038c7a44 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -85,6 +85,9 @@ static const unsigned long * const efi_tables[] = {
>  #ifdef CONFIG_EFI_RCI2_TABLE
>         &rci2_table_phys,
>  #endif
> +       &efi.rng_seed,
> +       &efi.tpm_log,
> +       &efi.tpm_final_log,
>  };
>
>  u64 efi_setup;         /* efi setup_data physical address */
> --
> 2.17.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658571355E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgAIJhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 04:37:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34089 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgAIJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:37:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id w5so1600782wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNujAYdpWiwDXEQQdLN1Vurqjh+2ZpMtBUoUWSeq3n8=;
        b=YlcXAhzDj0o2GO1+jPXuS4BeonCzniOnF+er1530sz+dIzmdeWuplcTmqT5TsBBJKH
         s6MlnibNMMoty/ci7vK2oE7hZAPEdjMcXKj98KxatSz61vF191e6KOY4YUlYpeWN8Hqu
         ITvi6p+2EU6L8OJsUAzomiGcOMYaLJkvLWu0RzKmJPq1SyuOm7PT1Ab3i0R2NHUvu3Ox
         xHJi4hP7jHUg+rIpey2jwznyfgdlj8jRbxKEiwxhWCJSaehLyRq/iwiwHq+Zo5zmoY6V
         Pet7pud5+ejce9NGoC1UjFg5nsLcZl8cVo/1rqwMseNv0ZkoyYpfk8h5RXLGC5NvfkV1
         ydnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNujAYdpWiwDXEQQdLN1Vurqjh+2ZpMtBUoUWSeq3n8=;
        b=L4HBJdvYyoMKt+PnrYD8qzdQrs75elY944i2wvPcJ3bmjwiDbiED35nqMqiI3wcFay
         xdgDsDquE1R+sv+AOc85sj0WqviMkFZXwbhwUoUqSywom5YroWqtH/r6Zglu+DE4C+LP
         W+mgx3dFhSJ2FsBfmWIeHUHO7LS8+cJZ/ztgB7A2ZTl/ANFyYidSQSywhQwvanyZUHYa
         nyJK6Y/1BxbbiW7p0XAwHXo3lK0rJgkQTRhS4K0NpUbwhRWfSqFsshlVEFhuPS0D0ffW
         14tFzsHS1N8QijUQnI24bU3/Y6jWuZVcQowhz9D8LkeNVD0Gn78TUBgNz7Y6qDgoBq04
         ilOw==
X-Gm-Message-State: APjAAAVyemePUBukR8dCCJQvLcRkEPUmcd7Ne9Q16S8ZIICcHiwymwuH
        sWQMjG9Y0XqXq1HjDv8jTXu4a9OycYL/7Oc9S4+DFg==
X-Google-Smtp-Source: APXvYqwWGMHGzLMerqILiXKue/DvM+d1qJguUX2aVgIzTL/755mpvPEV7Kw2F5J/dWiy+YIiyXxUYYYl02ks2oxx3Ks=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr3802279wmc.9.1578562666884;
 Thu, 09 Jan 2020 01:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20200103113953.9571-1-ardb@kernel.org>
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 9 Jan 2020 10:37:36 +0100
Message-ID: <CAKv+Gu8pzDSs6G5k9JfX77NB4q2kerxSuprnzFzeGBPd2kPd5g@mail.gmail.com>
Subject: Re: [GIT PULL 00/20] More EFI updates for v5.6
To:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020 at 12:40, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Ingo, Thomas,
>
> This is the second batch of EFI updates for v5.6. Two things are still
> under discussion, so I'll probably have a few more changes for this
> cycle in a week or so.
>
> The following changes since commit 0679715e714345d273c0e1eb78078535ffc4b2a1:
>
>   efi/libstub/x86: Avoid globals to store context during mixed mode calls (2019-12-25 10:49:26 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
>
> for you to fetch changes up to d95e4feae5368a91775c4597a8f298ba84f31535:
>
>   efi/x86: avoid RWX mappings for all of DRAM (2020-01-03 11:46:15 +0100)
>

Ingo, Thomas,

I'll be submitting another PR later today or tomorrow that goes on top
of these changes. Please let me know if you would like a v2 of this PR
with the new content included, or rather keep them separate.

Thanks,
Ard.



> ----------------------------------------------------------------
> Second batch of EFI updates for v5.6:
> - Some followup fixes for the EFI stub changes that have been queued up
>   already.
> - Overhaul of the x86 EFI boot/runtime code, to peel off layers of pointer
>   casting and type mangling via variadic macros and asm wrappers that made
>   the code fragile and ugly.
> - Increase robustness for mixed mode code, by using argmaps to annotate and
>   translate function prototypes that are not mixed mode safe. (Arvind)
> - Add the ability to disable DMA at the root port level in the EFI stub, to
>   avoid booting into the kernel proper with IOMMUs in pass through and DMA
>   enabled (suggested by Matthew)
> - Get rid of RWX mappings in the EFI memory map, where possible.
>
> ----------------------------------------------------------------
> Ard Biesheuvel (17):
>       efi/libstub: fix boot argument handling in mixed mode entry code
>       efi/libstub/x86: force 'hidden' visibility for extern declarations
>       efi/x86: re-disable RT services for 32-bit kernels running on 64-bit EFI
>       efi/x86: map the entire EFI vendor string before copying it
>       efi/x86: avoid redundant cast of EFI firmware service pointer
>       efi/x86: split off some old memmap handling into separate routines
>       efi/x86: split SetVirtualAddresMap() wrappers into 32 and 64 bit versions
>       efi/x86: simplify i386 efi_call_phys() firmware call wrapper
>       efi/x86: simplify 64-bit EFI firmware call wrapper
>       efi/x86: simplify mixed mode call wrapper
>       efi/x86: drop two near identical versions of efi_runtime_init()
>       efi/x86: clean up efi_systab_init() routine for legibility
>       efi/x86: don't panic or BUG() on non-critical error conditions
>       efi/x86: remove unreachable code in kexec_enter_virtual_mode()
>       x86/mm: fix NX bit clearing issue in kernel_map_pages_in_pgd
>       efi/x86: don't map the entire kernel text RW for mixed mode
>       efi/x86: avoid RWX mappings for all of DRAM
>
> Arvind Sankar (2):
>       efi/x86: Check number of arguments to variadic functions
>       efi/x86: Allow translating 64-bit arguments for mixed mode calls
>
> Matthew Garrett (1):
>       efi: Allow disabling PCI busmastering on bridges during boot
>
>  Documentation/admin-guide/kernel-parameters.txt |   7 +-
>  arch/x86/boot/compressed/eboot.c                |  18 +-
>  arch/x86/boot/compressed/efi_thunk_64.S         |   4 +-
>  arch/x86/boot/compressed/head_64.S              |  17 +-
>  arch/x86/include/asm/efi.h                      | 169 ++++++++---
>  arch/x86/mm/pageattr.c                          |   8 +-
>  arch/x86/platform/efi/Makefile                  |   1 -
>  arch/x86/platform/efi/efi.c                     | 354 ++++++++----------------
>  arch/x86/platform/efi/efi_32.c                  |  22 +-
>  arch/x86/platform/efi/efi_64.c                  | 157 +++++++----
>  arch/x86/platform/efi/efi_stub_32.S             | 109 ++------
>  arch/x86/platform/efi/efi_stub_64.S             |  43 +--
>  arch/x86/platform/efi/efi_thunk_64.S            | 121 ++------
>  arch/x86/platform/uv/bios_uv.c                  |   7 +-
>  drivers/firmware/efi/Kconfig                    |  22 ++
>  drivers/firmware/efi/libstub/Makefile           |   2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c  |  20 +-
>  drivers/firmware/efi/libstub/pci.c              | 114 ++++++++
>  include/linux/efi.h                             |  29 +-
>  19 files changed, 597 insertions(+), 627 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/pci.c

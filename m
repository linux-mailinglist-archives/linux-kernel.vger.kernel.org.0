Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1418C0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 21:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCSUC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 16:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCSUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:02:56 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE13206D7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584648175;
        bh=Lz6iUmdUUFtwGgC/vfuRKQ4BpFFpCfAxCeA22G6refY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0v8K0EmEuvJPMlh3qwqIqEoNdNMDRYzWOhDG8ZHflMbjkX1mE3c39qm2ufoEp7bvk
         /ZNeZa0nMemahpY0k/3WEKHYWeT85NUSytMAs+6esUPxDIbjfmiB2H2/X/FZdz8ZJL
         r5orckpzSTjT+duWhyke9cTIP6GY3GnyZiPj+QOU=
Received: by mail-wr1-f41.google.com with SMTP id w10so4777455wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 13:02:55 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2HPAhvcNM0zP1oWUPAZfYVjqPwduq2G+FJ3IU6wXLSwlPTIOPo
        rKVeT4Vf8IDxwb/VsFGOq8FFdNL4XMejFsrCMhQSSg==
X-Google-Smtp-Source: ADFU+vv0pjFJjqLm9+W9pQLQM0AJcDlx7TFtehByST5eabRXhk06kFShIyZpJ7BFdappIgjff7LYwTx1pfxTxuUJCu4=
X-Received: by 2002:adf:afdb:: with SMTP id y27mr6463654wrd.208.1584648174030;
 Thu, 19 Mar 2020 13:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
In-Reply-To: <20200319192855.29876-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 19 Mar 2020 16:02:42 -0400
X-Gmail-Original-Message-ID: <CAKv+Gu9i68KKXwE37kwLuHRVLLbVE+YC_JGog6P-ZtCtbYn4fA@mail.gmail.com>
Message-ID: <CAKv+Gu9i68KKXwE37kwLuHRVLLbVE+YC_JGog6P-ZtCtbYn4fA@mail.gmail.com>
Subject: Re: [PATCH 00/14] efi/gop: Refactoring + mode-setting feature
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 at 15:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This series is against tip:efi/core.
>
> Patches 1-9 are small cleanups and refactoring of the code in
> libstub/gop.c.
>
> The rest of the patches add the ability to use a command-line option to
> switch the gop's display mode.
>
> The options supported are:
> video=efifb:mode=n
>         Choose a specific mode number
> video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
>         Specify mode by resolution and optionally color depth
> video=efifb:auto
>         Let the EFI stub choose the highest resolution mode available.
>
> The mode-setting additions increase code size of gop.o by about 3k on
> x86-64 with EFI_MIXED enabled.
>
> Arvind Sankar (14):
>   efi/gop: Remove redundant current_fb_base
>   efi/gop: Move check for framebuffer before con_out
>   efi/gop: Get mode information outside the loop
>   efi/gop: Factor out locating the gop into a function
>   efi/gop: Slightly re-arrange logic of find_gop
>   efi/gop: Move variable declarations into loop block
>   efi/gop: Use helper macros for populating lfb_base
>   efi/gop: Use helper macros for find_bits
>   efi/gop: Remove unreachable code from setup_pixel_info
>   efi/gop: Add prototypes for query_mode and set_mode
>   efi/gop: Allow specifying mode number on command line
>   efi/gop: Allow specifying mode by <xres>x<yres>
>   efi/gop: Allow specifying depth as well as resolution
>   efi/gop: Allow automatically choosing the best mode
>

Thanks for this! I like it a lot.

Adding Hans to cc as he has been working on seamless fb handover.

I will review this somewhere next week.

>  Documentation/fb/efifb.rst                    |  33 +-
>  arch/x86/include/asm/efi.h                    |   4 +
>  .../firmware/efi/libstub/efi-stub-helper.c    |   3 +
>  drivers/firmware/efi/libstub/efistub.h        |   8 +-
>  drivers/firmware/efi/libstub/gop.c            | 489 ++++++++++++++----
>  5 files changed, 428 insertions(+), 109 deletions(-)
>
> --
> 2.24.1
>

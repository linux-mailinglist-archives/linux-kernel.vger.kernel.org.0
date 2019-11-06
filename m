Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F548F0DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 05:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfKFEqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 23:46:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39772 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbfKFEqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:46:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id p18so1128987ljc.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 20:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJMPHhKHFX8udqWNx4esBxs7+6CjmiT3KwNBEYCiDu4=;
        b=AGaoiWuH4Fsah/5Mrnysi1CUGLJA95+VACk5fohzuSyNRGRqjFWx/bzNkkjPzfXmn4
         Y56Mfrcr6KlRajYlG8J7KWJAzdar9H1F0kQSjY+NkGPXkylSOBzxNGc8EYAurRfcmB6W
         43XMW6wWO+KuWZ1x2OgcbRKsHTZipTg9iq1cqcSeYN66xeR7uy8Njsi51KVfJz+5ptjW
         6D0z5JCz3b+KpM0c+b+GyEa3DW++SaLoFMLmFNX+jRCwBR7lqHsH0/t1F5oUENfxCUfW
         SzqAF/JT6aUsvr6p7H9ff6QpT6lsCCcdg5dNgHRCLTaRIyLqKDptL5tfjfXLbtrBDfPD
         2HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJMPHhKHFX8udqWNx4esBxs7+6CjmiT3KwNBEYCiDu4=;
        b=h02FihivnopCpa3BVO4ves2HQcN+Vbb0EO+y09dZoexvVirT1SYwMf/ZaJdNEHtPaI
         wgjw5C4FHEeitpfGOtvMvdUA2/q72LIgKzWu2ZgbmZK7XlwASJsQzmqz7lNNTA/wqWC9
         4KioulNTK/Q2Xm2MJkud1XYFV4E/TeRQSpIiJhZ1dKP0Ih34URcezsczQDr/pwEOuRqZ
         NRgxMshsiwAb9W1nGspvofJhAtvrBf315YFFwyOKpw0cdDODNvf88cxTn5yczJaq8jlX
         2WBnHb9VR2JT1RTIJG0u2NPKdA65+iHa4Eaud/p4ezPaOwCyGgY27bwhs1FTFzDcHHAU
         B5gw==
X-Gm-Message-State: APjAAAW92Fxj2cEN8sf2QL1TZ3TaDQ0RVUDAgf3109w99etRuoQjumS0
        FgxTrFg+0MadBwy3w/eoyYOkIYPX7UHxu4dyfdQ=
X-Google-Smtp-Source: APXvYqzoj6tUsrC/BVFopD/SaOTrIMULCeKMkv2c1g5ElpPga9joMdtHCw+m/HoGVDnKOKrvi8XqjS+oHuccO/VR5HI=
X-Received: by 2002:a2e:2419:: with SMTP id k25mr252654ljk.59.1573015560588;
 Tue, 05 Nov 2019 20:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com> <20191105235608.107702-12-samitolvanen@google.com>
In-Reply-To: <20191105235608.107702-12-samitolvanen@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Nov 2019 05:45:49 +0100
Message-ID: <CANiq72mZC-G_R_RJjapZS+NvkQcrjdiri0NyHUgesFzUpe-MDg@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] arm64: efi: restore x18 if it was corrupted
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:56 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> If we detect a corrupted x18 and SCS is enabled, restore the register
> before jumping back to instrumented code. This is safe, because the
> wrapper is called with preemption disabled and a separate shadow stack
> is used for interrupt handling.

In case you do v6: I think putting the explanation about why this is
safe in the existing comment would be best given it is justifying a
subtlety of the code rather than the change itself. Ard?

Cheers,
Miguel

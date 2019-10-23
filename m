Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F291BE2138
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfJWQ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 12:59:24 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42831 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfJWQ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:59:22 -0400
Received: by mail-vk1-f195.google.com with SMTP id j22so1484114vki.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiXTugK+glDXdJjZWJtXYSMgUR2uLVi/MAVMaB3F35U=;
        b=NQgD49Nz1FMbQT18HMLMCXz8AgV0WCkf006/YUznJf+3Ipz7NMjqeC2D/k5EAlN0/t
         nJVzfXQMkmOEB0gib3vBf8erowFTJOm5qjJaOs1Eb/RW6pzbK2BDP79mM6rksf9Y8+aj
         BJ0DPjReMffW5qFqvs/6b+ugvel1yOtCyIGIh/ClbZONxGCVxVbdNSXeTSCweh3hL9cu
         Vz0voRu/R6+IY98n6jLUZeKwAjG1FEibO0VIHstd/fmjmeYU0EmyWqWiyBvrGV7Tdguu
         n+UiY/XMLvkLH23E9uESUscCmkQ47unt7KrZbMWIK40hjbUz+Z7oCm/X+x38XKXz8RBw
         +LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiXTugK+glDXdJjZWJtXYSMgUR2uLVi/MAVMaB3F35U=;
        b=LidBa9RV/DtD/stKGCOd3Y0lv2x8eyZhKDea05VzbzuKKLNfh40QDMe8YL6Nb8GC+3
         03toA6T+Wl4SiVFUyZEKCKSGkPgefFwB8EyDDJUIIKI18Y+bmLwkzf3Ti693lvLeOaad
         IOdL7ScWIuO3Xslm3j+60oSegveHCuURIqt2vzqHV6n6bJD+ae706SQbbmRIKTTWT9SR
         jynKJ5WxUq/14Q18ofD0FuRYfMEVbgSYAxxEXegk+FvVpiQJQWS7s/fhS48T+8HW7VN6
         lxYu4hoDserxSgLDBMXmjTWiaMGfB81yGd10XqvinWHqa1FZeL+cvdmSS11DCUt0ZZl+
         fHZA==
X-Gm-Message-State: APjAAAUFf+xORcDFgTh/QNn/5xdYh2n2gBdq+q6lPUPqPXBoV9Opriwi
        +s/9Jn6a4Bj2UZg4OO+l4nRXhAKXbzxWUNBVxMYjZw==
X-Google-Smtp-Source: APXvYqwpR9GdHU5UA4nzyjfo+qvuhnpsktbqKSujsET0zjiSwqQ8iK3jjEiXPXLcBxBc59n7vUzXDYX4PbBLe56acZ4=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr6005570vkf.59.1571849961694;
 Wed, 23 Oct 2019 09:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <20191022162826.GC699@lakrids.cambridge.arm.com>
In-Reply-To: <20191022162826.GC699@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 23 Oct 2019 09:59:09 -0700
Message-ID: <CABCJKudsD6jghk4i8Tp4aJg0d7skt6sU=gQ3JXqW8sjkUuX7vA@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 9:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
> I think it would be preferable to follow the example of CC_FLAGS_FTRACE
> so that this can be filtered out, e.g.
>
> ifdef CONFIG_SHADOW_CALL_STACK
> CFLAGS_SCS := -fsanitize=shadow-call-stack
> KBUILD_CFLAGS += $(CFLAGS_SCS)
> export CC_FLAGS_SCS
> endif
>
> ... with removal being:
>
> CFLAGS_REMOVE := $(CC_FLAGS_SCS)
>
> ... or:
>
> CFLAGS_REMOVE_obj.o := $(CC_FLAGS_SCS)
>
> That way you only need to define the flags once, so the enable and
> disable falgs remain in sync by construction.

CFLAGS_REMOVE appears to be only implemented for objects, which means
there's no convenient way to filter out flags for everything in
arch/arm64/kvm/hyp, for example. I could add a CFLAGS_REMOVE
separately for each object file, or we could add something like
ccflags-remove-y to complement ccflags-y, which should be relatively
simple. Masahiro, do you have any suggestions?

Sami

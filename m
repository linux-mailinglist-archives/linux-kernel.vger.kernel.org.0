Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735C9ECB70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 23:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfKAWgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 18:36:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38016 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:36:19 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so11326462ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOVEnixRZLxQkCHgEpMJYKVl9naG8q4Bhsey3a4BJyw=;
        b=Bli3xmuBt9/GwnfhQ+WLZeBpC+LGylrKEihKmG9wDJcaF6w3L/ZQ8vt3GI4YPWXFJQ
         5Om7iCdkbv/lP18+LV92eRVs401olXcWreQAxfwPfepVtiVSDh9+nHAn2/3d+gfz9UVm
         yMWAVezWZJNqsbBLHANyYxJW6QpG5vniX1o53MF1dl5bc0zwLsqDDWKMYaMNZ47JDbyE
         v0XCStgcgsGwANfNW7O2l7MqWzWiGoQksAS9QIjgoVFUAhEy6735xDLs92DbjUK8gYCH
         q+fHcZwm6Ytrc4SrW8PPtsChFVdCSMaGofeTewgiaGn6jHXy73Odpndaqn2pcpxNkMKy
         K1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOVEnixRZLxQkCHgEpMJYKVl9naG8q4Bhsey3a4BJyw=;
        b=tvRPMcUo7ejiJ9Nivj2csyOE9EIrBhbYppj2/YwOf0jqu8r3clD6iZ6DLs+ZoQF5uS
         vYdYHOR5VHFe/LnsGHyalrPQSi0gPrK5uD+6KcOUYrDJ5TGcba3kWkzzhwusv8HzRuec
         bU1b3JIf7GlRuPSqqcOUMyUuXXZ6jj+omr+mZU10jjMNOV94IfqXZ0DWgjC1FBEChZP3
         cPnQlQxVO9yx3X8tK34mGspdU8nblSWSwuP4DD9eZNxhVrK76dy8M4zJcqhoyjPQb5+l
         e7oGegGxrXRPvIyP/9CJzXs3GOUO9kHJUctZ0CtbqSerHwh71iNq4O6DvmaIu8R0vANf
         9M2g==
X-Gm-Message-State: APjAAAUxR1SUKZQ5NkZfpEwTTQU6Wr4zjpkJ75TkXwZe05AjBAXb1JnS
        1cV3VI5C/pdfsO1CUI/ioy9eck9fEf4PZD6KQLc=
X-Google-Smtp-Source: APXvYqy3a3LpygwD50Ud81Z6exZF+LaVqLS3Tw+hEBAZP5UzR+Yt5u6jie3UaWjeMgSpzygcRllXXMsmSmfSgwH5eE4=
X-Received: by 2002:a2e:8852:: with SMTP id z18mr9873721ljj.230.1572647776833;
 Fri, 01 Nov 2019 15:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-6-samitolvanen@google.com>
In-Reply-To: <20191101221150.116536-6-samitolvanen@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 1 Nov 2019 23:36:05 +0100
Message-ID: <CANiq72=Z285XTHguDoL5Eq_7XRcounmBfscquFPRWk3BH5kLvA@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] add support for Clang's Shadow Call Stack (SCS)
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

On Fri, Nov 1, 2019 at 11:12 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This change adds generic support for Clang's Shadow Call Stack,
> which uses a shadow stack to protect return addresses from being
> overwritten by an attacker. Details are available here:
>
>   https://clang.llvm.org/docs/ShadowCallStack.html
>
> Note that security guarantees in the kernel differ from the
> ones documented for user space. The kernel must store addresses
> of shadow stacks used by other tasks and interrupt handlers in
> memory, which means an attacker capable reading and writing
> arbitrary memory may be able to locate them and hijack control
> flow by modifying shadow stacks that are not currently in use.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel

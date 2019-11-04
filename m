Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED971EF158
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 00:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfKDXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 18:44:52 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42169 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfKDXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:44:52 -0500
Received: by mail-ua1-f68.google.com with SMTP id 31so1849932uas.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 15:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpNwJfSJO9MidRCrn2p9uupIwuhjvEPSgYuh9TBYZuw=;
        b=XWr7kryZXstmsXgYE4dBJ4NrnDur3s/AC0seExuiGF6z4UGQCwWfIPFNeY7JeVwPM3
         wnP1G5A/K76IWU2DyV/IUlCtYDCgPO0n/bDVtTP4pu+zHCoH+fei6dyO2OcLB2gsC6W7
         yHM2c0/FUmsEcEYZY0y9ta70pnWbez+C+rMSFS+aiM6DHbB5OA98h3MrtmOeV6q9EDtK
         bw1zfaHUujqN+zHGVRnnbiam+tcW3d2rc3/Pvust522b4CCrQ9v9kAdVmg3Axk3wD37y
         xqCPcphfjtbZ+wkJQy35r/dA4lS8knkpiqdmkjVq1MbYxp8Jbw1P5SRRjv/N4BJhioPs
         zRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpNwJfSJO9MidRCrn2p9uupIwuhjvEPSgYuh9TBYZuw=;
        b=YypXnw6+E9XZuK1UPxRSW0cNpDMyqfntQCYbpMWx7VDvNT6DtwEI6cN/3pi4lRKBpM
         CCXcdUtyLmjk2U3/t6+ogPZDZkIcuS80c4EqEqqVA36kbb2Dh1b37ToVWWEtRLUaEr9j
         Z9SjilK0J4v7MWaR9e/XEnlHT0XJ3kGG9ZbIXb+FtVf8135ozwtn461Kzw/2/CRK+xEI
         LR+Jyhz5qxsqtUcG/jrJWwNqAMa4nMKhhvia7Uer4vRzfVmtjgoty0etsN7Mb2gP0Y9N
         k56uua56Cm+KxG6pxyRbkQzRMoi0hbCDtLeoAJ7OiR+hx509uJIqxm8nVyqOhRrU688J
         QR4Q==
X-Gm-Message-State: APjAAAUNe2pvCjdSsWbDGtkKFaefLAK8OXpzr/RoLzWXKzpGv1mZwSYu
        JmMAPR+xFNs3OiMOETAqRoke/Y49fcnqqo6qYHniOg==
X-Google-Smtp-Source: APXvYqwMrHXnmCbhr/Nl5pMJrYHuxKP6Lu2UQKV7ItSK55vLCW1x6A4Use4SMcLe4G85I9Dvt99c2soxGNjz4r8rNRQ=
X-Received: by 2002:ab0:4587:: with SMTP id u7mr3850575uau.67.1572911090684;
 Mon, 04 Nov 2019 15:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-12-samitolvanen@google.com>
 <20191104171132.GB2024@lakrids.cambridge.arm.com>
In-Reply-To: <20191104171132.GB2024@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Nov 2019 15:44:39 -0800
Message-ID: <CABCJKufDnLjP9vA-wSW0gSY05Cbr=NOpJ-WCh-bdj2ZNq7VNXw@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] arm64: disable function graph tracing with SCS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 9:11 AM Mark Rutland <mark.rutland@arm.com> wrote:
> Can you please elaborate on _how_ this is incompatible in the commit
> message?
>
> For example, it's not clear to me if you mean that's functionally
> incompatible, or if you're trying to remove return-altering gadgets.
>
> If there's a functional incompatibility, please spell that out a bit
> more clearly. Likewise if this is about minimizing the set of places
> that can mess with control-flow outside of usual function conventions.

Sure, I'll add a better description in v5. In this case, the return
address is modified in the kernel stack, which means the changes are
ignored with SCS.

Sami

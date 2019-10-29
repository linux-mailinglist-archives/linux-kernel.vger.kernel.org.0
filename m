Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0310AE920F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 22:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfJ2Vbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 17:31:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45372 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJ2Vbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:31:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id y7so30524edo.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sG8ktVp69lBLldtD8XFYhZW6X0Mbz+fRfKIpBc3S1fE=;
        b=eeDi1R76xYCKBaFKAK/zVVjADW1kTa1srCPF0WcJM7yU0DkoXkUiJwryjC6xTYGZyo
         d0DNATnv8FA08H765+CI9jRvNYj3EkL7mDP3t8zyAFX536x5LRun/hUVHf0fYxeFR1Fz
         mtwefrj5sIbiglak1f5PhwDJFrPwYzq6Seu7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sG8ktVp69lBLldtD8XFYhZW6X0Mbz+fRfKIpBc3S1fE=;
        b=p76ivIEX6egN6Ah/vJTv+3X1kllSncQuZQZBknd21nmSW4r8KfxBcF5Ck5nTHlKa5f
         9z7OjYiaEgW9oA1hlyzd4V295w319RgSkL+6j/ti+mgEC+nMa47rydPKxdndhmI0v5de
         ExPvEe3VGA0W+FrFYNy3TlsSjAmppXYZeWcc1iFGMgUYMQFF/SHdCYnBaBxGX18EMTzW
         EIlnZaK6cIUYMhbmT9+OEYI0hXjoh+tyxz3czvhxaPUi5F+0OkXQ1DDIUeBeiOCsHSGB
         a/bR8g7rNyKsF6k+BZhQLQH+g/xg7G47RZNzY8zKA3stY7jppDp9emLm7KE3YB7JLDQu
         +TTg==
X-Gm-Message-State: APjAAAWHKbQUgYJAUlQ75KYY1my4bkOa3nbzW6QsmQgUuyNsrD79Zcoq
        v9VsIlO6xJhXVquHyxJxlrTotxYE/so=
X-Google-Smtp-Source: APXvYqyyPSFJiG8kiBA+W/4tdVCPGLifZd3FA1nDVcP6OLrNGOyqWxbjwqD55dvKT4BJw/1dN1q4jg==
X-Received: by 2002:a50:b63b:: with SMTP id b56mr26603533ede.165.1572384689086;
        Tue, 29 Oct 2019 14:31:29 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id d3sm664ejo.74.2019.10.29.14.31.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 14:31:28 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id x5so3976922wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:31:27 -0700 (PDT)
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr5907919wme.5.1572384687151;
 Tue, 29 Oct 2019 14:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-12-thgarnie@chromium.org> <20190812135701.GH23772@zn.tnic>
In-Reply-To: <20190812135701.GH23772@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Tue, 29 Oct 2019 14:31:15 -0700
X-Gmail-Original-Message-ID: <CAJcbSZGVAG_ODm+R9ukSOSfmhyHn1wbUtdnD_AtEVMaM3GgS+w@mail.gmail.com>
Message-ID: <CAJcbSZGVAG_ODm+R9ukSOSfmhyHn1wbUtdnD_AtEVMaM3GgS+w@mail.gmail.com>
Subject: Re: [PATCH v9 11/11] x86/alternatives: Adapt assembly for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 6:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jul 30, 2019 at 12:12:55PM -0700, Thomas Garnier wrote:
> > Change the assembly options to work with pointers instead of integers.
>
> This commit message is too vague. A before/after example would make it a
> lot more clear why the change is needed.

Sorry for the late reply, busy couple months.

I will try to do my best to explain it better in next iteration.

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

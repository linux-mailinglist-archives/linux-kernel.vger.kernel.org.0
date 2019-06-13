Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7844BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 21:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFMTPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 15:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfFMTPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:15:04 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32F521743
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560453303;
        bh=Oa0h+VkM+jYwz1CDfagH3gFgn0xbgAhOJQVjNVroz4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y0ztSVbqiejhheHcChycJTSyM4/b7Dt0oiJWM+A6VsyqBm2RxLwvOBg/09wnR9y5x
         62giVDer9tx24qEsHhEvFUfn7VUHwb2/c6v0Qde3TObUoZ6TNPl+WV8HuOfjMv0Y8q
         7/YFm2bwGyR+Vj9jjypEuxJpgDQYLmic+igSRqgs=
Received: by mail-wr1-f50.google.com with SMTP id m3so2988041wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:15:03 -0700 (PDT)
X-Gm-Message-State: APjAAAW+OyrcLYOUuZTt6mRr3ZXFUjG412W6vBrQnGLoUrGK2DII6pK+
        a26e00Aju+/P0C4ymLHqjjoh11xNz84x5Xg/eDTydA==
X-Google-Smtp-Source: APXvYqy+WvOHJFOQlD8iR/jd81NhKk+vz0wZOKgbBUOzHS4PAhfNiAjt+elP2EqMtMeviXbLy2diLOLO4OyVUlf2Sxk=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr40594967wru.265.1560453302165;
 Thu, 13 Jun 2019 12:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560198181.git.luto@kernel.org> <25fd7036cefca16c68ecd990e05e05a8ad8fe8b2.1560198181.git.luto@kernel.org>
 <201906101344.018BE4C5C1@keescook>
In-Reply-To: <201906101344.018BE4C5C1@keescook>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 13 Jun 2019 12:14:50 -0700
X-Gmail-Original-Message-ID: <CALCETrUYNavL8pu4jQqJjoT=PdeRyjeoLDn=0r7h=2XsHDMezQ@mail.gmail.com>
Message-ID: <CALCETrUYNavL8pu4jQqJjoT=PdeRyjeoLDn=0r7h=2XsHDMezQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] x86/vsyscall: Change the default vsyscall mode to xonly
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 1:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 10, 2019 at 01:25:31PM -0700, Andy Lutomirski wrote:
> > The use case for full emulation over xonly is very esoteric.  Let's
> > change the default to the safer xonly mode.
>
> Perhaps describe the esoteric cases here (and maybe in the Kconfig help
> text)? That should a user determine if they actually need it. (What
> would the failure under xonly look like for someone needing emulate?)

I added it to the Kconfig text.

Right now, the failure will just be a segfault.  I could add some
logic so that it would log "invalid read to vsyscall page -- fix your
userspace or boot with vsyscall=emulate".  Do you think that's
important?

--Andy

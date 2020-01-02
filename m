Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7546A12E467
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 10:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgABJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 04:27:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgABJ1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:27:40 -0500
Received: from zn.tnic (p200300EC2F00E700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69C2D1EC0716;
        Thu,  2 Jan 2020 10:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577957259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFX5xVhEa7R6fr10YXKpmVLCawy4p5svcRjomdy8DBQ=;
        b=MUKjLCQD1JNs43TEo80ZyQGe6REMTVzv1MkowPEINyWckqer8X4mLpKXeKIYZD14Z2pwhj
        Q9QEP84QKwzMwGzN/jQiFInFnGjw7WTqUeIXhMgMSxQysq5RkPB0H5csjxWI/PjlRaaOdg
        7awFmhh4D6kCCmRfRnQkmHXf9I+r/Ks=
Date:   Thu, 2 Jan 2020 10:27:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v7 1/4] x86/insn-eval: Add support for 64-bit kernel mode
Message-ID: <20200102092733.GA8345@zn.tnic>
References: <20200102074705.n6cnvxrcojhlxqr5@box.shutemov.name>
 <498AAA9C-4779-4557-BBF5-A05C55563204@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <498AAA9C-4779-4557-BBF5-A05C55563204@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 04:55:22PM +0900, Andy Lutomirski wrote:
> > In most cases you have struct insn around (or can easily pass it down to
> > the place). Why not use insn->x86_64?
> 
> What populates that?

insn_init() AFAICT.

However, you have cases where you don't have struct insn:
fixup_umip_exception() uses it and it calls insn_get_seg_base() which
does use it too.

> FWIW, this code is a bit buggy: it gets EFI mixed mode wrong. I’m
> not entirely sure we care.

We'll cross that bridge when we get there, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

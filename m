Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB621038A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfKTLYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 06:24:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60142 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfKTLYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:24:17 -0500
Received: from zn.tnic (p200300EC2F0D8C008093FCEEEFCF892F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8c00:8093:fcee:efcf:892f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4066A1EC0CDD;
        Wed, 20 Nov 2019 12:24:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574249055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XrrdFhCCBXRxT3LV1xr012UV8zCjBvEuijRbqOYas5I=;
        b=VHGB9cNmT/6J09kzNEa5Lcf9zfAdImGMXiGS1yaEWBaOLpugcAYB4L3jMu2rj7OAz6BvNx
        KgSKYLHO2MStMUpABw3wp3MHgUhKJJ98Gye0Nv2dy5hmHyALDxnWcXUUQQB2o73hHqI7Rq
        +zGlI19Oyq5X+N59aCXrAra6nEzIDvw=
Date:   Wed, 20 Nov 2019 12:24:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120112408.GC2634@zn.tnic>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120111859.GA115930@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:18:59PM +0100, Ingo Molnar wrote:
> How was this maximum string length of '90' derived? In what way will
> that have to change if someone changes the message?

That was me counting the string length in a dirty patch in a previous
thread. We probably should say why we decided for a certain length and
maybe have a define for it.

Also, I could use your opinion on this here:

https://lkml.kernel.org/r/20191118164407.GH6363@zn.tnic

and the following mail.

I think that marking the splat with its number would *immensely* help us
with the question: was this the first splat or wasn't? A question we've
been asking since I got involved in kernel development. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

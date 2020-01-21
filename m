Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8591814407F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 16:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAUP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 10:29:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36308 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbgAUP3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:29:02 -0500
Received: from zn.tnic (p200300EC2F0B04001968D368394CA6AD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:400:1968:d368:394c:a6ad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8E341EC045C;
        Tue, 21 Jan 2020 16:29:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579620541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6y5TIWmgQrQ+KXfFCFI2F/8j7NBQMvB/7z0s7cAgzgI=;
        b=oQLFfvbgKCydpAmIBQg1afn73trDMTjKEgfBj3YztJm0HfveIFt/SPB/zv4Lku7Lg8wFWJ
        qgCvIM/dFugZ1O8/MnUlmVADy74ZMiZo0S78shLxg4tRdRcCg5/jqe0U7NrrIMXll7FSaK
        kqiJ37Kb43b+UOH5yP1m9Wgv0AnwAKg=
Date:   Tue, 21 Jan 2020 16:28:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Message-ID: <20200121152853.GI7808@zn.tnic>
References: <20200121151503.2934-1-cai@lca.pw>
 <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:19:22PM +0100, Marco Elver wrote:
> Could you remove the verbatim copy of my email? Maybe something like:
> 
> "Increments to cpa_4k_install may happen concurrently, as detected by KCSAN:
> 
> <....... the stack traces ......>

... and drop the stack traces and fix your subject to say what you're
actually "fixing".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

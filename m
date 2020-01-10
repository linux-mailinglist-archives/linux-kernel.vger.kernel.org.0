Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF77137808
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 21:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAJUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 15:38:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40108 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgAJUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:38:35 -0500
Received: from zn.tnic (p200300EC2F0ACA00F8C15324EBC48DF9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:f8c1:5324:ebc4:8df9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E7D41EC0AED;
        Fri, 10 Jan 2020 21:38:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578688714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OVyKPs0BpfFvqdbrTSlRzuDRyyQLqNTc6ApJbIXLrcg=;
        b=SU703pXxDdiZDx7W6KuDHtSULp/o2rtKz2j9n6IGHI2GPtODYFWA7USrupnxYe03fmprpP
        zOEAYmwEWEIa5bLozjrDDIFNlNKLA5SxVec9Olf7bneIhfLHv5XV0u3ShVV2055JNH2kSy
        9QV/jwUZsmfiFI2S2GhlAcVibMEljPI=
Date:   Fri, 10 Jan 2020 21:38:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200110203828.GK19453@zn.tnic>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110202349.1881840-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:23:49PM -0500, Arvind Sankar wrote:
> Pre-2.23 binutils makes symbols defined outside sections absolute, so
> these two symbols break the build on old linkers.

-ENOTENOUGHINFO

Which old linkers, how exactly do they break the build, etc etc?

Please give exact reproduction steps.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

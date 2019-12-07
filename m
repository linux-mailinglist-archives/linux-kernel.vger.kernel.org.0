Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45D01159CB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 00:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLFXwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 18:52:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47796 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfLFXwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 18:52:11 -0500
Received: from zn.tnic (p200300EC2F143500E867914265F2677A.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:3500:e867:9142:65f2:677a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5040B1EC0626;
        Sat,  7 Dec 2019 00:52:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1575676326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7y6bztfz8hHCc9vu8AJ2gILSQyIjChs5fx5k9dok2Vc=;
        b=P85wYETNlZpwm2WAXvuJDgD65DnvPqkNV0vcomlXJnNOium4lC7I6DVZIMOiIePn2oAz14
        rSsayTqCTWIV2ZCDrHPJbiU9ef35BmFxluG2Bn9O/qUYkYn6z0ipU0ht6K2iyJjLugy7Ur
        oy3DxgNk4mBjUVl2CsLAVqI20D+mvHs=
Date:   Sat, 7 Dec 2019 00:51:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/fpu/xstate: Export fpu_fpregs_owner_ctx
Message-ID: <20191206235157.GA7601@zn.tnic>
References: <20191206231709.15398-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191206231709.15398-1-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 03:17:09PM -0800, Yu-cheng Yu wrote:
> After applying my "Invalidate fpregs when __fpu_restore_sig() fails"
> patch [1], the following happens:
> 
>     ERROR: "fpu_fpregs_owner_ctx" [arch/x86/kvm/kvm.ko] undefined!
> 
> Fix it by exporting the symbol.  I apologize for missing this!

So why a separate patch? Just send a v2 as a reply to the incomplete
one.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

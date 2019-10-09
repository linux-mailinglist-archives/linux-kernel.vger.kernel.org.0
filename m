Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60423D16B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 19:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbfJIRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 13:32:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40570 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbfJIRb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:31:56 -0400
Received: from zn.tnic (p200300EC2F0C2000CC8F9AE7D5DA1569.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:cc8f:9ae7:d5da:1569])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF3761EC0819;
        Wed,  9 Oct 2019 19:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570642311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TswlQo4vEF+AgJvamc1wb5Alk3PGWUEclAdiRh5vN/8=;
        b=j3dNU27rfdTrYdutjpQ9JRpVeZk5vrj9IRTq5BqHc1HnAM2iJRSD6YC4MevF7KOSOPwfpV
        QUYPFxtjStRxpXi2h9zvNv8NTjFJGVrVIcN8eOG3UOg/UKPgL+OPNdjqTBGaMERhYtNOzk
        pvNKT/Pg8egSrmyGVH6HDtkQnxl+31w=
Date:   Wed, 9 Oct 2019 19:31:48 +0200
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
Subject: Re: [PATCH 6/6] x86/fpu/xstate: Rename validate_xstate_header() to
 validate_xstate_header_from_user()
Message-ID: <20191009173148.GJ10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
 <20190925151022.21688-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925151022.21688-7-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:10:22AM -0700, Yu-cheng Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> The function validate_xstate_header() validates an xstate header coming
> from userspace (PTRACE or sigreturn).  To make it clear, rename it to
> validate_xstate_header_from_user().
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

This one is correct!

\o/

> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/fpu/xstate.h | 2 +-
>  arch/x86/kernel/fpu/regset.c      | 2 +-
>  arch/x86/kernel/fpu/signal.c      | 2 +-
>  arch/x86/kernel/fpu/xstate.c      | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)

And I like patches like this one! :-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

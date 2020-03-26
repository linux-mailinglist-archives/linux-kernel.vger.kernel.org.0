Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E6219457C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 18:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgCZRdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 13:33:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZRdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:33:53 -0400
Received: from zn.tnic (p200300EC2F0A4900B0CADCDCA21F3A81.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4900:b0ca:dcdc:a21f:3a81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 011051EC0CAA;
        Thu, 26 Mar 2020 18:33:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585244032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WGqBCojEU5oVo7IiRnT1xfvR5XszmjtZBl58kNCLSRg=;
        b=NGRiNKn9y+rpZ4LCRmZWf9G5QdHCErnQYGiSiJIJt7DYHwDhCB6cruZQouLMVKTmQSqltr
        4fWLW8ILXfKKrkxE+u+eqwdgFwQt6/COFVFCP6at96kxyiMGoMME60CQIRwUnUP5gPDN2A
        uecVuuaRLIOVSmTUdF0bbxOr3OD4MkY=
Date:   Thu, 26 Mar 2020 18:33:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 11/17] static_call: Simple self-test
Message-ID: <20200326173352.GH11398@zn.tnic>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.940973110@infradead.org>
 <20200326154439.GD11398@zn.tnic>
 <20200326170852.GR20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326170852.GR20713@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 06:08:52PM +0100, Peter Zijlstra wrote:
> Dunno, that just clutters dmesg, the important bit is it complaining
> when it goes sideways. But no strong feelings either way.

Right, I was playing with it and was wondering whether it ran or not.
Whatever you decide - I can always add a printk if I need it to say
something.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

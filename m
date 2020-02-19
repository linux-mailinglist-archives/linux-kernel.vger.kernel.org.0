Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CE164751
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 15:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 09:43:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36210 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBSOn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:43:28 -0500
Received: from zn.tnic (p200300EC2F095500AC4EBF6CAFE7BFD1.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5500:ac4e:bf6c:afe7:bfd1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B5761EC0CD2;
        Wed, 19 Feb 2020 15:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582123403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R9S+fJZVrq50eOUEF8rI2ReG0g4IgbKjuDpJyo13/3Q=;
        b=ndhB4WdCd1C0ZRq2oXpWB2XKP5QMzeL088a1yk5T+moEorrOuGn2Nh3lNpwzND5OmEKkn1
        GDFVkhdW8uvHTQ7jOgkpZIh/Fl2UHcMnVvGlj59JcUJS9roGbpmYse1rqRubEEF/23vKCb
        sTyXT2r7yLOSqUnhXxGOenE4jedPSp0=
Date:   Wed, 19 Feb 2020 15:43:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200219144318.GD30966@zn.tnic>
References: <20200218173150.GK14449@zn.tnic>
 <CALCETrXbitwGKcEbCF84y0aEGz+B4LL_bj-_njgyXBJA74abOA@mail.gmail.com>
 <20200219081541.GG14914@hirez.programming.kicks-ass.net>
 <20200219092115.3b3cccd9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219092115.3b3cccd9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:21:15AM -0500, Steven Rostedt wrote:
> What would be nice is to have a NMI_IRET, that is defined as something
> that wont break legacy CPUs. Where it could be just a nop iret, or maybe
> if possible a "lock iret"? That is, not have a IRET_NON_NMI, as that
> would be all over the place, but just the iret for NMI itself. As
> that's in one place.

You mean, we could keep the nested NMI thing but it won't practically
get executed on NMI_IRET CPUs because there won't be any NMI nesting
anymore?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

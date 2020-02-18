Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DC3163051
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 20:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgBRTiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 14:38:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRTiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:38:55 -0500
Received: from zn.tnic (p200300EC2F0C1F00DCB96C3517B36067.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:dcb9:6c35:17b3:6067])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8E811EC0CAA;
        Tue, 18 Feb 2020 20:38:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582054733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OqGTJVey3byW94WtpQyLsVkrLrmmQJ80pToxR9gFeiQ=;
        b=J7z9dmYhf7IzQqjnoQHTCWGHR8Mp2FhwWctywz8TfsvzgctyrV4/VDYY9+U664shF/G1yP
        fCNukwh/2Quqx3JGYD05dPyC3N4B/1e0YgKqdJf5CCt2lyqgV5arkMLme2vTujLISY4AAx
        P8LLsMFJ+EyfB39w3OsaAR0Nx0Q4Nro=
Date:   Tue, 18 Feb 2020 20:38:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200218193850.GM14449@zn.tnic>
References: <20200206175858.GG9741@zn.tnic>
 <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
 <20200207114122.GB24074@zn.tnic>
 <20200208000648.3383f991fee68af5ee229d65@kernel.org>
 <20200210112512.GA29627@zn.tnic>
 <20200211001007.62290c743e049b231bdd7052@kernel.org>
 <20200210174053.GD29627@zn.tnic>
 <20200211110207.7e0f1b048cc207e1a31ddd31@kernel.org>
 <20200218132724.GC14449@zn.tnic>
 <20200218125748.5085929c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200218125748.5085929c@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:57:48PM -0500, Steven Rostedt wrote:
> OK, what if we put it as default 'n' but we still check if "bootconfig"
> is on the command line. And if it is, we warn with something like:
> 
> #ifndef CONFIG_BOOTCONFIG
> 	pr_err("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set in this kernel\n");
> #endif

Sure, makes sense to me. And all the code that requires it, can simply
select BOOTCONFIG.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

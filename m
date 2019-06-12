Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A26C42AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfFLPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 11:19:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37940 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfFLPS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:18:59 -0400
Received: from zn.tnic (p200300EC2F0A6800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4194F1EC0A91;
        Wed, 12 Jun 2019 17:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560352738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5dfZK3tXx7WDVHAc/YaA1/OQSLM1t/haYBxe1ZP/QI8=;
        b=ra5npW31O/i4KmeC7PC0PtP72fN4rwTkCSacHiW9yreAvSCu8IFWEj02GQq6EH/HJ4dfaM
        aUVbROrQeqcph/3/wfUV1YhIxRelJiY1vH0yQJmXGucFB5H7+igye1nwBtPhuvlMoUNEIe
        gEpdhA6ZPMg9URvNXm44UkE/1l/YsXU=
Date:   Wed, 12 Jun 2019 17:18:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pu Wen <puwen@hygon.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: mce: no need to check return value of
 debugfs_create functions
Message-ID: <20190612151856.GK32652@zn.tnic>
References: <20190612151531.GA16278@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612151531.GA16278@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 05:15:31PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/kernel/cpu/mce/core.c     | 16 +++++---------
>  arch/x86/kernel/cpu/mce/inject.c   | 34 +++++-------------------------
>  arch/x86/kernel/cpu/mce/severity.c | 14 +++---------
>  3 files changed, 13 insertions(+), 51 deletions(-)

I think I'm having a deja-vu:

https://lkml.kernel.org/r/20190122215326.GM26587@zn.tnic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

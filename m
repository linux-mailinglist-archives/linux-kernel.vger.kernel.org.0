Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EB161D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 23:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgBQW1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 17:27:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgBQW1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 17:27:42 -0500
Received: from zn.tnic (p200300EC2F060D003890503FBB74C433.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d00:3890:503f:bb74:c433])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3229E1EC0CBD;
        Mon, 17 Feb 2020 23:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581978461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/FJJbCDOjUUmIUjMyPfoaIaLPNSqF3CmeICmYvc3W8g=;
        b=PJWCQCabxkS21RV5mj+zPgHQgLexge4YBqr7R8AD+YLRwOAvyYvku5qXJ8loni+8xdPqIF
        iEI0W3bu7pKZz3HQKdmOU86GIHPiFTA8dRp0eQ5J80okED4X25EGO0ay7C80fDNxfMMhEG
        2y9wv30+YrPL2ZQkTtmCX/7oUppDgYM=
Date:   Mon, 17 Feb 2020 23:27:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86: Don't clare __force_order in kaslr_64.c
Message-ID: <20200217222736.GG14426@zn.tnic>
References: <20200124181811.4780-1-hjl.tools@gmail.com>
 <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:24:19AM -0800, Andy Lutomirski wrote:
> Why does anything actually define that variable? Surely any actual
> references are just an outright bug. Is it needed for LTO?

I think the answer to your question is at the top of
arch/x86/include/asm/special_insns.h


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

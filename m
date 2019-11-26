Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAF10A5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 21:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfKZUyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 15:54:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZUyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:54:00 -0500
Received: from zn.tnic (p200300EC2F0EC2005CA5EB7C7B4C9F6D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c200:5ca5:eb7c:7b4c:9f6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13DAD1EC095C;
        Tue, 26 Nov 2019 21:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574801639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0EAng0JO2Sq8Q9Mo0wZDDoOOvzDnBNYYbAsL5s1cfrE=;
        b=EGWp+pR4d8k4BSQEnZn0589/xZrZItrMkqNiLXZJY/yyqjhsA1kLaJ7DQiUUagaFNxjNqR
        DuPu921G5r0lakSMz3yERzrJk6ib4Ld1chyk2LqLhrXC5bgmb3uZE4+r8BeBgZ+SrQNwQc
        BwSo0Hd29gahT7daLBvDRC35WkK0Dq4=
Date:   Tue, 26 Nov 2019 21:53:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Filter MSR writes from luserspace
Message-ID: <20191126205351.GG31379@zn.tnic>
References: <20191126112234.GA22393@zn.tnic>
 <87zhgie6nl.fsf@linux.intel.com>
 <20191126203336.GF31379@zn.tnic>
 <20191126205028.GJ84886@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191126205028.GJ84886@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:50:28PM -0800, Andi Kleen wrote:
> You'll almost certainly violate Linus' golden rule of application
> compatibility and the whole thing will be reverted in the end.

We'll see.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

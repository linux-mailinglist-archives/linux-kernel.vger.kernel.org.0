Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F610A6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 00:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKZXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 18:00:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34658 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfKZXAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 18:00:47 -0500
Received: from zn.tnic (p200300EC2F0EC2003034EE13CF148829.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c200:3034:ee13:cf14:8829])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B43E41EC0CD6;
        Wed, 27 Nov 2019 00:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574809245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1BYd4g36wutwSqaxdQDSylrN82e2jnf8ZMNCZbx52og=;
        b=aeNLk3CB/v6VzkrA7gp4A8BhxOarAfd/N5P+2xMpTdJG0bD1GG5CJoXkXe/m+6TiAAD/S8
        VxTdSa4SFDAGuQxEzoJADmLnfzJIvYXgM2RhVDzNkikswRVurhd0Wvwx2SO2c0tCvya+Hm
        /AmTaZaF0F8XIlurQ58wzjXo7ASlswU=
Date:   Wed, 27 Nov 2019 00:00:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Barret Rhoden <brho@google.com>, austin@google.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: AVX register corruption from signal delivery
Message-ID: <20191126230038.GI31379@zn.tnic>
References: <20191126221328.GH31379@zn.tnic>
 <EFBC6B60-D0EC-4518-A38E-076D3933AA0E@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EFBC6B60-D0EC-4518-A38E-076D3933AA0E@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 02:30:10PM -0800, Andy Lutomirski wrote:
> If we do this, we should have selftests/x86/slow or otherwise have a
> fast vs slow mode. I really like that the entire suite takes under 2s.

Sure, we can stick it under a separate Makefile target called "full" or
so to mean, run the full set of tests. We can run the fast ones first
and the slow ones then. Or something to that effect.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

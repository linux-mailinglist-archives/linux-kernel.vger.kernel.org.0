Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA51092F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 18:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfKYRj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 12:39:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60428 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfKYRj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 12:39:56 -0500
Received: from zn.tnic (p200300EC2F0B8900A59DB9F6058597A2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8900:a59d:b9f6:585:97a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97FD41EC0CB2;
        Mon, 25 Nov 2019 18:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574703594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=auM2R1zBITya3lgGlmDkiaMDGZJ9GRYCQDJu9FhIfvc=;
        b=nIHF3xrjsKzebFfz4MWihJN/HUiN6XTV1wDBxv0m+Vrfd5eXEvuMiCUyKZc/XAz5A7xNJi
        1Y04/1vafUiyJVqToab3nfoEgEokLWKC8tlFxpMqXGAj1h5QEQy1QsvxqCkkL2SN4H5BbH
        CvxIg3IKtbxfqWxKaJfz8c5rnQ5ydpE=
Date:   Mon, 25 Nov 2019 18:39:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.5
Message-ID: <20191125173945.GE12413@zn.tnic>
References: <20191125160821.GA42496@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125160821.GA42496@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 05:08:21PM +0100, Ingo Molnar wrote:
> Unfortunately the symbol rework will generate conflicts with pending 
> changes to assembly files.

Yap, for at least one other tree:

https://lkml.kernel.org/r/20191118141110.7f971194@canb.auug.org.au

Resolve is simple though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

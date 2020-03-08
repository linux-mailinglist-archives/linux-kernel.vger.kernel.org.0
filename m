Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3817D4DE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgCHQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 12:37:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40846 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHQhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:37:17 -0400
Received: from zn.tnic (p200300EC2F18BA00E93234E4D9E0EB78.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:ba00:e932:34e4:d9e0:eb78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FAF21EC0C2D;
        Sun,  8 Mar 2020 17:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583685436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=swvQq6e7qV+6DICJFf9o0e8O2uxL8e46gHWBPk53K3A=;
        b=dKJcDQBEzSlxmpzuYepd+uWktcVp+b+J6Hs3S7T19oRcJRdQCRsYP30iL8be+UupjRPXwf
        jB3Asfub1wbInKljei9cZtdnZFhXCSuACmuByJ4pnVSDfjuTVlAVskP7a6rJ9hvNZyTWHy
        sinMy9rjGFWn2xIvVIc0SF+BLlCQ5vQ=
Date:   Sun, 8 Mar 2020 17:37:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Subject: Re: general protection fault in syscall_return_slowpath
Message-ID: <20200308163726.GA8547@zn.tnic>
References: <000000000000ff323f05a053100c@google.com>
 <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 09:13:45AM -0700, Andy Lutomirski wrote:
> Are there instructions for just building syzkaller?  I don't want to
> install it, I don't want to fuzz my kernel -- I just want to run your
> reproducer.

+1.

It would be lovely if there were a bootstrapping script which I run
and which fetches all the required gunk for the reproducer to run and
eventually runs it too instead of me having to fiddle with setting up go
each time.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2186315C0E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 16:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBMPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 10:01:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgBMPB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:01:58 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7B724649;
        Thu, 13 Feb 2020 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581606117;
        bh=jEfGIx55Y1LJI29oxGo9H1NpYke+pY4qYDaZU+KaDb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlnELTXAbOaANxkbHJcMcXvyCZEiaNZrCmRtfEg29p/ZY0INn7zO2lzkSsCVfnvgy
         YJDrqB4lJrp9zXpKW8kPfm3Sj70U/IsAu7NsWDtcoRWidFQn6vEGwa/MhrOWyGpzyx
         nvZ0RsY+8RYRmcRYWoc3+c/UnpRhNaJ/+XItste0=
Date:   Thu, 13 Feb 2020 07:01:56 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH-4.19-stable 0/2] Backport ENCODE_FRAME_POINTER hint
Message-ID: <20200213150156.GC3409676@kroah.com>
References: <20200210140543.79641-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210140543.79641-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:05:41PM +0000, Dmitry Safonov wrote:
> On 4.19.93 the following warning was observed with CONFIG_FRAME_POINTER:
> > WARNING: kernel stack frame pointer at 00000000bceb5183 in Coronavirus:3282 has bad value           (null)
> >  unwind stack type:0 next_sp:          (null) mask:0x2 graph_idx:0
> >  000000009630aa47: ffffc9000126fdb0 (0xffffc9000126fdb0)
> >  0000000020360f53: ffffffff81038e33 (__save_stack_trace+0xcb/0xee)
> >  00000000675081f2: 0000000000000000 ...
> >  0000000043198fe7: ffffc9000126c000 (0xffffc9000126c000)
> >  0000000008a46231: ffffc90001270000 (0xffffc90001270000)
> [..]
> 
> It turns to be missing %rbp hint was making frame pointer unwinder
> a bit tipsy.
> The observed is WARN_ONCE(), so it one time per boot, but imho, worth to
> have in stable too.

All now queued up, thanks!

greg k-h

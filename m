Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44B310A604
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 22:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKZVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 16:32:11 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58230 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZVcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:32:11 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EE2BD1C216C; Tue, 26 Nov 2019 22:32:09 +0100 (CET)
Date:   Tue, 26 Nov 2019 22:32:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: next-20191119 on x86-32: fails to boot -- NX protecting kernel
 data, then oops
Message-ID: <20191126213209.xehud67a2ybdk7p6@ucw.cz>
References: <20191125144946.GA6628@duo.ucw.cz>
 <CALCETrW85=toRrxe5w6a+AFmpTygR24K7rbDyvbmMLSsMO80XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW85=toRrxe5w6a+AFmpTygR24K7rbDyvbmMLSsMO80XQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Nov 25, 2019 at 6:49 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > Machine is thinkpad x60, that's x86-32. It fails to boot:
> >
> > EIP: ptdump_pte_entry+0x9
> >
> > call trace
> > ? ptdump_pmd_entry
> > walk_pgd_range
> > ...
> > mark_rodata_ro
> > ? rest_init
> > kernel_init
> >
> 
> Can you send a .config?

Just verified that next-20191126 fails in the same way.

Best regards,
										Pavel

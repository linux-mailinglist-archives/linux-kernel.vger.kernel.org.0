Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0993A12F3D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 05:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgACEfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 23:35:36 -0500
Received: from mailgw-02.dd24.net ([193.46.215.43]:33540 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgACEff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:35:35 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 0BBA15FF0C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 04:35:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id S8wuA3oCIAW0 for <linux-kernel@vger.kernel.org>;
        Fri,  3 Jan 2020 04:35:31 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-46-247.dynamic.mnet-online.de [88.217.46.247])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 04:35:31 +0000 (UTC)
Message-ID: <819da174b9510835cb8dea98241e4d48e4299b4e.camel@scientia.net>
Subject: Re: from 5.2->5.3 lets the system run at considerably higher
 temperatures
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-kernel@vger.kernel.org
Date:   Fri, 03 Jan 2020 05:35:30 +0100
In-Reply-To: <43b7eef5560ede5ad2973964f68d9e6beba63a91.camel@scientia.net>
References: <d05aba2742ae42783788c954e2a380e7fcb10830.camel@scientia.net>
         <43b7eef5560ede5ad2973964f68d9e6beba63a91.camel@scientia.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some further information.


The problem as I've described occurs only on Cinnamon (or better said,
it does not occur when using the GNOME Classic mode of GNOME Shell).

For that reason I've reported 
https://github.com/linuxmint/cinnamon/issues/9085 ... but still it
seems to be some regression in the kernel to, as it runs *much* better
with 5.2.


Cheers,
Chris.



On Thu, 2020-01-02 at 05:00 +0100, Christoph Anton Mitterer wrote:
> Hey again.
> 
> Just checked with 5.4.6 and the problem as described previously still
> exists.
> 
> And effectively idle system runs at ~75 °C even when just typing some
> text or switching some windows.
> Only if doing really absolutely nothing for a long time it may (but
> not
> always) go down to ~65 °C, which is still 5-10°C more than having the
> very same system (same software running, etc.) with a 5.2 kernel.
> 
> top still shows basically nothing.
> 
> I still suspect it could be somehow graphics related:
> - when I switch from the desktop environment to the kernel console,
> temperatures quickly go to ~60°C (which is more close to what's the
> case with 5.2)
> 
> - When doing some video playback, temperatures just explode (which
> they' don't with 5.2, of course they rise there as well).
> So when playing a video like mpv --vo=vaapi, CPU goes quickly to 90°C
> an more (and even when stopping playback, it stays at 80°C for
> minutes).
> Actually, sometimes (but not always) it was much better with --vo=xv.
> 
> The CPU is a Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz, with HD
> Graphics
> 620 (Kaby Lake GT2).
> 
> 
> Thanks,
> Chris.
> 
> 
> 
> Any ideas on what to do or how to somehow debug this?
> 
> Cheers,
> Chris.
> 
> 
> On Mon, 2019-12-16 at 16:15 +0100, Christoph Anton Mitterer wrote:
> > Hey.
> > 
> > Since I've upgraded from kernel 5.2 to 5.3 my system runs a
> > considerably higher temperatures (like 10°C or more).
> > This happens even when it's effectively idle (top shows basically
> > nothing).
> > Downgrading again to 5.2 and high temperatures go away.
> > 
> > I did some more detailed description here:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=945055
> > but really have no clue where to start debugging.
> > 
> > It could be that it's somehow graphics related, as when I switch
> > away
> > from X/Cinnamon to the virtual console, temperatures decrease
> > considerably.
> > 
> > 
> > Anyone else seeing something similar or having some idea how to
> > track
> > this down?
> > 
> > 
> > Thanks,
> > Chris.


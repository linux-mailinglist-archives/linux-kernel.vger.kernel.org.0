Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FBEF462
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 05:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfKEENe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 23:13:34 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48270 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbfKEENe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:13:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id A3E0029D28;
        Mon,  4 Nov 2019 23:13:28 -0500 (EST)
Date:   Tue, 5 Nov 2019 15:13:31 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Brad Boyer <flar@allandria.com>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Staudt <max@enpas.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
In-Reply-To: <20191105031946.GA31507@allandria.com>
Message-ID: <alpine.LNX.2.21.1.1911051444570.160@nippy.intranet>
References: <20191001073539.4488-1-geert@linux-m68k.org> <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org> <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com> <640d4fd8-b879-3cfd-e522-1acc3cbd323a@physik.fu-berlin.de> <20191105005318.GA29558@allandria.com>
 <alpine.LNX.2.21.1.1911051318590.160@nippy.intranet> <20191105031946.GA31507@allandria.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019, Brad Boyer wrote:

> 
> I'll try the PB190 first anyway. It should be easier due to not needing 
> to setup a monitor. 

I think you can put the 630 into a standard VESA video mode (with MacOS or 
Linux) given the right adapter/cable. I have a pin-out somewhere.

> I'm not sure if I ever booted Linux on either of them, since I acquired 
> both about the time I started getting too busy to spend time on such 
> things. I just found the Performa, and it's actually a Performa 630CD 
> but I don't see any obvious difference based on the specs.
> 
> I just took a look at the macide driver, and it appears to do basically
> nothing other than pass a list of addresses into the core ide code. It's
> one of the smallest drivers I've ever seen.
> 

The fly in the ointment is interrupt handling. There is a theoretical bug. 
(Though it doesn't seem to hurt in practice.)

AFAIK the hardware is publicly undocumented and so we need to do 
experiments like this:
https://github.com/fthain/linux/commit/01405199e8d05500bf458df690027655f526a7fd

My suspicion is that macide_clear_irq() does nothing useful. It's not 
called on a Powerbook 190. Maybe it is needed on a PowerBook 150 and 
Performa 630, maybe not...

> > But watch out for leaking capacitors and batteries...
> 
> I should pull out every machine in my collection and look for those 
> sorts of issues. None of them have been checked in at least 5 or 6 
> years.
> 

None of the machines in my collection have any batteries now. Desoldering 
the Ni-Cd PRAM battery from a Powerbook 14x/16x/170/180 is difficult but 
necessary. Powerbook 150 and 190 are easier (no desoldering needed).

-- 

> 	Brad Boyer
> 	flar@allandria.com
> 
> 

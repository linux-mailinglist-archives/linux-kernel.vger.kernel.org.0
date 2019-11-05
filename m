Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C734AEF38B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 03:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfKECdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 21:33:00 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:46380 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfKECc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:32:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 1A42829940;
        Mon,  4 Nov 2019 21:32:55 -0500 (EST)
Date:   Tue, 5 Nov 2019 13:33:00 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Brad Boyer <flar@allandria.com>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Staudt <max@enpas.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] m68k: defconfig: Update defconfigs for v5.4-rc1
In-Reply-To: <20191105005318.GA29558@allandria.com>
Message-ID: <alpine.LNX.2.21.1.1911051318590.160@nippy.intranet>
References: <20191001073539.4488-1-geert@linux-m68k.org> <7fa02d50-6092-5f59-5018-c5b425a30726@enpas.org> <CAMuHMdX3+-JO68LGE-NuT9axRUj3=bbtpDZ8E3v5UNoj5ctLHg@mail.gmail.com> <640d4fd8-b879-3cfd-e522-1acc3cbd323a@physik.fu-berlin.de>
 <20191105005318.GA29558@allandria.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Mon, 4 Nov 2019, Brad Boyer wrote:

> 
> I have a couple old macs with IDE. I have a PowerBook 190 and a Performa 
> (a 636? - it's buried away so I'm not 100% sure) both with IDE drives. 
> I'll try to find time to pull one of them out and see if they still run. 
> Can Linux run on a system with a 68LC040 these days? I know there were 
> issues with FPU emulation at various points. Both of those would lack 
> FPU due to using a 68LC040 chip.
> 

All the PB 190 machines that I've come across have a late revision 68LC040 
CPU that is free of errata. Please see,
http://www.mac.linux-m68k.org/docs/faq.php#sec-4.5

The Performa 636 is highly likely to be affected, but you can run Linux 
from initramfs to avoid page faults in code sections. That would allow you 
to test the IDE driver.

Or you can just replace the CPU with a full 68040, since it is socketed. 

But watch out for leaking capacitors and batteries...

-- 

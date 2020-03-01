Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C249C174AE5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 04:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCAD0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 22:26:39 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:60088 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCAD0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 22:26:39 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 7CE882A28D;
        Sat, 29 Feb 2020 22:26:36 -0500 (EST)
Date:   Sun, 1 Mar 2020 14:26:33 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <20200301010511.GA5195@afzalpc>
Message-ID: <alpine.LNX.2.22.394.2003011337590.15@nippy.intranet>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com> <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com> <20200229131553.GA4985@afzalpc> <alpine.LNX.2.22.394.2003010958170.8@nippy.intranet>
 <20200301010511.GA5195@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Mar 2020, afzal mohammed wrote:

> On Sun, Mar 01, 2020 at 10:11:51AM +1100, Finn Thain wrote:
> > On Sat, 29 Feb 2020, afzal mohammed wrote:
> 
> > > [...] 
> > > Specific to m68k, following changes has been made based on m68 family
> > > ;) feedback,
> > > 
> > 
> > None of my comments were specific to any architecture.
> 
> One thing i had in my background, but realize now that didn't express 
> anywhere in my mails, in essence what Geert mentioned, i.e. being legacy 
> code, i did not give a treatment that would have been given to adding 
> new code.
> 
> But m68k subthread has been a very lively one and as not many changes, 
> felt it was not fair from my side not to handle almost as though it is a 
> new code addition.
> 

I took Geert's comments to be architecture agnostic but perhaps I 
misunderstood.

BTW, how do you distinguish between "new code" and "legacy code"?

And why would you choose to do that when you are writing a tree-wide 
semantic patch?

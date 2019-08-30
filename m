Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9AA3479
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfH3JvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Aug 2019 05:51:05 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35737 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfH3JvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:51:05 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7C221FF807;
        Fri, 30 Aug 2019 09:51:01 +0000 (UTC)
Date:   Fri, 30 Aug 2019 11:51:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        juliensu@mxic.com.tw, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, tglx@linutronix.de,
        vigneshr@ti.com
Subject: Re: [PATCH] Add support for Macronix NAND randomizer
Message-ID: <20190830115100.3fec9bf1@xps13>
In-Reply-To: <OF22C5A579.E2E7676F-ON48258465.002F7F69-48258465.00322849@mxic.com.tw>
References: <1566280428-4159-1-git-send-email-masonccyang@mxic.com.tw>
        <20190824130329.68f310aa@xps13>
        <OF22C5A579.E2E7676F-ON48258465.002F7F69-48258465.00322849@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Thu, 29 Aug 2019 17:07:51 +0800:

> Hi Miquel, 
> 
> 
> > > 
> > > If subpage write not available with hardware ECC, for example,
> > > NAND chip options NAND_NO_SUBPAGE_WRITE be set in driver and
> > > randomizer function is recommended for high-reliability.
> > > Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> > > to see if this high-reliability function is supported.
> > >   
> > 
> > You did not flagged this patch as a v2 and forgot about the changelog.
> > You did not listen to our comments in the last version neither. I was
> > open to a solution with a specific DT property for warned users but I
> > don't see it coming.
> >   
> 
> Based on your comments by specific DT property for randomizer support.
> to add a new property in children nodes:
> 
> i.e,.
> 
> nand: nand-controller@43c30000 {
> 
>                 nand@0 {
>                         reg = <0>;
>                         nand-reliability = "randomizer";

                          mxic,enable-randomizer-otp;

Would be better (with the proper documentation in the bindings).


Thanks,
Miquèl

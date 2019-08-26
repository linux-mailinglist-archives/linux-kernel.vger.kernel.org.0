Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF449CC84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfHZJYu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Aug 2019 05:24:50 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:64619 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:24:50 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x7Q9OfgH004152;
        Mon, 26 Aug 2019 17:24:41 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id C2759AC31551E2DB2389;
        Mon, 26 Aug 2019 17:24:41 +0800 (CST)
In-Reply-To: <20190826092344.7b23ede1@xps13>
References: <1566280428-4159-1-git-send-email-masonccyang@mxic.com.tw>  <20190824130329.68f310aa@xps13>
        <OFF725800E.8B26D2E9-ON48258462.000B94B2-48258462.000FCB85@mxic.com.tw> <20190826092344.7b23ede1@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        juliensu@mxic.com.tw, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, tglx@linutronix.de,
        vigneshr@ti.com
Subject: Re: [PATCH] Add support for Macronix NAND randomizer
MIME-Version: 1.0
X-KeepSent: BC7B2DED:A4E37205-48258462:00332180;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFBC7B2DED.A4E37205-ON48258462.00332180-48258462.0033B2E6@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 26 Aug 2019 17:24:41 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/08/26 PM 05:24:41,
        Serialize complete at 2019/08/26 PM 05:24:41
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-MAIL: TWHMLLG4.macronix.com x7Q9OfgH004152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> 
> Re: [PATCH] Add support for Macronix NAND randomizer
> 
> Hi Mason,
> 
> masonccyang@mxic.com.tw wrote on Mon, 26 Aug 2019 10:52:31 +0800:
> 
> > Hi Miquel,
> > > 
> > > Mason Yang <masonccyang@mxic.com.tw> wrote on Tue, 20 Aug 2019 
13:53:48
> > > +0800:
> > > 
> > > > Macronix NANDs support randomizer operation for user data 
scrambled,
> > > > which can be enabled with a SET_FEATURE.
> > > > 
> > > > User data written to the NAND device without randomizer is still 
> > readable
> > > > after randomizer function enabled.
> > > > The penalty of randomizer are NOP = 1 instead of NOP = 4 and more 
time 
> > period
> > > 
> > > please don't use 'NOP' here, use 'subpage accesses' instead, 
otherwise
> > > people might not understand what it means while it has a real 
impact.
> > > 
> > 
> > okay, understood. 
> > will fix it by next submitting.
> > 
> > > > is needed in program operation and entering deep power-down mode.
> > > > i.e., tPROG 300us to 340us(randomizer enabled)
> > > > 
> > > > If subpage write not available with hardware ECC, for example,
> > > > NAND chip options NAND_NO_SUBPAGE_WRITE be set in driver and
> > > > randomizer function is recommended for high-reliability.
> > > > Driver checks byte 167 of Vendor Blocks in ONFI parameter page 
table
> > > > to see if this high-reliability function is supported.
> > > > 
> > > 
> > > You did not flagged this patch as a v2 and forgot about the 
changelog. 
> > 
> > will fix, thank you.
> > 
> > > You did not listen to our comments in the last version neither. I 
was
> > > open to a solution with a specific DT property for warned users but 
I
> > > don't see it coming. 
> > 
> > Sorry I missed the previous version of "read-retry and randomizer 
support" 
> > patch. 
> > Specific DT property is a good method to control it.
> > 
> > For more high-reliability concern, randomizer is recommended to enable 
by 
> > default,
> > but sub-page write is not allowed when randomizer is enabled.
> > 
> > Since most of HW ECC did not support sub-page write and we think 
driver to 
> > check
> > chip options flags is another simple and good way to enable 
randomizer.
> 
> Sorry but this is wrong. Several controllers and NAND chips support
> subpages. And changing now the behavior with such chips would entirely
> break the concerned setups (see Boris answer about UBI complaining if
> the subpage size changes).

okay, I see.
thanks for your information.

I will patch it based on your comments in the last version.

> 
> Thanks,
> Miqu�l

best regards,
Mason

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================


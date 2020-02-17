Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBCC160CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 09:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgBQIOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 03:14:35 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:56298 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgBQIOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:14:34 -0500
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 01H8ENdB073564;
        Mon, 17 Feb 2020 16:14:23 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id 330F75CF8CA615BE2FE8;
        Mon, 17 Feb 2020 16:14:24 +0800 (CST)
In-Reply-To: <20200109203055.2370a358@collabora.com>
References: <1572256527-5074-1-git-send-email-masonccyang@mxic.com.tw>  <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw> <20200109203055.2370a358@collabora.com>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific lock/unlock
 operatoin
MIME-Version: 1.0
X-KeepSent: 505D0437:0130F15A-48258511:002C7F75;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF505D0437.0130F15A-ON48258511.002C7F75-48258511.002D4341@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 17 Feb 2020 16:14:23 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/02/17 PM 04:14:24,
        Serialize complete at 2020/02/17 PM 04:14:24
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 01H8ENdB073564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

> 
> >  /* Set default functions */
> >  static void nand_set_defaults(struct nand_chip *chip)
> >  {
> > @@ -5782,8 +5810,8 @@ static int nand_scan_tail(struct nand_chip 
*chip)
> >     mtd->_read_oob = nand_read_oob;
> >     mtd->_write_oob = nand_write_oob;
> >     mtd->_sync = nand_sync;
> > -   mtd->_lock = NULL;
> > -   mtd->_unlock = NULL;
> > +   mtd->_lock = nand_lock;
> > +   mtd->_unlock = nand_unlock;
> >     mtd->_suspend = nand_suspend;
> >     mtd->_resume = nand_resume;
> >     mtd->_reboot = nand_shutdown;
> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index 4ab9bcc..2430ecd 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -1136,6 +1136,9 @@ struct nand_chip {
> >        const struct nand_manufacturer *desc;
> >        void *priv;
> >     } manufacturer;
> > +
> > +   int (*_lock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> > +   int (*_unlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> 
> Please drop this _ prefix.

Drop _ prefix of _lock will get compile error due to there is already 
defined "struct mutex lock" in struct nand_chip.

What about keep this _ prefix or patch it to blocklock/blockunlock,
i.e.,
int (*blocklock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
int (*blockunlock)(struct nand_chip *chip, loff_t ofs, uint64_t len);
 

thanks for your time & comments.
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D7112374
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 08:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLDHRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 02:17:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54831 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:17:50 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1icOux-0003vA-St; Wed, 04 Dec 2019 08:17:47 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1icOuw-00075T-Cc; Wed, 04 Dec 2019 08:17:46 +0100
Date:   Wed, 4 Dec 2019 08:17:46 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     naga suresh kumar <nagasureshkumarrelli@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        siva durga paladugu <siva.durga.paladugu@xililnx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: Re: ubifs mount failure
Message-ID: <20191204071746.kfdflui4ziladmjg@pengutronix.de>
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <20191203084134.tgzir4mtekpm5xbs@pengutronix.de>
 <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <614898763.105471.1575364223372.JavaMail.zimbra@nod.at>
 <CALgLF9KPAk_AsecnTMmbdF5qbgqXe7HNOrNariNVbhSr6FVN2g@mail.gmail.com>
 <20191203104558.vpqav3oxsydoe4aw@pengutronix.de>
 <CAFLxGvywFxSrDLLGnLDW6+rMLVUA9Yoi=3sn7wdxqWMydy-w0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvywFxSrDLLGnLDW6+rMLVUA9Yoi=3sn7wdxqWMydy-w0g@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:17:13 up 149 days, 13:27, 126 users,  load average: 0.16, 0.23,
 0.21
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 08:08:48PM +0100, Richard Weinberger wrote:
> On Tue, Dec 3, 2019 at 11:46 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > On Tue, Dec 03, 2019 at 04:06:12PM +0530, naga suresh kumar wrote:
> > > Hi Richard,
> > >
> > > On Tue, Dec 3, 2019 at 2:40 PM Richard Weinberger <richard@nod.at> wrote:
> > > >
> > > > ----- Urspr�ngliche Mail -----
> > > > > Von: "Naga Sureshkumar Relli" <nagasure@xilinx.com>
> > > > > https://elixir.bootlin.com/linux/v5.4/source/fs/ubifs/sb.c#L164
> > > > > we are trying to allocate 4325376 (~4MB)
> > > >
> > > > 4MiB? Is ->min_io_size that large?
> > > if you see https://elixir.bootlin.com/linux/latest/source/fs/ubifs/sb.c#L164
> > > The size is actually ALIGN(tmp, c->min_io_size).
> > > Here tmp is of 4325376 Bytes and min_io_size is 16384 Bytes
> >
> > 'tmp' contains bogus values. Try this:
> >
> > ----------------------------8<--------------------------------
> >
> > From 34f687fce189085f55706b4cddcb288a08f4ee06 Mon Sep 17 00:00:00 2001
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Date: Tue, 3 Dec 2019 11:41:20 +0100
> > Subject: [PATCH] ubifs: Fix wrong memory allocation
> >
> > In create_default_filesystem() when we allocate the idx node we must use
> > the idx_node_size we calculated just one line before, not tmp, which
> > contains completely other data.
> >
> > Fixes: c4de6d7e4319 ("ubifs: Refactor create_default_filesystem()")
> > Reported-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  fs/ubifs/sb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
> > index a551eb3e9b89..6681c18e52b8 100644
> > --- a/fs/ubifs/sb.c
> > +++ b/fs/ubifs/sb.c
> > @@ -161,7 +161,7 @@ static int create_default_filesystem(struct ubifs_info *c)
> >         sup = kzalloc(ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size), GFP_KERNEL);
> >         mst = kzalloc(c->mst_node_alsz, GFP_KERNEL);
> >         idx_node_size = ubifs_idx_node_sz(c, 1);
> > -       idx = kzalloc(ALIGN(tmp, c->min_io_size), GFP_KERNEL);
> > +       idx = kzalloc(ALIGN(idx_node_size, c->min_io_size), GFP_KERNEL);
> >         ino = kzalloc(ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size), GFP_KERNEL);
> >         cs = kzalloc(ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size), GFP_KERNEL);
> 
> Oh, looks good! Thanks for fixing, Sascha!

Will you apply this one? Otherwise I resend with the proper tags added.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

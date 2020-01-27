Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310D714A2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 12:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgA0LYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 06:24:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44895 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgA0LYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:24:31 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1iw2VJ-00010F-8G; Mon, 27 Jan 2020 12:24:29 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1iw2VI-0001ty-D3; Mon, 27 Jan 2020 12:24:28 +0100
Date:   Mon, 27 Jan 2020 12:24:28 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Pali =?iso-8859-15?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, kernel@pengutronix.de
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
Message-ID: <20200127112428.sdfxvlqdox5efzcb@pengutronix.de>
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
 <20200127111630.bqqzhj57tzt7geds@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127111630.bqqzhj57tzt7geds@pali>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:22:40 up 203 days, 17:32, 93 users,  load average: 0.12, 0.33,
 0.36
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 12:16:30PM +0100, Pali Roh�r wrote:
> On Monday 06 January 2020 09:16:05 Sascha Hauer wrote:
> > On Wed, Dec 25, 2019 at 07:18:40PM +0100, Pali Roh�r wrote:
> > > Hello Sascha!
> > > 
> > > On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
> > > > ata_qc_complete_multiple() is called with a mask of the still active
> > > > tags.
> > > > 
> > > > mv_sata doesn't have this information directly and instead calculates
> > > > the still active tags from the started tags (ap->qc_active) and the
> > > > finished tags as (ap->qc_active ^ done_mask)
> > > > 
> > > > Since 28361c40368 the hw_tag and tag are no longer the same and the
> > > > equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> > > > initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> > > > started and this will be in done_mask on completion. ap->qc_active ^
> > > > done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
> > > > the internal tag will never be reported as completed.
> > > > 
> > > > This is fixed by introducing ata_qc_get_active() which returns the
> > > > active hardware tags and calling it where appropriate.
> > > > 
> > > > This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
> > > > problem. There is another case in sata_nv that most likely needs fixing
> > > > as well, but this looks a little different, so I wasn't confident enough
> > > > to change that.
> > > 
> > > I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
> > > version correctly. More details are in email:
> > > 
> > > https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/T/
> > > 
> > > I tried this patch and it fixed above problems with sata_nv.ko. It just
> > > needs small modification (see below).
> > > 
> > > So you can add my:
> > > 
> > > Tested-by: Pali Roh�r <pali.rohar@gmail.com>
> > > 
> > > And I hope that patch would be backported to 4.18 and 4.19 stable
> > > branches soon as distributions kernels are broken for machines with
> > > these nvidia sata controllers.
> > > 
> > > Anyway, what is that another case in sata_nv which needs to be fixed
> > > too?
> > 
> > It's in nv_swncq_sdbfis(). Here we have:
> > 
> > 	sactive = readl(pp->sactive_block);
> > 	done_mask = pp->qc_active ^ sactive;
> > 
> > 	pp->qc_active &= ~done_mask;
> > 	pp->dhfis_bits &= ~done_mask;
> > 	pp->dmafis_bits &= ~done_mask;
> > 	pp->sdbfis_bits |= done_mask;
> > 	ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> > 
> > Sascha
> 
> Ok. Are you going to fix also this case?

As said, this one looks slightly different than the others and I would
prefer if somebody could fix it who actually has a hardware and can test
it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

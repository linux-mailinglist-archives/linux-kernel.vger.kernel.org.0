Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C399DD31D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 22:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJJUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 16:14:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55931 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfJJUOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:14:06 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iIeoz-0004VC-S0; Thu, 10 Oct 2019 22:14:01 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iIeoy-0005K0-BS; Thu, 10 Oct 2019 22:14:00 +0200
Date:   Thu, 10 Oct 2019 22:14:00 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/8] recordmcount: Rewrite error/success handling
Message-ID: <20191010201400.k4tcsbx2cqe5wjqs@pengutronix.de>
References: <cover.1564596289.git.mhelsley@vmware.com>
 <8ba8633d4afe444931f363c8d924bf9565b89a86.1564596289.git.mhelsley@vmware.com>
 <20191009104626.f3hy5dcehdfagxto@pengutronix.de>
 <20191009110538.5909fec6@gandalf.local.home>
 <20191009152217.whklst5vwrwvsjc4@pengutronix.de>
 <20191010122321.7329329f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191010122321.7329329f@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:23:21PM -0400, Steven Rostedt wrote:
> On Wed, 9 Oct 2019 17:22:18 +0200
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > > diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> > > index 3796eb37fb12..6dbec46b7703 100644
> > > --- a/scripts/recordmcount.h
> > > +++ b/scripts/recordmcount.h
> > > @@ -389,11 +389,8 @@ static int nop_mcount(Elf_Shdr const *const relhdr,
> > >  			mcountsym = get_mcountsym(sym0, relp, str0);
> > >  
> > >  		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
> > > -			if (make_nop) {
> > > +			if (make_nop)
> > >  				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
> > > -				if (ret < 0)
> > > -					return -1;
> > > -			}  
> > 
> > Yes, this patch fixes building for me.
> 
> May I add to my patch:
> 
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Yeah, sure.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

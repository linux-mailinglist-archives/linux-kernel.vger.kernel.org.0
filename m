Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1CD2E85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfJJQXZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Oct 2019 12:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:23:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D989B214E0;
        Thu, 10 Oct 2019 16:23:23 +0000 (UTC)
Date:   Thu, 10 Oct 2019 12:23:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/8] recordmcount: Rewrite error/success handling
Message-ID: <20191010122321.7329329f@gandalf.local.home>
In-Reply-To: <20191009152217.whklst5vwrwvsjc4@pengutronix.de>
References: <cover.1564596289.git.mhelsley@vmware.com>
        <8ba8633d4afe444931f363c8d924bf9565b89a86.1564596289.git.mhelsley@vmware.com>
        <20191009104626.f3hy5dcehdfagxto@pengutronix.de>
        <20191009110538.5909fec6@gandalf.local.home>
        <20191009152217.whklst5vwrwvsjc4@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 17:22:18 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> > diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> > index 3796eb37fb12..6dbec46b7703 100644
> > --- a/scripts/recordmcount.h
> > +++ b/scripts/recordmcount.h
> > @@ -389,11 +389,8 @@ static int nop_mcount(Elf_Shdr const *const relhdr,
> >  			mcountsym = get_mcountsym(sym0, relp, str0);
> >  
> >  		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
> > -			if (make_nop) {
> > +			if (make_nop)
> >  				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
> > -				if (ret < 0)
> > -					return -1;
> > -			}  
> 
> Yes, this patch fixes building for me.

May I add to my patch:

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

?

-- Steve

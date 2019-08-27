Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761299F38E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfH0TwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731405AbfH0TwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:52:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDBE20674;
        Tue, 27 Aug 2019 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566935543;
        bh=ZNngPOo5sREOCpdfzOYYctOb0x1tvWdUphEpciupKo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JowPzasut+xd8bPQ7hheMDMj6dv+3tPnoilVHbn4IdwUHucxfxrg60uylZQ3SjnKQ
         B+tL71KFXgdX4P1WRuALM8xAa9RG9/pDTXsTENxkFLIg0hl8t11ZE8kQCOOFJw2eIK
         90HkFschuRPPbK5r3SifSMrtGimh58pWewUjo06c=
Date:   Tue, 27 Aug 2019 21:52:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-spdx@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add entry for LICENSES and SPDX stuff
Message-ID: <20190827195220.GA30322@kroah.com>
References: <20190827172519.GA28849@kroah.com>
 <alpine.DEB.2.21.1908272135150.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908272135150.1939@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:36:23PM +0200, Thomas Gleixner wrote:
> On Tue, 27 Aug 2019, Greg Kroah-Hartman wrote:
> 
> > Thomas and I seem to have become the "unofficial" maintainers for these
> > files and questions about SPDX things.  So let's make it official.
> > 
> > Reported-by: "Darrick J. Wong" <darrick.wong@oracle.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9234,6 +9234,17 @@ F:	include/linux/nd.h
> >  F:	include/linux/libnvdimm.h
> >  F:	include/uapi/linux/ndctl.h
> >  
> > +LICENSES and SPDX stuff
> > +M:	Thomas Gleixner <tglx@linutronix.de>
> > +M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > +L:	linux-spdx@vger.kernel.org
> > +S:	Maintained
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
> > +F:	COPYING
> > +F:	LICENSES/
> > +F:	scripts/spdxcheck-test.sh
> > +F:	scripts/spdxcheck.py
> 
> We probably want to add Documentation/process/license-rules.rst as well.

Good idea, will go refresh this patch...

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05164E07F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 08:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFUGVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 02:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfFUGVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:21:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265D4208C3;
        Fri, 21 Jun 2019 06:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561098077;
        bh=FzLeeln4yvNk1EUhlNm4sx4apVBZuXfj+bg74Wl6hzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUYF/7sqRqsVCMTvwR7UiaaK9FVwW0tcgYEijuWTCJdkBHAUbhgHwe8sknPhoeTpf
         krczKfl8xWJ+hQMy+QUYjF9N+IZNUmulO+NJAoGJZlYbm2U5yIDOztcJBU4e1nDWSt
         6qCmDNrHWt4eRonz6LaIBsdFKO8ZL6YA/o0BWKdI=
Date:   Fri, 21 Jun 2019 08:21:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
Message-ID: <20190621062115.GA11084@kroah.com>
References: <20190522100808.66994f6b@canb.auug.org.au>
 <20190528114320.30637398@canb.auug.org.au>
 <20190621095907.4a6a50fa@canb.auug.org.au>
 <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
 <1561077341.7970.47.camel@HansenPartnership.com>
 <yq1fto3pwo0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1fto3pwo0.fsf@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 09:14:07PM -0400, Martin K. Petersen wrote:
> 
> James,
> 
> > There's two problems.  One is simple terminology: the
> > Documentation/process/licence-rules.rst say:
> >
> > GPL-2.0 means GPL 2 only
> > GPL-2.0+ means GPL 2 or later
> >
> > I believe RMS made a fuss about this and he finally agreed to 
> >
> > GPL-2.0-only
> > GPL-2.0-or-later
> 
> Looks like there are tons of the old style SPDX tags in the kernel. Is
> there going to be a treewide conversion to the new tag format?

Not any time soon.  Both are "valid" for us, and the tools.  We are
focusing on actually tagging all files before we worry about these two
different types of tag that mean the same thing.

thanks,

greg k-h

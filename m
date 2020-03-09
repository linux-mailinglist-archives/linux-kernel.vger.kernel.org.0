Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2628217DE38
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCILJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 07:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgCILJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:09:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4244D2051A;
        Mon,  9 Mar 2020 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583752143;
        bh=xeVZYWJE37/+2qxtaIzD+1Mnqj/kL4iSm38yjyMa79Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRcg39Xl3X9VgRSwUKqtV08Kn14AAr5t7Ak7jX+1fFGZGLXGl5NSUg5rcUmX8mDpT
         Gh066Zt1E8ORO4VVRuoo/R4nqYuXS45StHTNHMtwkXUJj6vI4Aanea0pAEuSFXR6xh
         ys+1Ymq+k9AAI4LwM1c3azhfv5O1bj0CG1+NwxwQ=
Date:   Mon, 9 Mar 2020 12:09:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     devel@driverdev.osuosl.org, Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: vt6656: Declare a few variables as __read_mostly
Message-ID: <20200309110901.GB183429@kroah.com>
References: <20200301112620.7892-1-oscar.carter@gmx.com>
 <20200301122514.GA1461917@kroah.com>
 <20200301131701.GA7487@ubuntu>
 <20200301150913.GA1470815@kroah.com>
 <20200307082906.GA2948@ubuntu>
 <20200309093210.GA7693@qd-ubuntu>
 <20200309103407.GB180589@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309103407.GB180589@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:34:07AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 09, 2020 at 09:32:10AM +0000, Quentin Deslandes wrote:
> > On Sat, Mar 07, 2020 at 09:29:06AM +0100, Oscar Carter wrote:
> > > On Sun, Mar 01, 2020 at 04:09:13PM +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Mar 01, 2020 at 02:17:01PM +0100, Oscar Carter wrote:
> > > > This is a USB driver, performance is always limited to the hardware, not
> > > > the CPU location of variables.
> > > 
> > > Thank you for the explanation.
> > > 
> > > >
> > > > Please always benchmark things to see if it actually makes sense to make
> > > > changes like this, before proposing them.
> > > 
> > > I'm sorry.
> > > 
> > 
> > I've been removed from CC list on Greg's answer, so I haven't seen the
> > explanation earlier and reviewed the patch the next day. I should have
> > know better, won't happen again.
> 
> You weren't on the original list of people on the patch, so I didn't
> remove anything here that I can tell.

Turns out you were, on the lkml one, but not the one that went through
the driver-devel list.  odd...


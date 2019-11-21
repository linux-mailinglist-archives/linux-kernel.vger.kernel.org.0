Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6053A1051FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 13:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKUMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 07:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfKUMAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:00:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C05020855;
        Thu, 21 Nov 2019 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337649;
        bh=hPY3CX63GlCkHmgiEg/Xb1Y9IcZqdATjFaXqtWUPVIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQE2Ls8f2jq/f28Qd8caaxiEhS+imwQRWG3lyp5yoiOhkcZ+IYWJvyRpys3k1QXYc
         fI6jcYZZsHyf97/G8+CYiJ8GvXZcyDo/6wjxaC4/61TVoAu/fq8oRrF47J1Kt/JVgH
         f8TK0BRoPdgDPbXQ3bjI0b1cgVm+PYOOu5J+qtOI=
Date:   Thu, 21 Nov 2019 13:00:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of: property: Fix the semantics of of_is_ancestor_of()
Message-ID: <20191121120047.GA429384@kroah.com>
References: <20191120080230.16007-1-saravanak@google.com>
 <20191120153625.GA2981769@kroah.com>
 <CAGETcx9eB0ZicHs=8jxwRxbKYHKxoV5u7otud_TAx2Z_DyTw0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9eB0ZicHs=8jxwRxbKYHKxoV5u7otud_TAx2Z_DyTw0Q@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 01:50:42PM -0800, Saravana Kannan wrote:
> On Wed, Nov 20, 2019 at 7:36 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:02:29AM -0800, Saravana Kannan wrote:
> > > The of_is_ancestor_of() function was renamed from of_link_is_valid()
> > > based on review feedback. The rename meant the semantics of the function
> > > had to be inverted, but this was missed in the earlier patch.
> > >
> > > So, fix the semantics of of_is_ancestor_of() and invert the conditional
> > > expressions where it is used.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/property.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > What git commit does this patch fix?
> >
> 
> Fixes commit a3e1d1a7f5fcc. Let me know if you want me to send a v2 or
> if you can fix up the commit text on your end.

I'll fix it up.

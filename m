Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4359520DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfEPRXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 13:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfEPRXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:23:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A3B2082E;
        Thu, 16 May 2019 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558027416;
        bh=aipu1xCScAmxsIDCVAGJFvMQuboltzQhJx2HPiyJ++w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Seb2nbKqECvln2KzeWb6jszLx79UmuWd4SaQsxxXbP9gOhKwT4aOi/bhN1At9lVgp
         EAH9vQN+wru8bZD4yJzRd7dDGhGl3X9mCcbIeOBjzNezWZh1dkfXLev94MwzCfk9cv
         OKdbDJvSdFwACkSjQjOL7mwMa09M6e34GwQRXNjE=
Date:   Thu, 16 May 2019 19:23:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] char: misc: Move EXPORT_SYMBOL immediately next to
 the functions/varibles
Message-ID: <20190516172333.GB32608@kroah.com>
References: <20190515141731.27908-1-parna.naveenkumar@gmail.com>
 <20190515151342.GC23599@kroah.com>
 <CAKXhv7cO7CLSW1mxLbo8-s7akSsXzsRY+U445B=SNhJA8oqppQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXhv7cO7CLSW1mxLbo8-s7akSsXzsRY+U445B=SNhJA8oqppQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 04:36:08PM +0530, Naveen Kumar Parna wrote:
> On Wed, 15 May 2019 at 20:43, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, May 15, 2019 at 07:47:31PM +0530, parna.naveenkumar@gmail.com wrote:
> > > From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> > >
> > > According to checkpatch: EXPORT_SYMBOL(foo); should immediately follow its
> > > function/variable.
> > >
> > > This patch fixes the following checkpatch.pl issues in drivers/char/misc.c:
> > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > >
> > > Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> > > ---
> > >  drivers/char/misc.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > Where are patches 1/3 and 2/3 of this series?
> It does not has corresponding 1/3 and 2/3 patches. By mistake I used
> wrong argument to 'git format-patch' command.

Ok, now dropped, please fix up and resend properly.

greg k-h

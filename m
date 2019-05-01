Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30B1093D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfEAOlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 10:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfEAOlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:41:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C334208C3;
        Wed,  1 May 2019 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556721710;
        bh=9ux677YvCD8drAwcC+DowMkCgKvktyOTtBSE5psC2ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLbm3TZOl7O0Liw1uytgXxISdYeWjhvzW6/ei/l5XP2HlJtQV6E6CktJ211YYgiwh
         Hc5Z4zcX1hMsNLvRoavnr/5bzQ5bneK/iUBrC9opCi3hZMwLQdt2sWp3mNIAn4X/zA
         xfBUJI//Chnxs1IecGfMBG+qiv/2o8yaIfZq4Vd4=
Date:   Wed, 1 May 2019 16:41:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] staging/fieldbus-dev for 5.2
Message-ID: <20190501144147.GA31461@kroah.com>
References: <20190501140624.6931-1-TheSven73@gmail.com>
 <20190501142332.GA13008@kroah.com>
 <20190501142412.GB13008@kroah.com>
 <CAGngYiVznEOQk-Tbyh6km+=+70gJebBEATxN5A8OE6iEzrHXqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVznEOQk-Tbyh6km+=+70gJebBEATxN5A8OE6iEzrHXqA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:30:06AM -0400, Sven Van Asbroeck wrote:
> On Wed, May 1, 2019 at 10:24 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > And as this is just a single patch, handling them as patches is much
> > easier anyway.  Only when you get into the 20+ at a time does pull
> > requests help.
> >
> 
> Patches are much easier for me too, but I assumed this had to be done via a
> pull request.
> 
> How do you distinguish between a patch that's still spinning on the
> mailing list,
> and one coming from my next tree? The Reviewed-by or Acked-by tag?

If you forward it on, I trust that one :)

But for cleanup stuff, I'll take them from anyone usually, that's what
staging is there for.  I can wait until I see a reviewed or acked tag
from you before queueing it up, if you want me to.  I do that for some
portions of staging today as the maintainers of those areas want a
chance to test/review it.

thanks,

greg k-h

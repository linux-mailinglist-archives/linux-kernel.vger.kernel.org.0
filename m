Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3335EB48B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404597AbfIQIBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfIQIBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:01:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E9F20665;
        Tue, 17 Sep 2019 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568707281;
        bh=k48l3BZNW8Y2RqnalNFy5G5V+ClMlUs91r1z7/69GQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VeXxAKe/6T+2FtexCv6q3KHO8oAgPitvzETZDMr1tomT2jNkoSOehi35Ppr2j8nmU
         RGEGT3Nm0RzlO60v/IMrZEOiQqWhnGyrLXyr/QEmwDDVfZQoTuXiuS6xoAqysaE8tE
         B1XXm860yLZSDWfOaV8veIfhy+oE7PAPWjbj+M0k=
Date:   Tue, 17 Sep 2019 10:01:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gregory Nowak <greg@gregn.net>
Cc:     devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, linux-kernel@vger.kernel.org,
        John Covici <covici@ccs.covici.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190917080118.GC2075173@kroah.com>
References: <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
 <20190821222209.GA4577@gregn.net>
 <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
 <20190909025429.GA4144@gregn.net>
 <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
 <20190915134300.GA552892@kroah.com>
 <CAOtcWM2MD-Z1tg7gdgzrXiv7y62JrV7eHnTgXpv-LFW7zRApjg@mail.gmail.com>
 <20190916134727.4gi6rvz4sm6znrqc@function>
 <20190916141100.GA1595107@kroah.com>
 <20190916223848.GA8679@gregn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916223848.GA8679@gregn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 03:38:48PM -0700, Gregory Nowak wrote:
> On Mon, Sep 16, 2019 at 04:11:00PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 16, 2019 at 03:47:28PM +0200, Samuel Thibault wrote:
> > > Okash Khawaja, le dim. 15 sept. 2019 19:41:30 +0100, a ecrit:
> > > > I have attached the descriptions.
> > > 
> > > Attachment is missing :)
> > 
> > I saw it :)
> > 
> > Anyway, please put the Description: lines without a blank after that,
> > with the description text starting on that same line.
> > 
> > thanks!
> > 
> > greg k-h
> 
> It's attached. Hope the indentation is OK.

Alignment is a bit off, you forgot a tab after "Description:"

And you have some trailing whitespace in the document :(

thanks,

greg k-h

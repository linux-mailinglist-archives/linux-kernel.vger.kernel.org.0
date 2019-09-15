Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4725DB3050
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfIONnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 09:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfIONnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:43:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E34214DA;
        Sun, 15 Sep 2019 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554983;
        bh=K2IkYFtvJjpi7oAgR3T2CvTC1SYGP8XAj1GcMabF28c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjBmx+26gUMDBXZWv2skoKgp7iiWBOHv14UDOZX7DUqFOvkPHe5wavy0w0JI4V8De
         jGMTZLlqE2zhaHaN2vCw/7WJwcKO7RPz+wLb5IgWNQv/22Xn4Mf6J2pCkTMsO9sCQV
         BDKTELwulVTLE269VOpIvSP+NBTnLF6nOAlLapAw=
Date:   Sun, 15 Sep 2019 15:43:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     Gregory Nowak <greg@gregn.net>, devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, linux-kernel@vger.kernel.org,
        John Covici <covici@ccs.covici.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190915134300.GA552892@kroah.com>
References: <20190712092319.wmke4i7zqzr26tly@function>
 <20190713004623.GA9159@gregn.net>
 <20190725035352.GA7717@gregn.net>
 <875znqhia0.fsf@cmbmachine.messageid.invalid>
 <m3sgqucs1x.wl-covici@ccs.covici.com>
 <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
 <20190821222209.GA4577@gregn.net>
 <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
 <20190909025429.GA4144@gregn.net>
 <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 10:08:35PM +0100, Okash Khawaja wrote:
> On Mon, Sep 9, 2019 at 3:55 AM Gregory Nowak <greg@gregn.net> wrote:
> >
> > On Sun, Sep 08, 2019 at 10:43:02AM +0100, Okash Khawaja wrote:
> > > Sorry, I have only now got round to working on this. It's not complete
> > > yet but I have assimilated the feedback and converted subjective
> > > phrases, like "I think..." into objective statements or put them in
> > > TODO: so that someone else may verify. I have attached it to this
> > > email.
> >
> > I think bleeps needs a TODO, since we don't know what values it accepts, or
> > what difference those values make. Also, to keep things uniform, we
> > should replace my "don't know" for trigger_time with a TODO. Looks
> > good to me otherwise. Thanks.
> 
> Great thanks. I have updated.
> 
> I have two questions:
> 
> 1. Is it okay for these descriptions to go inside
> Documentation/ABI/stable? They have been around since 2.6 (2010). Or
> would we prefer Documentation/ABI/testing/?

stable is fine.

thanks,

greg k-h

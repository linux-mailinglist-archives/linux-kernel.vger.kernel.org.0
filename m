Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5017C33E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfGaNV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 09:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfGaNV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:21:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D910B20659;
        Wed, 31 Jul 2019 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564579317;
        bh=GipVVauhW/wKx9iucMJLwGJCB7kgbE+axGy+rYPKZq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ff7NNB4QXvnTRr5XOTPnks0RexgxyDFeMT8n1FTh/8Ngxhj2ul/L0HkcM80gk6m6K
         SJcodqvyYXm6wFqN7sHCtSnDIv6nabEWiVhnc38nU/g3aWjpFauDyxvQ1jZI1aRlT0
         Dac8WfCfHjMt1WMz0AQtUW6L5RgNkNAZbGdeaC4E=
Date:   Wed, 31 Jul 2019 15:21:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCH v2 01/10] driver core: add dev_groups to all drivers
Message-ID: <20190731132155.GB12603@kroah.com>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731124349.4474-2-gregkh@linuxfoundation.org>
 <s5h4l32s71l.wl-tiwai@suse.de>
 <20190731125104.GA6062@kroah.com>
 <20190731130800.GA147138@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731130800.GA147138@dtor-ws>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 06:08:00AM -0700, Dmitry Torokhov wrote:
> On Wed, Jul 31, 2019 at 02:51:04PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 31, 2019 at 02:49:26PM +0200, Takashi Iwai wrote:
> > > On Wed, 31 Jul 2019 14:43:40 +0200,
> > > Greg Kroah-Hartman wrote:
> > > > 
> > > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > 
> > > > Add the ability for the driver core to create and remove a list of
> > > > attribute groups automatically when the device is bound/unbound from a
> > > > specific driver.
> > > > 
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Missing sign-off from Dmitry?
> > 
> > He never provided it :(
> > 
> > Dmitry, can you please do so?  I forgot to include that in the cover
> > leter...
> 
> Yeah, sorry, I thought what I sent was a draft to be used as you wish
> with it; I did not expect to be put down as an author. Anyway,

Your patch pretty much worked as-is, I only had to change one line.  You
did a nice job :)

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, I'll add this.

greg k-h

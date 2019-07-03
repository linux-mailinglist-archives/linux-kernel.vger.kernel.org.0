Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1625E960
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfGCQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 12:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:39:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C772189E;
        Wed,  3 Jul 2019 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562171951;
        bh=SE+Je5EFsMdGD+TiwNqygLRpk2ISs/GklnKAT/Yq7NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE/PhhxKetWxBnBk54zBTk1TxofIZkp3rz4c1cqtxi5BOtKVqDiRiPLRkbWvxIeDE
         CvmZNTpecsETwCJWZ0mDgpPnayMUIrjZ95qst79wOUmLsTlbIQtv0l0kc9TJSprYWT
         6WY+1OMHUsfKrI81jp6FBnIWnyKis9Leala/5hxU=
Date:   Wed, 3 Jul 2019 18:39:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers/usb/typec/tps6598x.c: fix portinfo width
Message-ID: <20190703163908.GB17160@kroah.com>
References: <20190628083417.GA21701@kuha.fi.intel.com>
 <f8daf204d49fff00db33e2b417a20afcc58ad56e.1561712364.git.nikolaus.voss@loewensteinmedical.de>
 <20190628095843.GB21701@kuha.fi.intel.com>
 <alpine.DEB.2.20.1906281208190.21573@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1906281208190.21573@fox.voss.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 12:10:41PM +0200, Nikolaus Voss wrote:
> On Fri, 28 Jun 2019, Heikki Krogerus wrote:
> > On Fri, Jun 28, 2019 at 11:01:08AM +0200, Nikolaus Voss wrote:
> > > Portinfo bit field is 3 bits wide, not 2 bits. This led to
> > > a wrong driver configuration for some tps6598x configurations.
> > > 
> > > Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> > > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > 
> > Shouldn't this be applied to the stable trees as well?
> 
> Oh, yes, forgot that again... Greg, could you...?

It's not like I have anything else to do... :)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730A39EF34
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfH0PnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 11:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfH0PnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:43:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28DE220578;
        Tue, 27 Aug 2019 15:43:09 +0000 (UTC)
Date:   Tue, 27 Aug 2019 17:43:08 +0200
From:   Greg KH <greg@kroah.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/9] staging: move greybus core out of staging
Message-ID: <20190827154308.GD534@kroah.com>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190827133611.GE23584@kadam>
 <20190827134557.GA25038@kroah.com>
 <m3d0gqisua.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d0gqisua.fsf@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:30:21PM +0100, Rui Miguel Silva wrote:
> Hi,
> On Tue 27 Aug 2019 at 14:45, Greg Kroah-Hartman wrote:
> > On Tue, Aug 27, 2019 at 04:36:11PM +0300, Dan Carpenter wrote:
> >> I can't compile greybus so it's hard to run Smatch on it...  I have a
> >> Smatch thing which ignores missing includes and just tries its best.
> >> It mostly generates garbage output but a couple of these look like
> >> potential issues:
> >
> > Why can't you compile the code?
> >
> 
> I think we are missing includes in some of the
> greybus header files.

Really?  Where?  Builds fine here and passes 0-day :)

thanks,

greg k-h

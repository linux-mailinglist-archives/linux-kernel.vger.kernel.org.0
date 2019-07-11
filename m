Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2B765B69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfGKQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 12:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfGKQVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:21:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266152084B;
        Thu, 11 Jul 2019 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562862107;
        bh=dwxmnFJQD9WfB+laAgJb7CKoDYg6vGPGHtS6cfEzyW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xL1tCB1XmVljRY2eDGvy/+E103CZASmjJ6RP7godtQs64MvYwWL5gQBP8pZ4hZkxZ
         LJblqgG2TDHY8yZEaIlsEFw5t6sneGryqd52YnOPyG2B8RpYbRMt9NGyeVMY+NLWFc
         FyGD/4eMjmgfqjnou8ogpEW2532AHu0/jA3rcc1w=
Date:   Thu, 11 Jul 2019 18:21:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Je Yen Tam <je.yen.tam@ni.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v3] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Message-ID: <20190711162144.GA588@kroah.com>
References: <20190705083349.44047-1-je.yen.tam@ni.com>
 <20190705090422.GA32289@kroah.com>
 <MN2PR04MB592075355D90BC59B79DFCF8B7F50@MN2PR04MB5920.namprd04.prod.outlook.com>
 <MN2PR04MB59207F479D213EE19333CA6AB7F30@MN2PR04MB5920.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB59207F479D213EE19333CA6AB7F30@MN2PR04MB5920.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 04:01:28PM +0000, Je Yen Tam wrote:
> > > On Fri, Jul 05, 2019 at 01:33:49AM -0700, jeyentam wrote:
> > > > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> > > >
> > > > Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> > > > ---
> > > >  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
> > > >  1 file changed, 294 insertions(+), 4 deletions(-)
> > >
> > > What changed from the previous versions?
> > >
> > > Always put that below the --- line.
> > >
> > > Please fix up and send a v4 with that information.
> >
> > Ok, will do so.
> 
> Hi, please be noted that a v4 is submitted and ready for review.

It is the middle of the merge window.  I can't do anything with any
patches until after 5.3-rc1 is out, and then, give me a few weeks to
catch up on the pending backlog.

thanks,

greg k-h

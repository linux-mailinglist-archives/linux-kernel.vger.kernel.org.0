Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF93C1385C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfEDJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 05:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfEDJBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:01:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC279206BB;
        Sat,  4 May 2019 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556960470;
        bh=1wog7op6KUdEbh1ddTxIbGBcVvZCfXmyXwq3L2djir0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLFImG8vEA6IBIoJ5i4sZ2ZDvwqgE8y+uv0rcN8zC+X2w0/wK7KCt+n7CcLSCay2H
         tbMjjMhcdkrNdFpVxfx8VCGv+0XgQZ8dJ4pKFefj+QHUEdLriQR++o5nJFQZ0FiStA
         t9ghh8TgGkalmZRSZve6Ek9jJyXFHUC9y88s8gIc=
Date:   Sat, 4 May 2019 11:01:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190504090107.GC13840@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172345.GC1874@kroah.com>
 <BL0PR02MB568178214B7789431977E91BCB350@BL0PR02MB5681.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB568178214B7789431977E91BCB350@BL0PR02MB5681.namprd02.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 04:46:12PM +0000, Dragan Cvetic wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Thursday 2 May 2019 18:24
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
> > 
> > On Sat, Apr 27, 2019 at 11:04:58PM +0100, Dragan Cvetic wrote:
> > > Add char device interface per DT node present and support
> > > file operations:
> > > - open(),
> > > - close(),
> > > - unlocked_ioctl(),
> > > - compat_ioctl().
> > 
> > Why do you need compat_ioctl() at all?  Any "new" driver should never
> > need it.  Just create your structures properly.
> 
> This was a comment from Arnd, see https://lkml.org/lkml/2019/3/19/377.
> Please advise.

Why do you need a compat_ioctl callback when there is nothing to fix up?

thanks,

greg k-h

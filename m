Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3FE41E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 09:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436639AbfFLHqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 03:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406508AbfFLHqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:46:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01FD72063F;
        Wed, 12 Jun 2019 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560325562;
        bh=HBZmv5Jn4n9YMcC+WRXXHUaGqXSrdl/9dvlD6Nov5CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V93fDOv58OVuF84Uc+57iq7ktK3sbLn4eXKDOQ0FdpBC8DVe+hcp9xwb8VFhDhpk/
         zJ+HbHKsCpFAu+Ivji7vr5PkY+YAqVUAXAqB0sWyp7EKrSpblnJM3dN6s2DbZueMI9
         ivUk4cQDgo+1ohgOriBPHRPFm41Gc2Xlk+qKZL7M=
Date:   Wed, 12 Jun 2019 09:46:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: kpc2000: remove unnecessary comments in
 kp2000_pcie_probe
Message-ID: <20190612074600.GA17100@kroah.com>
References: <20190610200535.31820-1-simon@nikanor.nu>
 <20190610200535.31820-3-simon@nikanor.nu>
 <20190612073936.GD1915@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612073936.GD1915@kadam>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 10:39:36AM +0300, Dan Carpenter wrote:
> On Mon, Jun 10, 2019 at 10:05:35PM +0200, Simon Sandstr�m wrote:
> > @@ -349,9 +340,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
> >  		goto err_remove_ida;
> >  	}
> >  
> > -	/*
> > -	 * Step 4: Setup the Register BAR
> > -	 */
> > +	// Setup the Register BAR
> 
> Greg, are we moving the C++ style comments?  Linus is fine with them.  I
> don't like them but whatever...

I don't like them either.  I'm only "ok" with them on the very first
line of the file.  Linus chose // to make it "stand out" from the normal
flow of the file, which is fine for an SPDX line.  So putting these in
here like this is not ok to me.

thanks,

greg k-h

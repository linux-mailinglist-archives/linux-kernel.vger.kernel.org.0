Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DBD3F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfJKMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 08:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfJKMIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:08:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009CE214E0;
        Fri, 11 Oct 2019 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570795729;
        bh=7CIPFLIoZZluL3rWipgb8S80+pXhDenVx59NnSIkLzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3mw0mo48g1XYqGl1KLzGYWhF9OmlOsXrOiw/4Jmr9Sp2dGvl5NeqmR2aPmdvCwCw
         hMzGgTWLATc14Lqf0kZV91LuEJMGKIyW+++M3RQvXiWWKmAqfzm+B4O8QWjiQMv54h
         lqvSe4tlHsdbHfVYwq/81oFSt+2VTM8o8QFLbMP4=
Date:   Fri, 11 Oct 2019 14:08:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: rtl8723bs: Remove comparisons to NULL in
 conditionals
Message-ID: <20191011120847.GB1143018@kroah.com>
References: <cover.1570712632.git.wambui.karugax@gmail.com>
 <f4752d3a49e02193ed7b47a353e18e56d94b5a68.1570712632.git.wambui.karugax@gmail.com>
 <20191011105404.GA4774@kadam>
 <20191011120717.GA1143018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011120717.GA1143018@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 02:07:17PM +0200, Greg KH wrote:
> On Fri, Oct 11, 2019 at 01:54:04PM +0300, Dan Carpenter wrote:
> > On Thu, Oct 10, 2019 at 04:15:29PM +0300, Wambui Karuga wrote:
> > >  	psetauthparm = rtw_zmalloc(sizeof(struct setauth_parm));
> > > -	if (psetauthparm == NULL) {
> > > -		kfree(pcmd);
> > > +	if (!psetauthparm) {
> > > +		kfree((unsigned char *)pcmd);
> > 
> > This new cast is unnecessary and weird.
> 
> Ah, I missed that, good catch.  I'll go drop this patch now.

And that caused the second patch to get dropped as well.  I'll just drop
them all, can you redo the whole series please?

thanks,

greg k-h

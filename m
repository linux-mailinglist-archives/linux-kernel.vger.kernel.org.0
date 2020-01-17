Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D81410DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 19:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAQSf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 13:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQSf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:35:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63FF020728;
        Fri, 17 Jan 2020 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579286125;
        bh=RhV6ZvID37Iw+UQibLtcIiMw/ybNeiYNSfAcO6+343U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xw9nBfY0d7qH4TGgiqEAkyBEa2jmXNILbqVMxaY7wQn6PiUxKhFL54cnln7/WvaEW
         ZLUVtC11BEVIVchIono/h7ZKR3zA2oVOBwnIDAVv8NxBs9e8XfdViZ7deZ2Lxup+ty
         4hODgO6tG6mp8CWvTISUPDwED40tTFNP7LHpY6sk=
Date:   Fri, 17 Jan 2020 19:35:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] PHY: For 5.6
Message-ID: <20200117183523.GA1968804@kroah.com>
References: <20200117053540.20451-1-kishon@ti.com>
 <20200117065426.GA1699866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117065426.GA1699866@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 07:54:26AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 17, 2020 at 11:05:40AM +0530, Kishon Vijay Abraham I wrote:
> > Hi Greg,
> > 
> > Please find the updated pull request for 5.6 merge window below.
> > 
> > Here I fixed the incorrect commit ID in Fixes tag on one of the
> > patch. Rest of it remains the same as in v1 PR.
> 
> Ok, that worked, I've pulled this version now.

I'm getting this build error in my tree now:

Kernel: arch/x86/boot/bzImage is ready  (#621)
ERROR: "of_platform_device_destroy" [drivers/phy/ti/phy-j721e-wiz.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
make: *** [Makefile:1282: modules] Error 2

a "depends on" mistake somewhere?

thanks,

greg k-h

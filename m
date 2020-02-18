Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96950162E48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgBRST7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 13:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgBRST6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:19:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FE1246A7;
        Tue, 18 Feb 2020 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582049998;
        bh=l5a7op/30p7ukqEigTi578On9gZK9bp1FyOy/u+eqkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PIIclwHWaq66d1SG5sGxEVCNNjClh8FPuhAYT/SShDtDzj7h+8jjv7CNn9vtLpV2
         102BZiwFIB4mjcgOYptQqgjSeqIN0wiHCDRcab1+rv5zFe1RPqmUS4C9RR65PK2I/m
         YJ1N7co8UGF6f0bd8piebuAyrB3376uAwb7Gl+uk=
Date:   Tue, 18 Feb 2020 19:19:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     abrodkin@synopsys.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/arc: make arcpgu_debugfs_init return 0
Message-ID: <20200218181956.GA2635524@kroah.com>
References: <20200218172821.18378-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218172821.18378-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:28:12PM +0300, Wambui Karuga wrote:
> As drm_debugfs_create_files should return void, remove its use as the
> return value of arcpgu_debugfs_init and have the latter function
> return 0 directly.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

What order does all of these patches apply in?

You have two of them numbered, but not all, so this is really confusing
as to how to review this...

Can you fix all that up and resend?

thanks,

greg k-h

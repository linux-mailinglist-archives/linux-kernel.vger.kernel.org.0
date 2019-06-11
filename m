Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF80A3D58F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbfFKSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 14:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389037AbfFKSec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:34:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034A82173C;
        Tue, 11 Jun 2019 18:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560278071;
        bh=EVm0g+HJArtjv6KFMQqUwctEz8i+FxE8A5GAg1pFPgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyPp9jISiAGa5J0ZiyDkwSWx/wOPJWS0KUGgijhUSjByqP21t87kJte4RnocGi1x5
         etkQ89nF8AVIY3WhUrYQGzBqtE8rlRFPh8eUo0jCNUXxCrtG7+vNd3KmbByRRCyEcX
         yR/yZnxoAPrWQYPB5xioKu5PfQbao7BcDSQSooE0=
Date:   Tue, 11 Jun 2019 20:34:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: no need to check return value of debugfs_create
 functions
Message-ID: <20190611183429.GA32159@kroah.com>
References: <20190611183357.GA32008@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611183357.GA32008@kroah.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:33:57PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/misc/genwqe/card_base.c      |   5 -
>  drivers/misc/genwqe/card_base.h      |   2 +-
>  drivers/misc/genwqe/card_debugfs.c   | 165 +++++----------------------
>  drivers/misc/genwqe/card_dev.c       |   6 +-
>  drivers/misc/mei/debugfs.c           |  47 ++------
>  drivers/misc/mei/main.c              |   8 +-
>  drivers/misc/mei/mei_dev.h           |   7 +-
>  drivers/misc/mic/card/mic_debugfs.c  |  18 +--
>  drivers/misc/mic/cosm/cosm_debugfs.c |   4 -
>  drivers/misc/mic/host/mic_debugfs.c  |   4 -
>  drivers/misc/mic/scif/scif_debugfs.c |   5 -
>  drivers/misc/mic/vop/vop_debugfs.c   |   4 -
>  drivers/misc/ti-st/st_kim.c          |   4 -
>  drivers/misc/vmw_balloon.c           |  19 +--
>  14 files changed, 51 insertions(+), 247 deletions(-)

Ugh, nope, wrong patch, need to break this one up, sorry...

greg k-h

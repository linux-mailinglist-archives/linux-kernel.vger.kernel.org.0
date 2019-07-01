Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6329E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 20:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfEXSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 14:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731977AbfEXSdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:33:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3762175B;
        Fri, 24 May 2019 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558722786;
        bh=BjSeJEam8WdVHSbuAW5UncP53kFfQn64ZaiSFWkxMVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFE6c8Jbfb47ONP4xF9eloB95ixXYggZq3iasmWqxr2nePiNvoHr6/tAxJp0rAmIK
         wu1dgoX49Xm8SwR3B5+jbmQyOnWt/RZlNMz4pIr0fXlfzOIlrx2kOBdi7LgyZctrTT
         R6uHW1O404va+qULBPF+HxYSxOZUZgvzNRPNaPj0=
Date:   Fri, 24 May 2019 20:33:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Add entry for anybuss drivers
Message-ID: <20190524183303.GA3362@kroah.com>
References: <20190523203000.32306-1-TheSven73@gmail.com>
 <20190523203000.32306-2-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523203000.32306-2-TheSven73@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 04:30:00PM -0400, Sven Van Asbroeck wrote:
> Add myself as the maintainer of the anybuss bus driver, and its client
> drivers.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)

What changed from v1?

Always list that below the --- line.

v3 please?

thanks,

greg k-h

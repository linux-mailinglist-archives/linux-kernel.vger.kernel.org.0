Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B789ECFE2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 18:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKBROf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 13:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKBROf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:14:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3865C21855;
        Sat,  2 Nov 2019 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572714874;
        bh=mITftCT5qGrbmxUaon/9MADVCZD1CrR4DCot6IaEj0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ibg9tPhQg9ZsdiwryentqBVvKFVfEe7e5fVU2efnUopru7epgu4+sRc5quO8O2mM7
         X+1VEADJo0q7jOdpg7h0mbH+7J/LObVvrvdkKb2H25m36ClaKBDWtrNLI5VemQ/Ghm
         ppm3qmXSMuB6uRrNOPkbyfusqb8JioC0YmM5I+7o=
Date:   Sat, 2 Nov 2019 18:14:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 2/7] intel_th: msu: Fix an uninitialized mutex
Message-ID: <20191102171431.GB484428@kroah.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
 <20191028070651.9770-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028070651.9770-3-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:06:46AM +0200, Alexander Shishkin wrote:
> Commit 615c164da0eb ("intel_th: msu: Introduce buffer interface") added a
> mutex that it forgot to initialize, resulting in a lockdep splat.
> 
> Fix that by initializing the mutex statically.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hwtracing/intel_th/msu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Again, no fixes or stable?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F251790A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 13:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbgCDMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 07:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDMuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:50:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1076C20848;
        Wed,  4 Mar 2020 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583326202;
        bh=vPoiBepambQlYf82Dvs6Z2bvwaW3w+Fz1bEsH0Fwjow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OV/HkacKIzV6zX+C5QU5LSBYvDgaNE+fsbwrneKt/RQiIUogzSC6pO2jQiHEhMO7n
         YRmMgRkLx/Yhk4kXFyZ7awQksLVWmRHIm0US5WuF/527AaRqVFfHDdSzkIZpdrWhmS
         UUtrxOrp9G6Vntl7YHZnw02Rpa1II4XS2uyoWsS0=
Date:   Wed, 4 Mar 2020 13:49:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] driver core: sync state fixups
Message-ID: <20200304124958.GA1650891@kroah.com>
References: <20200221080510.197337-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221080510.197337-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:05:07AM -0800, Saravana Kannan wrote:
> Patch 1/3 fixes a bug where sync_state() might not be called when it
> should be. Patches 2/3 and 3/3 are just minor fix ups that I'm grouping
> together. Not much to say here.
> 
> -Saravana
> 
> v1->v2:
> - Fix compilation issue in 3/3 (forgot to commit --amend in v1)
> 
> Saravana Kannan (3):
>   driver core: Call sync_state() even if supplier has no consumers
>   driver core: Add dev_has_sync_state()
>   driver core: Skip unnecessary work when device doesn't have
>     sync_state()
> 
>  drivers/base/core.c    | 27 ++++++++++++++++++++-------
>  include/linux/device.h | 11 +++++++++++
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 


All now queued up, sorry for the delay.

greg k-h

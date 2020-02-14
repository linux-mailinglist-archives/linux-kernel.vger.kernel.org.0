Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777CE15F762
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 21:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbgBNUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 15:02:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389136AbgBNUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:56 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60B024649;
        Fri, 14 Feb 2020 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710576;
        bh=M/jtZYgX8wQu2HDOMlFTLHWXhU/aEaHJVsEwheoRKQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSg4mItsGOrxjwpRnOPR+h2ANavS9HFgnYC91KrYaDersNseq1aIHzU1E3e86wbrx
         hU0UZGbsk8mRXRdqbhE4N7ZULfZwBaTPt46FBY3tAJiL2T5juN6kpThWm0ZQuLC+I1
         bUzuZK6wbMZ69HGJAAKWpsVQNqSaSs7tXRvxuCfI=
Date:   Fri, 14 Feb 2020 09:16:39 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        vincent.whitchurch@axis.com, alexios.zavras@intel.com,
        tglx@linutronix.de, allison@lohutok.net,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: Re: [PATCH] misc: Use kzalloc() instead of kmalloc() with flag
 GFP_ZERO.
Message-ID: <20200214171639.GA4057916@kroah.com>
References: <1581501247-5479-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581501247-5479-1-git-send-email-wang.yi59@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:54:07PM +0800, Yi Wang wrote:
> From: Huang Zijiang <huang.zijiang@zte.com.cn>
> 
> Use kzalloc instead of manually setting kmalloc
> with flag GFP_ZERO since kzalloc sets allocated memory
> to zero.
> 
> Change in v2:
>      add indation

This list of what changed should go below the --- line.  I've fixed it
up now, no need to redo this.

thanks,

greg k-h

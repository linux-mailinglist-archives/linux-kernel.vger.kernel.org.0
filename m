Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9FECFDC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKBRKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 13:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfKBRKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:10:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B62120862;
        Sat,  2 Nov 2019 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572714611;
        bh=Pd1Str5GC7XGhzGQCBbPGLO3+GGPMDvyzlzuW1vIPgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyBMPBmYSUF83EAqL/HLtHmPjTQ9qHLUR1PZAtT4aUeyvdBkDi9ww1RiCEGoFI+Ay
         XN42pLVynEhCr+lRmT4fXfZAhcUd2RjKeooJv2Ma23mDKlu9z4g3LNOiBE3vkA1RKg
         AHVPX5FYysOtLQb6hyeK3z1wMhNjaSG4yRG2mJpQ=
Date:   Sat, 2 Nov 2019 18:10:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akinobu.mita@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fault-inject: Use debugfs_create_ulong() instead
 of debugfs_create_ul()
Message-ID: <20191102171009.GA479906@kroah.com>
References: <1572486977-14195-1-git-send-email-zhongjiang@huawei.com>
 <1572486977-14195-2-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572486977-14195-2-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:56:16AM +0800, zhong jiang wrote:
> debugfs_create_ulong() has implemented the function of debugfs_create_ul()
> in lib/fault-inject.c. hence we can replace it.
> 
> Suggested-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  lib/fault-inject.c | 39 ++++++++++++---------------------------
>  1 file changed, 12 insertions(+), 27 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

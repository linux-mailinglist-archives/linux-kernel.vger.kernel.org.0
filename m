Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11A4179089
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 13:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbgCDMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 07:41:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgCDMlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:41:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16C620848;
        Wed,  4 Mar 2020 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583325667;
        bh=jNEaYxh5Fbbk4JweyFBVsD+Lzsdt6itFGpc7/yDJ9GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEeqGCZdCxzn023C97FHgCQxELIp8g8fZpmFex7KrfsOu/sKtHZxNeO4GwDhE1gkw
         RhZXEt/5DO8wotiiS0D8bS2L7OUPf8xqeOPYoZDrZHgZ9cVVmWl9jqwdt6tzjyeZ6G
         nyrbUks3DScJ190lyzbZYPk/zwqd7QkVFa7MLCUU=
Date:   Wed, 4 Mar 2020 13:41:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.6 -rc
Message-ID: <20200304124104.GA1629188@kroah.com>
References: <20200221115356.6587-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115356.6587-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:23:56PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.6 -rc cycle below.
> 
> It fixes an issue caused because of adding device_link_add() on platforms
> which have cyclic dependency between PHY consumer and PHY provider.
> 
> It also includes misc fixes in Motorola, TI and Broadcom's PHY driver.
> Please see the tag message for the complete list of changes and let me
> know if I have to change something.
> 
> Thanks
> Kishon
> 
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.6-rc

Oops, just saw this now, sorry for not getting to it.  HOpefully all of
these were in the pull request I just took.

thanks,

greg k-h

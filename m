Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A458179061
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 13:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgCDM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 07:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgCDM3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:29:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4612166E;
        Wed,  4 Mar 2020 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583324979;
        bh=q2HpzpEFlt66LCc0CN8paD0dy7D/lMctDByWBOfYWDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjmxhOST79gAxpkZ2y78ISWiFHHMkQCZxBDA+ud4HCQ68Y+b75tFMLhkaYHL2jfBr
         VHYSo3j6UKXJKKlFZA9phX5PbcNbRzloZdDtMTaAsLTRqPNOPFWCFRXvCGQS1xF10a
         18AJJjq8jgxvrz0xGMnDLH7AWf9ZYazGeLXkVTcg=
Date:   Wed, 4 Mar 2020 13:29:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] PHY: For 5.6 -rc
Message-ID: <20200304122936.GA1600752@kroah.com>
References: <20200304115454.14921-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304115454.14921-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:24:54PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the updated pull request for 5.6 -rc cycle below. It only
> adds an additional patch over my previous pull request (I added a new
> patch since my initial pull request is not merged).
> 
> It fixes an issue caused because of adding device_link_add() on platforms
> which have cyclic dependency between PHY consumer and PHY provider.
> 
> It also includes couple of timeout fixes in Motorola and other misc
> fixes in TI and Broadcom's PHY driver.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.6-rc_v2

Pulled and pushed out, thanks.

greg k-h

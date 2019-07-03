Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4405E7F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 17:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfGCPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 11:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfGCPfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:35:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 789332184C;
        Wed,  3 Jul 2019 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562168147;
        bh=YE0t3pFXhiVz5NSbJ3o9VwrFNauDg2wACPNK4AO0dF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VchpP5IkkFogBPArLQU0T0LqzGamKaJP4nfsOk9LKh0QoO/hVgwTP+68D3AHKFxUN
         Y6W/TMHIjHGF43Qlsr+z4a6CVLYwNie+a0Do8eUwPrkq3aBi7BD3ic5ZyE8Iz6V/WU
         anm2AJji7AK5JpnlnwdvyuW1ccoZegzgApDaLq88=
Date:   Wed, 3 Jul 2019 17:35:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/4] intel_th: Fixes for v5.2
Message-ID: <20190703153544.GA22834@kroah.com>
References: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 07:19:26PM +0300, Alexander Shishkin wrote:
> Hi Greg,
> 
> Here are the fixes I have for v5.2 cycle: two gcc warnings, one dma mapping
> issue and a new PCI ID. All issues were introduced in the same cycle, so no
> -stable involvement.
> 
> All patches are aiaiai-clean. Signed git tag below. Individual patches in
> follow-up emails. Please consider pulling or applying. Thanks!
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-fixes-for-greg-20190621
> 
> for you to fetch changes up to 0001019cdade192cb05a3c4e07df3b30a20c8ed0:

As it's too "late" for 5.2 (due to me traveling and the like), I'll just
take this for 5.3-rc1 and add the proper stable tags so they get
backported to 5.2.

thanks,

greg k-h

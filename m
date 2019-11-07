Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366F6F2943
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 09:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbfKGIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 03:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfKGIgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:36:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D4E21D79;
        Thu,  7 Nov 2019 08:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573115778;
        bh=7aYv11sFLNY66fs3qIRTMq1jdIS6NBc/7JM4okiu6rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFFoVkChPYRCOtkxfrpIA8lk8fkVLT66DT4ZlmQgSft9EpKtJDF+btXT6ZAWtwWJ0
         QpSZVJCDYpDwMyXH9WXgWMMiBTl2GuIUVXQlmomFnVZUpOegC1dPkuDCILdkXNdw46
         SKWk1QzRsqNZ2G3SuQep979ylJxpCoJKKzm8TsVs=
Date:   Thu, 7 Nov 2019 09:36:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.5 merge window
Message-ID: <20191107083616.GA1185191@kroah.com>
References: <20191106072702.19675-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106072702.19675-1-kishon@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:57:02PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.5 merge window below.
> 
> It adds two new PHY drivers, one for USB3 PHY on Allwinner H6 SoC and the other
> video combo PHY on Rockchip Innosilicon. It includes cleanup on some of the
> drivers by using helpers like platform_ioremap_resource() and
> regulator_bulk_set_supply_names() to simplify code. It also fixes some
> of the smatch/sparse warnings.
> 
> For the complete list of changes, please see the tag message below.
> 
> Let me know if I have to make any changes.
> 
> Thanks
> Kishon
> 
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.5

Pulled and pushed out, thanks.

greg k-h

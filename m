Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576E918116B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgCKHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:06:40 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7C22146E;
        Wed, 11 Mar 2020 07:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583910399;
        bh=okOXa54cfB+bdRhXjprIbKZ1MimsKWayO+TfQBcDW3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbvB74u1TKShenFO7xEN7ZF9ObHmKzWllnp4Vy3pWjmycniOZBaSprNmoEFugr2Qh
         wJoxC5aEdVFs/uwnvZNuu5eMnbzECX8TSDrhT5lN72ONFsGo4wSxqKjb+WNVy/35c0
         Wn5whSPR9061BXeSHVe+WmPVnqR5cJ1DQWGNPboQ=
Date:   Wed, 11 Mar 2020 15:06:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm64: defconfig: Enable NXP/FSL SPI controller
 drivers
Message-ID: <20200311070632.GI29269@dragon>
References: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
 <1582585690-463-7-git-send-email-leoyang.li@nxp.com>
 <20200311055104.GA29269@dragon>
 <CADRPPNQ-VWmVMdBuEUj9RdXAYvt4dhy+scP-EaYbrXj3McSaVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNQ-VWmVMdBuEUj9RdXAYvt4dhy+scP-EaYbrXj3McSaVQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:24:07AM -0500, Li Yang wrote:
> On Wed, Mar 11, 2020 at 12:52 AM Shawn Guo <shawnguo@kernel.org> wrote:
> 
> > On Mon, Feb 24, 2020 at 05:08:01PM -0600, Li Yang wrote:
> > > Enables SPI controller drivers used in various NXP/FSL SoCs.
> > >
> > > Enabled as built-in to load RFS from SPI flash without requiring
> > > initramfs.
> >
> > RootFS on SPI flash?  On which platforms?
> 
> 
> QSPI is fast enough to connect big flash for file system.  It is used to
> connect 512MB NAND flash and 256MB NOR flash on LS1028RDB.  It is used as
> bootsource for other platforms like LS2080ardb too.

Please put this info into commit log.

Shawn

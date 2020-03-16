Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D346B18613B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 02:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgCPBQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 21:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbgCPBQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:16:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A850620663;
        Mon, 16 Mar 2020 01:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584321386;
        bh=K/2TyTWuO7HMKTMpKR0lHTm952L2DxBq1R6oWuYbQbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tu3qyTlZGxxvR5ZetlNI0bbW26PcCKHp7Yn33e9SInPwRHln6DUKyYEXSntj+/aS2
         0UGQQ7DseT+64bEYGCypHa1XQtQKheTfwSNcyAaiUn0U34hjBiFaxqAC2xWVbWo4gb
         Aq6Jx6v9xX6dmW9q1gTp/9H9/qCPYn0Z2qiTGUkE=
Date:   Mon, 16 Mar 2020 09:16:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: ls1028a: various sl28 fixes/updates
Message-ID: <20200316011620.GM17221@dragon>
References: <20200311074929.19569-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311074929.19569-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 08:49:25AM +0100, Michael Walle wrote:
> Hi,
> 
> this patchset contains device tree fixes and updates for the Kontron
> SMARC-sAL28 board.
> 
> Changes since v1:
>  - added "arm64: dts: freescale: sl28: add SPI flash" which was forgotten
>    in the first series.
> 
> Michael Walle (4):
>   arm64: dts: freescale: sl28: add SPI flash
>   arm64: dts: ls1028a: sl28: fix on-board EEPROMS
>   arm64: dts: ls1028a: sl28: expose switch ports in KBox A-230-LS
>   arm64: dts: ls1028a: sl28: add support for variant 2

Applied all, thanks.

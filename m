Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2756D9237
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393524AbfJPNRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 09:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfJPNRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:17:30 -0400
Received: from localhost (unknown [209.136.236.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638072064A;
        Wed, 16 Oct 2019 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571231848;
        bh=7ICZu5U89hohYmbn6gUIgQxhJVCaU/53F1xp5OJCAdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eunc4yEZFEINPkgHN8b4Tbj6+hH1biz99q2FXxR7IDh5zAgJi8zK2UH+lYxO3ePXc
         1L4L9fjwTz9sbtvSVgHYS7ATAQyL4PTv+mHRir5ttKx8fj4Cc+ene2SaYhlFb5jjzo
         pcUTb19YqjH+ArFzlqcanlrooE3Xi81U/oYfy+ck=
Date:   Wed, 16 Oct 2019 06:17:28 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, jslaby@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/5] Add initial support for S32V234-EVB
Message-ID: <20191016131728.GA56859@kroah.com>
References: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571230107-8493-1-git-send-email-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:48:22PM +0300, Stefan-Gabriel Mirea wrote:
> Hello,
> 
> NXP's S32V234[1] ("Treerunner") vision microprocessors are targeted for
> high-performance, computationally intensive vision and sensor fusion
> applications that require automotive safety levels. They include leading
> edge Camera Vision modules like APEX-2, ISP and GPU. The S32V234-EVB and
> S32V234-SBC boards are available for customer evaluation.
> 
> The following patch series introduces minimal enablement support for the
> NXP S32V234-EVB2[2] board, which leverages most of the SoC capabilities.
> Up to v2, this series also included the fsl_linflexuart driver, which has
> been included in Linux 5.4-rc1[3].
> 
> In the future, we aim to submit multiple drivers upstream, which can be
> found in the kernel of our Auto Linux BSP[4] ("ALB"), starting with basic
> pinmuxing, clock and uSDHC drivers.
> 
> For validation, you can use the U-Boot bootloader in the ALB[5], which we
> build and test with our patched version of the Linaro GCC 6.3.1 2017.05
> toolchain for ARM 64-bit, with sources available on [6].
> 
> Changes in v7:
> * Rebase the patch 'serial: fsl_linflexuart: Be consistent with the name'
>   on the tty-next branch in Greg's tty git tree.

I've taken patch 3 in my tty-next tree.  The others should probably go
through an arm-specific tree, right?

thanks,

greg k-h

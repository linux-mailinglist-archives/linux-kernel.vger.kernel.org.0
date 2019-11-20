Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB09103CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfKTOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfKTOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:02:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF592235D;
        Wed, 20 Nov 2019 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258555;
        bh=i/p5+S6h1vJpITYzdU9azJsKi4egqyQOtaAoVbM+bN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENSfThtVOC1EIH0So+o7Q5sdM1f/ciJLJMgRXRh703TewKPgUnAphiWYUsWW2hNDy
         RE8FgjScbVGa225ATx+QwDWyg6AmI+dwo7ZVuCROYgT+4WHtInMGhb2DZJUJsne17z
         fzEb+LAT7C9/KTKa52LqUE0DMAcP7KtMbAVMb8i4=
Date:   Wed, 20 Nov 2019 15:02:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 0/2] firmware: google: Expose coreboot tables and CBMEM
Message-ID: <20191120140233.GB2935300@kroah.com>
References: <20191120133958.13160-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133958.13160-1-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 02:39:45PM +0100, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> As user land tools currently use /dev/mem to access coreboot tables and
> CBMEM, provide a better way by using read-only sysfs attributes.
> 
> Unconditionally expose all tables and buffers making future changes in
> coreboot possible without modifying a kernel driver.
> 
> Changes in v2:
>  - Add ABI documentation
>  - Add 0x prefix on hex values
>  - Remove wrong ioremap hint as found by CI

I think you forgot to put "v2" in the [PATCH] area of the subject lines
:(

thanks,

greg k-h

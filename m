Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB129147
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 08:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbfEXGuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 02:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfEXGuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:50:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F56120868;
        Fri, 24 May 2019 06:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558680608;
        bh=WV44JEQSQ0CuYg1kG7RwIo8UhJkCJkDk7xaiwRIEI3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCehN0Dk0j9fxhNuxue/OmsgtXGIH9p+dKXCsa9l1VkfZP+uaHy/KM854gtcXxCuz
         Vkh5813EEqS9BPBlGs7BhN7y5J5fD9ttHfML7rj5/5pNnqRPWjoL2vutp+cBYolfny
         rNRIvnZ3XOA2oZ+kRplCd91/x2fAuoobaLB+DWRk=
Date:   Fri, 24 May 2019 08:50:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     devel@driverdev.osuosl.org, YueHaibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: kpc2000: Add dependency on MFD_CORE to
 kconfig symbol 'KPC2000'
Message-ID: <20190524065006.GB3194@kroah.com>
References: <20190523053643.GA14465@kroah.com>
 <20190524023639.6773-1-gneukum1@gmail.com>
 <CA+T6rvH0M2jy_FscF4RMseBKDpLMG8yukzzLjZuys_LY4SbOGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+T6rvH0M2jy_FscF4RMseBKDpLMG8yukzzLjZuys_LY4SbOGA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:02:48AM +0000, Geordan Neukum wrote:
> On Fri, May 24, 2019 at 2:38 AM Geordan Neukum <gneukum1@gmail.com> wrote:
> > +       depends on MFD_CORE
> 
> In order for this to work in menuconfig, this either needs to be a
> select or I need to
> add a prompt to MFD_CORE. I don't have strong feelings either way, but all other
> Kconfig options which are related to the MFD_CORE appear to do a straight
> selection. Let me know what you think and I'll go that route.

Yeah, you are right, sorry about that.  Let me just go hand edit-this
patch and queue it up as this was my fault...

thanks,

greg k-h

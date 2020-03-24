Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC75190A89
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 11:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCXKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 06:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgCXKTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:19:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D0F82080C;
        Tue, 24 Mar 2020 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585045180;
        bh=q4q2MlAIz6+C/hLPcO9TRU1z0kw29IK3WElI+UFhXgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQ94ZQUDRRdi3qTMyMKloWf8WGl5UrXJKTuuKZYg1OZ2U3a9Osi3YQaw5Ouz8i0f7
         /20hISeB3SITV1C6h5yiH3eHmg3H0lETiiiCU26eYgVEbZ3doVo+3Qn5C3PsMtviII
         GxB/SJyxk+IJoh1lqlXqAXs6Xh7HBTjS+rwjSl9I=
Date:   Tue, 24 Mar 2020 11:19:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Pratik Patel <pratikp@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Williams <michael.williams@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] coresight: do not use the BIT() macro in the UAPI header
Message-ID: <20200324101938.GA2220478@kroah.com>
References: <20200324042213.GA10452@asgard.redhat.com>
 <20200324062853.GD1977781@kroah.com>
 <20200324095304.GA2444@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324095304.GA2444@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:53:04AM +0100, Eugene Syromiatnikov wrote:
> On Tue, Mar 24, 2020 at 07:28:53AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 24, 2020 at 05:22:13AM +0100, Eugene Syromiatnikov wrote:
> > > The BIT() macro definition is not available for the UAPI headers
> > > (moreover, it can be defined differently in the user space); replace
> > > its usage with the _BITUL() macro that is defined in <linux/const.h>.
> > 
> > Why is somehow _BITUL() ok to use here instead?
> 
> It is provided in an UAPI header (include/uapi/linux/const.h)
> and is appropriately prefixed with an underscore to avoid conflicts.

Because no one uses _ in their own macros?  :)

Anyway, this is fine, but if it's really the way forward, I think a lot
of files will end up being changed...

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A733A1905BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 07:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCXG25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 02:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgCXG25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:28:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8597820663;
        Tue, 24 Mar 2020 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585031336;
        bh=QXnZDI5i54nlP9QF18vP1OcNbhYUp6bbcas64dls10w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3rPCmFCYMNcFFoItsXZ1KUwNaD8tLa+PdkbHJKkOV+ddwKoY18kRUINpBbhW/ISl
         E3AzpcFkEWRa+PhPYD/y3eLdxUcYi1fHqLLItvVkx1TJtCpzWWNn5aWlhNAWmspXaV
         tSNOFKKHcnWruNLDgCtldVvr/dUrKJkeXBKu3fWs=
Date:   Tue, 24 Mar 2020 07:28:53 +0100
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
Message-ID: <20200324062853.GD1977781@kroah.com>
References: <20200324042213.GA10452@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324042213.GA10452@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:22:13AM +0100, Eugene Syromiatnikov wrote:
> The BIT() macro definition is not available for the UAPI headers
> (moreover, it can be defined differently in the user space); replace
> its usage with the _BITUL() macro that is defined in <linux/const.h>.

Why is somehow _BITUL() ok to use here instead?

Just open-code it, I didn't think we could use any BIT()-like macros in
uapi .h files.

thanks,

greg k-h

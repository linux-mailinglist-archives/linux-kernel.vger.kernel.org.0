Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77F29B97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 17:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbfEXP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 11:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390200AbfEXP70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:59:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47EF7217D7;
        Fri, 24 May 2019 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558713565;
        bh=XwMa7CMpcjz1efQfql4HvlYteg+X/F8oDV04BG5m2lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfwTNWoZxrjTEpikuOMzZzSdLcBW0Q45u6aLFm63O9BL4fdlM3YznYNCjrSvvxjuM
         g53Pp/wOU1odo/9ZnClUVpXHomhiofos7M2Q6i453KiMRhg5l3KCFwsWPs7maFOG3/
         KbQPrvSM/tT0G7XRuCsON9nTEkFy9ikhpi8rbSk4=
Date:   Fri, 24 May 2019 17:59:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sdasari@fb.com
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: make parameter optional
Message-ID: <20190524155923.GA7516@kroah.com>
References: <20190501223411.1655854-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501223411.1655854-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 03:34:11PM -0700, Vijay Khemka wrote:
> Makiing memory-region and flash as optional parameter in device
> tree if user needs to use these parameter through ioctl then
> need to define in devicetree.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)

File is no longer at this location :(

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38018A941
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 23:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfHLVZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 17:25:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:37196 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHLVZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:25:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1AF092D8;
        Mon, 12 Aug 2019 21:25:20 +0000 (UTC)
Date:   Mon, 12 Aug 2019 15:25:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation/arm/sa1100/assabet: Fix 'make
 assabet_defconfig' command
Message-ID: <20190812152519.61503a5b@lwn.net>
In-Reply-To: <20190808165929.16946-2-j.neuschaefer@gmx.net>
References: <20190808165929.16946-1-j.neuschaefer@gmx.net>
        <20190808165929.16946-2-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Aug 2019 18:58:56 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> "make assabet_config" doesn't work.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/arm/sa1100/assabet.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm/sa1100/assabet.rst b/Documentation/arm/sa1100/assabet.rst
> index 3e704831c311..a761e128fb08 100644
> --- a/Documentation/arm/sa1100/assabet.rst
> +++ b/Documentation/arm/sa1100/assabet.rst
> @@ -14,7 +14,7 @@ Building the kernel
> 
>  To build the kernel with current defaults::
> 
> -	make assabet_config
> +	make assabet_defconfig
>  	make oldconfig
>  	make zImage

Applied, thanks.

jon

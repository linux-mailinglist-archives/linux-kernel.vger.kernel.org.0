Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9239309
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfFGRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 13:23:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:57764 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbfFGRXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:23:53 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8DB582CD;
        Fri,  7 Jun 2019 17:23:52 +0000 (UTC)
Date:   Fri, 7 Jun 2019 11:23:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] Documentation: tee: Grammar s/the its/its/
Message-ID: <20190607112351.0b093cf2@lwn.net>
In-Reply-To: <20190607110729.12734-1-geert+renesas@glider.be>
References: <20190607110729.12734-1-geert+renesas@glider.be>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jun 2019 13:07:29 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/tee.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/tee.txt b/Documentation/tee.txt
> index 56ea85ffebf24545..afacdf2fd1de5455 100644
> --- a/Documentation/tee.txt
> +++ b/Documentation/tee.txt
> @@ -32,7 +32,7 @@ User space (the client) connects to the driver by opening /dev/tee[0-9]* or
>    memory.
>  
>  - TEE_IOC_VERSION lets user space know which TEE this driver handles and
> -  the its capabilities.
> +  its capabilities.
>  
>  - TEE_IOC_OPEN_SESSION opens a new session to a Trusted Application.

Applied, thanks.

jon

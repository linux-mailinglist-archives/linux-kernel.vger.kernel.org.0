Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9268A126748
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLSQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:39:21 -0500
Received: from ms.lwn.net ([45.79.88.28]:37184 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSQjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:39:20 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6745E382;
        Thu, 19 Dec 2019 16:39:20 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:39:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:locking: fix locktorture parameter description
Message-ID: <20191219093919.59de5cf6@lwn.net>
In-Reply-To: <20191201121941.6971-1-federico.vaga@vaga.pv.it>
References: <20191201121941.6971-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Dec 2019 13:19:41 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> The description was talking about two default values: I removed the
> wrong one.
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/locking/locktorture.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/locking/locktorture.rst b/Documentation/locking/locktorture.rst
> index 54899c95e45e..e49da0a0bf94 100644
> --- a/Documentation/locking/locktorture.rst
> +++ b/Documentation/locking/locktorture.rst
> @@ -105,8 +105,7 @@ stat_interval
>  		  Number of seconds between statistics-related printk()s.
>  		  By default, locktorture will report stats every 60 seconds.
>  		  Setting the interval to zero causes the statistics to
> -		  be printed -only- when the module is unloaded, and this
> -		  is the default.
> +		  be printed -only- when the module is unloaded.
>  
>  stutter
>  		  The length of time to run the test before pausing for this

Applied (finally) thanks.

jon

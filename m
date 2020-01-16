Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7913D774
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 11:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgAPKCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 05:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgAPKCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:02:44 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C802073A;
        Thu, 16 Jan 2020 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579168963;
        bh=b84RQj8x0DMKLMv9t2vscFneZeX2tkylffgXrZRESgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=py5Mo5TaXZBuACmO7OjggDYQGWBN+amS7dJwyYwl1W2Vx7lEcg72timSbJ0DJdFCi
         5hPi7joemJJ907Jo5KdN1g4BZLgNv8rxp4QGGF0/1wGVWQQwV5TyoTJaQ9paDZtRxb
         HpwvoDS3mYwOh0k0mxFrm/CkedZVamBCth2EA+wI=
Date:   Thu, 16 Jan 2020 19:02:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tools: bootconfig: fix spelling mistake "faile"
 -> "failed"
Message-Id: <20200116190239.9b318b2faa14465ece414f16@kernel.org>
In-Reply-To: <20200116092206.52192-1-colin.king@canonical.com>
References: <20200116092206.52192-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Thu, 16 Jan 2020 09:22:06 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two spelling mistakes in printf statements, fix these.

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/bootconfig/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index b8f174fd2a0a..91c9a5c0c499 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -140,7 +140,7 @@ int load_xbc_from_initrd(int fd, char **buf)
>  		return 0;
>  
>  	if (lseek(fd, -8, SEEK_END) < 0) {
> -		printf("Faile to lseek: %d\n", -errno);
> +		printf("Failed to lseek: %d\n", -errno);
>  		return -errno;
>  	}
>  
> @@ -155,7 +155,7 @@ int load_xbc_from_initrd(int fd, char **buf)
>  		return 0;
>  
>  	if (lseek(fd, stat.st_size - 8 - size, SEEK_SET) < 0) {
> -		printf("Faile to lseek: %d\n", -errno);
> +		printf("Failed to lseek: %d\n", -errno);
>  		return -errno;
>  	}
>  
> -- 
> 2.24.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

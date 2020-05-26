Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 263EF19BCF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgDBHop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 03:44:45 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:49542 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgDBHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:44:45 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jJuWe-0000zk-E2; Thu, 02 Apr 2020 07:44:32 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1jJuWc-0004Bp-1R; Thu, 02 Apr 2020 08:44:32 +0100
Subject: Re: [PATCH] um: add include: memset() and memcpy() are in <string.h>
To:     Zach van Rijn <me@zv.io>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org
References: <a1f6271e7c72e49fd863efc4b7126be6598fd4f6.camel@zv.io>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <26235042-02c6-04ae-42ec-4d1f393975d8@cambridgegreys.com>
Date:   Thu, 2 Apr 2020 08:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a1f6271e7c72e49fd863efc4b7126be6598fd4f6.camel@zv.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2020 22:30, Zach van Rijn wrote:
> These two functions are otherwise unknown to the pedantic compiler.
> Include the correct header to enable the build to succeed.
> 
> Signed-off-by: Zach van Rijn <me@zv.io>
> ---
>   arch/um/os-Linux/file.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> index 26ecbd64c409..044836ad7392 100644
> --- a/arch/um/os-Linux/file.c
> +++ b/arch/um/os-Linux/file.c
> @@ -6,6 +6,7 @@
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> +#include <string.h>
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <signal.h>
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

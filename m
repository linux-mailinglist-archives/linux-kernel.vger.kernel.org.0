Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C3994EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbfHVN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387656AbfHVN0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4F2418C8916;
        Thu, 22 Aug 2019 13:26:35 +0000 (UTC)
Received: from localhost (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A20F01834A;
        Thu, 22 Aug 2019 13:26:31 +0000 (UTC)
Date:   Thu, 22 Aug 2019 21:26:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kaslr: remove useless code in mem_avoid_memmap
Message-ID: <20190822132628.GA3887@MiWiFi-R3L-srv>
References: <1566477146-32484-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566477146-32484-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Thu, 22 Aug 2019 13:26:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/19 at 08:32am, Qian Cai wrote:
> MAX_MEMMAP_REGIONS is a macro that equal to 4. "i" is static local
> variable that default to 0. The comparison "i >= MAX_MEMMAP_REGIONS"
> will always be false.

Seems not true. mem_avoid_memmap() could be invoked many times if
multiple memmap= added. It will carry the value accumulated from
the past.

> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/boot/compressed/kaslr.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 2e53c056ba20..a4a5a88edb94 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -176,9 +176,6 @@ static void mem_avoid_memmap(char *str)
>  {
>  	static int i;
>  
> -	if (i >= MAX_MEMMAP_REGIONS)
> -		return;
> -
>  	while (str && (i < MAX_MEMMAP_REGIONS)) {
>  		int rc;
>  		unsigned long long start, size;
> -- 
> 1.8.3.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4714986C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 02:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAZBrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 20:47:09 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51178 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbgAZBrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:47:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToX4oRG_1580003226;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0ToX4oRG_1580003226)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Jan 2020 09:47:07 +0800
Subject: Re: [PATCH] OCFS2: use OCFS2_SEC_BITS in macro
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1579577840-251956-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ac7f6b5e-f62a-38a8-2511-e254c282e012@linux.alibaba.com>
Date:   Sun, 26 Jan 2020 09:47:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1579577840-251956-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/1/21 11:37, Alex Shi wrote:
> This macros should be used as it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Mark Fasheh <mark@fasheh.com> 
> Cc: Joel Becker <jlbec@evilplan.org> 
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
> Cc: ocfs2-devel@oss.oracle.com 
> Cc: linux-kernel@vger.kernel.org

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlmglue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index cda1027d0819..0d6daf49b72a 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2133,7 +2133,7 @@ static void ocfs2_downconvert_on_unlock(struct ocfs2_super *osb,
>  }
>  
>  #define OCFS2_SEC_BITS   34
> -#define OCFS2_SEC_SHIFT  (64 - 34)
> +#define OCFS2_SEC_SHIFT  (64 - OCFS2_SEC_BITS)
>  #define OCFS2_NSEC_MASK  ((1ULL << OCFS2_SEC_SHIFT) - 1)
>  
>  /* LVB only has room for 64 bits of time here so we pack it for
> 

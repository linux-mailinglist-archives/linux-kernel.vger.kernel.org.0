Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A214986D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 02:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAZBsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 20:48:46 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57912 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbgAZBsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:48:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0ToX4oYV_1580003321;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0ToX4oYV_1580003321)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Jan 2020 09:48:42 +0800
Subject: Re: [PATCH] OCFS2: remove dlm_lock_is_remote
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1579578203-254451-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <c1096f77-6c5a-2f3d-e11f-a93173e3ff31@linux.alibaba.com>
Date:   Sun, 26 Jan 2020 09:48:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1579578203-254451-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/1/21 11:43, Alex Shi wrote:
> This macros is also not used from it was introduced. better to remove
> it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Mark Fasheh <mark@fasheh.com> 
> Cc: Joel Becker <jlbec@evilplan.org> 
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
> Cc: Kate Stewart <kstewart@linuxfoundation.org> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Richard Fontana <rfontana@redhat.com> 
> Cc: ocfs2-devel@oss.oracle.com 
> Cc: linux-kernel@vger.kernel.org

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com> 
> ---
>  fs/ocfs2/dlm/dlmthread.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
> index 2dd9727537fe..0da9ffc40a88 100644
> --- a/fs/ocfs2/dlm/dlmthread.c
> +++ b/fs/ocfs2/dlm/dlmthread.c
> @@ -39,8 +39,6 @@
>  static int dlm_thread(void *data);
>  static void dlm_flush_asts(struct dlm_ctxt *dlm);
>  
> -#define dlm_lock_is_remote(dlm, lock)     ((lock)->ml.node != (dlm)->node_num)
> -
>  /* will exit holding res->spinlock, but may drop in function */
>  /* waits until flags are cleared on res->state */
>  void __dlm_wait_on_lockres_flags(struct dlm_lock_resource *res, int flags)
> 

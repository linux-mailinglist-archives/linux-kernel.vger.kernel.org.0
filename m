Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8CDE55E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfJYVcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfJYVcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:32:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39215222BD;
        Fri, 25 Oct 2019 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572039141;
        bh=0ObkKRXqTP3o1EclY5QQh8rma1cY+y7OhQpJFI1TkKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/tcBt0tR0VkYhbFAjIpfIpWfv9Qp+NQh7+uphLWp5GzeftLprDvzscysNIR+1MJO
         yjE79XXURlFI5e9YuPWzoAty2f17HbWrwZQUwv96BaCveEFfca+ieHDbB/Py0+eu9S
         oOx0S/4FxsVYyn8ImQXtxj5ftwgybT9mdMcUBI/s=
Date:   Fri, 25 Oct 2019 14:32:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhanglin <zhang.lin16@zte.com.cn>
Cc:     dan.j.williams@intel.com, jgg@ziepe.ca, mingo@kernel.org,
        dave.hansen@linux.intel.com, namit@vmware.com, bp@suse.de,
        christophe.leroy@c-s.fr, rdunlap@infradead.org, osalvador@suse.de,
        richardw.yang@linux.intel.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kernel: Restrict permissions of /proc/iomem.
Message-Id: <20191025143220.cb15a90fe95a4ebdda70f89c@linux-foundation.org>
In-Reply-To: <1571993801-12665-1-git-send-email-zhang.lin16@zte.com.cn>
References: <1571993801-12665-1-git-send-email-zhang.lin16@zte.com.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 16:56:41 +0800 zhanglin <zhang.lin16@zte.com.cn> wrote:

> The permissions of /proc/iomem currently are -r--r--r--. Everyone can
> see its content. As iomem contains information about the physical memory
> content of the device, restrict the information only to root.
> 
> ...
>
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -139,7 +139,8 @@ static int __init ioresources_init(void)
>  {
>  	proc_create_seq_data("ioports", 0, NULL, &resource_op,
>  			&ioport_resource);
> -	proc_create_seq_data("iomem", 0, NULL, &resource_op, &iomem_resource);
> +	proc_create_seq_data("iomem", S_IRUSR, NULL, &resource_op,
> +			&iomem_resource);
>  	return 0;
>  }
>  __initcall(ioresources_init);

It's risky to change things like this - heaven knows which userspace
applications might break.

Possibly we could obfuscate the information if that is considered
desirable.  Why is this a problem anyway?  What are the possible
exploit scenarios?

Can't the same info be obtained by running dmesg and looking at the
startup info?

Can't the user who is concerned about this run chmod 0400 /proc/iomem
at boot?

Maybe Kees has an opinion?


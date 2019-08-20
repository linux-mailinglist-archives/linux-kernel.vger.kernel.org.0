Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404BE965D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfHTQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHTQFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 197CB300BE7F;
        Tue, 20 Aug 2019 16:05:32 +0000 (UTC)
Received: from mail (ovpn-120-35.rdu2.redhat.com [10.10.120.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 406035D9D5;
        Tue, 20 Aug 2019 16:05:27 +0000 (UTC)
Date:   Tue, 20 Aug 2019 12:05:25 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-mm <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd_release: always remove uffd flags and clear
 vm_userfaultfd_ctx
Message-ID: <20190820160525.GN31518@redhat.com>
References: <d4583416-5e4a-95e7-a08a-32bf2c9a95fb@huawei.com>
 <20190820160237.GB4983@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820160237.GB4983@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 20 Aug 2019 16:05:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:02:38PM +0200, Oleg Nesterov wrote:
> userfaultfd_release() should clear vm_flags/vm_userfaultfd_ctx even
> if mm->core_state != NULL.
> 
> Otherwise a page fault can see userfaultfd_missing() == T and use an
> already freed userfaultfd_ctx.
> 
> Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Fixes: 04f5866e41fb ("coredump: fix race condition between mmget_not_zero()/get_task_mm() and core dumping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/userfaultfd.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Thanks,
Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8515CCF2F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfJHGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 02:43:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730026AbfJHGnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:43:22 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B17D6B10E7C79921EC36;
        Tue,  8 Oct 2019 14:43:19 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 14:43:17 +0800
Subject: Re: [PATCH -next] misc: watch_queue: Fix build error
To:     David Howells <dhowells@redhat.com>
References: <20190903073726.21880-1-yuehaibing@huawei.com>
 <32674.1567599622@warthog.procyon.org.uk>
CC:     <jannh@google.com>, <axboe@kernel.dk>,
        <james.morris@microsoft.com>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <5f6acfef-2eda-e33a-f7cb-37f3735e60a0@huawei.com>
Date:   Tue, 8 Oct 2019 14:43:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <32674.1567599622@warthog.procyon.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/4 20:20, David Howells wrote:
> Thanks, I've folded that in.

This issue still occur in linux-next 20191008 :

drivers/misc/watch_queue.c: In function �watch_queue_account_mem�:
drivers/misc/watch_queue.c:315:38: error: �struct user_struct� has no member named �locked_vm�; did you mean �locked_shm�?
  cur_pages = atomic_long_read(&user->locked_vm);
                                      ^~~~~~~~~
                                      locked_shm
drivers/misc/watch_queue.c:321:50: error: �struct user_struct� has no member named �locked_vm�; did you mean �locked_shm�?
  } while (atomic_long_try_cmpxchg_relaxed(&user->locked_vm, &cur_pages,
                                                  ^~~~~~~~~
                                                  locked_shm
drivers/misc/watch_queue.c: In function �watch_queue_unaccount_mem�:
drivers/misc/watch_queue.c:333:44: error: �struct user_struct� has no member named �locked_vm�; did you mean �locked_shm�?
   atomic_long_sub(wqueue->nr_pages, &user->locked_vm);
                                            ^~~~~~~~~
                                            locked_shm
scripts/Makefile.build:265: recipe for target 'drivers/misc/watch_queue.o' failed

> 
> David
> 
> .
> 


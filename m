Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98A6775C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 03:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfG0B6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 21:58:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfG0B6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:58:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2AA03082141;
        Sat, 27 Jul 2019 01:58:12 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-85.rdu2.redhat.com [10.10.124.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E001C60A35;
        Sat, 27 Jul 2019 01:58:11 +0000 (UTC)
Subject: Re: [PATCH] sched/core: Don't use dying mm as active_mm for kernel
 threads
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
References: <20190726234541.3771-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b89697ed-a7f0-bb41-25ae-8e9727875d33@redhat.com>
Date:   Fri, 26 Jul 2019 21:58:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726234541.3771-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 27 Jul 2019 01:58:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 7:45 PM, Waiman Long wrote:
> It was found that a dying mm_struct where the owning task has exited can
> stay on as active_mm of kernel threads as long as no other user tasks
> run on those CPUs that use it as active_mm. This prolongs the life time
> of dying mm holding up memory and other resources that cannot be freed.
>
> Fix that by forcing the kernel threads to use init_mm as the active_mm
> if the previous active_mm is dying.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 13 +++++++++++--
>  mm/init-mm.c        |  2 ++
>  2 files changed, 13 insertions(+), 2 deletions(-)


Sorry, I didn't realize that mm->owner depends on CONFIG_MEMCG. I will
need to refresh the patch and send out v2 when I am done testing.

Cheers,
Longman


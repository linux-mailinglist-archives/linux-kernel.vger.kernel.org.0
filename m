Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE94158552
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 23:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJWDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 17:03:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgBJWDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:03:45 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3540E2072C;
        Mon, 10 Feb 2020 22:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581372224;
        bh=UUTRHGYX5Gx7HdAuoYfSUCQ6fV6AewQgS0GTXzRvYbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EiMzX6xacbdgDIdrOR4rPBw7e3hOiBVLqbLd2STaa6oVxWlXX6W630LvynFODzTgn
         QwAQNc8nn4ZyKYac/RJCM0iZ6cYHHZvbOLhUOrKhwaQk9faF8n6WuCoUAFLd8xU6/e
         Vjl+1FjdFuyYVA0XxS4zZtRKmTCepjsYdbr8YRbI=
Date:   Mon, 10 Feb 2020 14:03:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/slub: Fix potential deadlock problem in
 slab_attr_store()
Message-Id: <20200210140343.09ac0f5d841a0c9ed5034107@linux-foundation.org>
In-Reply-To: <20200210204651.21674-4-longman@redhat.com>
References: <20200210204651.21674-1-longman@redhat.com>
        <20200210204651.21674-4-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 15:46:51 -0500 Waiman Long <longman@redhat.com> wrote:

> In order to fix this circular lock dependency problem, we need to do a
> mutex_trylock(&slab_mutex) in slab_attr_store() for CPU0 above. A simple
> trylock, however, is easy to fail causing user dissatisfaction. So the
> new mutex_timed_lock() function is now used to do a trylock with a
> 100ms timeout.
> 
> ...
>
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5536,7 +5536,12 @@ static ssize_t slab_attr_store(struct kobject *kobj,
>  	if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
>  		struct kmem_cache *c;
>  
> -		mutex_lock(&slab_mutex);
> +		/*
> +		 * Timeout after 100ms
> +		 */
> +		if (mutex_timed_lock(&slab_mutex, 100) < 0)
> +			return -EBUSY;
> +

Oh dear.  Surely there's a better fix here.  Does slab really need to
hold slab_mutex while creating that sysfs file?  Why?

If the issue is two threads trying to create the same sysfs file
(unlikely, given that both will need to have created the same cache)
then can we add a new mutex specifically for this purpose?

Or something else.

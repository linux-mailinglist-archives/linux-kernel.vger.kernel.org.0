Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9078812
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfG2JMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 05:12:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfG2JMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:12:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0304BB60C;
        Mon, 29 Jul 2019 09:12:50 +0000 (UTC)
Date:   Mon, 29 Jul 2019 11:12:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729091249.GE9330@dhcp22.suse.cz>
References: <20190727171047.31610-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727171047.31610-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 27-07-19 13:10:47, Waiman Long wrote:
> It was found that a dying mm_struct where the owning task has exited
> can stay on as active_mm of kernel threads as long as no other user
> tasks run on those CPUs that use it as active_mm. This prolongs the
> life time of dying mm holding up memory and other resources like swap
> space that cannot be freed.

IIRC use_mm doesn't pin the address space. It only pins the mm_struct
itself. So what exactly is the problem here?

> 
> Fix that by forcing the kernel threads to use init_mm as the active_mm
> if the previous active_mm is dying.
> 
> The determination of a dying mm is based on the absence of an owning
> task. The selection of the owning task only happens with the CONFIG_MEMCG
> option. Without that, there is no simple way to determine the life span
> of a given mm. So it falls back to the old behavior.

Please don't. We really wont to remove mm->owner long term.
-- 
Michal Hocko
SUSE Labs

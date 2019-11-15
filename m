Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D58FE689
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 21:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKOUn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 15:43:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:56574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbfKOUnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:43:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52C57B24F;
        Fri, 15 Nov 2019 20:43:23 +0000 (UTC)
Date:   Fri, 15 Nov 2019 12:39:06 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, jack@suse.com
Subject: Re: [PATCH 1/5] locking/percpu-rwsem, lockdep: Make percpu-rwsem use
 its own lockdep_map
Message-ID: <20191115203906.fbo6t7d2n6xk3saw@linux-p48b>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.696893455@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191113102855.696893455@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Peter Zijlstra wrote:
>@@ -37,7 +48,7 @@ static inline void percpu_down_read(stru
> {
> 	might_sleep();
>
>-	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0, _RET_IP_);
>+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);

Unrelated to this patch, but we also need a might_sleep() annotation
in percpu_down_write().

Thanks,
Davidlohr

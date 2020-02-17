Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A33160E66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 10:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgBQJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 04:23:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728650AbgBQJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581931406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IJCVtSt8hFR9/5wRNM9mi8SwfeZ+oFnNyjO+CokK16M=;
        b=Lq8kXXyK+UzYy4cPi4I22wYXSowI4VXtT9IUydYk3W9NhleyJR0EVGPBgOj2m6OunOV2Q9
        9bcPTyRx9nkDsCZqimrzLItSBis1ytPwj+2hIEv6orbaxK9rzTkiojvba9jZ9wVD87LEop
        s0JHgYNl12jAEr17vu7Kthb7/pbj0Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-n8B1UPXXM0yniQK6UswR2Q-1; Mon, 17 Feb 2020 04:23:21 -0500
X-MC-Unique: n8B1UPXXM0yniQK6UswR2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AC33107ACC5;
        Mon, 17 Feb 2020 09:23:20 +0000 (UTC)
Received: from localhost (ovpn-204-63.brq.redhat.com [10.40.204.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0D1E165DB;
        Mon, 17 Feb 2020 09:23:19 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        ebiederm@xmission.com
Subject: Re: [PATCH] ipc: use a work queue to free_ipc
References: <20200211162408.2194037-1-gscrivan@redhat.com>
        <20200216141151.GJ2935@paulmck-ThinkPad-P72>
Date:   Mon, 17 Feb 2020 10:23:18 +0100
In-Reply-To: <20200216141151.GJ2935@paulmck-ThinkPad-P72> (Paul E. McKenney's
        message of "Sun, 16 Feb 2020 06:11:51 -0800")
Message-ID: <875zg5r2ih.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:

> Nice speedup!
>
> However, I am not convinced that the code shown below is safe.
>
> I believe that you need either a synchronize_rcu() in your free_ipc()
> function or that you need to pass free_ipc() to queue_rcu_work() instead
> of directly schedule_work().  As things are, I would expect you to see
> free_ipc_ns() being invoke too soon on heavily loaded CONFIG_PREEMPT=y
> kernels.  Which can be quite a pain to debug!
>
> Or am I missing something?

thanks for the review!

Would being called too soon be a problem?  The current version calls
free_ipc_ns() as part of the put_ipc_ns cleanup.

free_ipc() calls immediately synchronize_rcu() through free_ipc_ns():

free_ipc_ns() -> mq_put_mnt() -> kern_unmount() -> synchronize_rcu()

Do you think we should make it more explicit and add a synchronize_rcu()
as part of the free_ipc_ns() function itself?

Regards,
Giuseppe


>
> 							Thanx, Paul
>
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> ---
>>  include/linux/ipc_namespace.h |  2 ++
>>  ipc/namespace.c               | 17 +++++++++++++++--
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
>> index c309f43bde45..a06a78c67f19 100644
>> --- a/include/linux/ipc_namespace.h
>> +++ b/include/linux/ipc_namespace.h
>> @@ -68,6 +68,8 @@ struct ipc_namespace {
>>  	struct user_namespace *user_ns;
>>  	struct ucounts *ucounts;
>>  
>> +	struct llist_node mnt_llist;
>> +
>>  	struct ns_common ns;
>>  } __randomize_layout;
>>  
>> diff --git a/ipc/namespace.c b/ipc/namespace.c
>> index b3ca1476ca51..37d27e1b807a 100644
>> --- a/ipc/namespace.c
>> +++ b/ipc/namespace.c
>> @@ -117,6 +117,7 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
>>  
>>  static void free_ipc_ns(struct ipc_namespace *ns)
>>  {
>> +	mq_put_mnt(ns);
>>  	sem_exit_ns(ns);
>>  	msg_exit_ns(ns);
>>  	shm_exit_ns(ns);
>> @@ -127,6 +128,17 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>>  	kfree(ns);
>>  }
>>  
>> +static LLIST_HEAD(free_ipc_list);
>> +static void free_ipc(struct work_struct *unused)
>> +{
>> +	struct llist_node *node = llist_del_all(&free_ipc_list);
>> +	struct ipc_namespace *n, *t;
>> +
>> +	llist_for_each_entry_safe(n, t, node, mnt_llist)
>> +		free_ipc_ns(n);
>> +}
>> +static DECLARE_WORK(free_ipc_work, free_ipc);
>> +
>>  /*
>>   * put_ipc_ns - drop a reference to an ipc namespace.
>>   * @ns: the namespace to put
>> @@ -148,8 +160,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
>>  	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
>>  		mq_clear_sbinfo(ns);
>>  		spin_unlock(&mq_lock);
>> -		mq_put_mnt(ns);
>> -		free_ipc_ns(ns);
>> +
>> +		if (llist_add(&ns->mnt_llist, &free_ipc_list))
>> +			schedule_work(&free_ipc_work);
>>  	}
>>  }
>>  
>> -- 
>> 2.24.1
>> 


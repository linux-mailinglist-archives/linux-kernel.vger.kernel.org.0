Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20A814CAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA2MbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 07:31:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbgA2MbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580301059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mVoGmnbnu+6R1pSCl0dLyuO7kwDWvlmj5m5kaifObZg=;
        b=ZaaLsCCub7Z4xmuXFeLEhSU6vMEN5NwNHeaaEzoCGXSXfKE2yartIajPJEYizEgjx4OzKw
        0tHjngx8fOA9hg1hJ6noOcdSHz77jk6jFckJoCfUUHZbt0nQzrLE8hLlsFM1cxtPc/hArq
        s2b45Xcm+NP7jE1nsGgYBWl4N2I+DT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Q5wd-9RhPqyzHHEuMF8AeA-1; Wed, 29 Jan 2020 07:30:53 -0500
X-MC-Unique: Q5wd-9RhPqyzHHEuMF8AeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7238E800D41;
        Wed, 29 Jan 2020 12:30:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8A0695C1B5;
        Wed, 29 Jan 2020 12:30:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 29 Jan 2020 13:30:49 +0100 (CET)
Date:   Wed, 29 Jan 2020 13:30:47 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH] exit.c: Fix Sparse errors and warnings
Message-ID: <20200129123046.GA1726@redhat.com>
References: <20200128172008.22665-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128172008.22665-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28, madhuparnabhowmik10@gmail.com wrote:
>
> kernel/exit.c:626:40: warning: incorrect type in assignment
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  kernel/exit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index bcbd59888e67..c5a9d6360440 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -623,8 +623,8 @@ static void forget_original_parent(struct task_struct *father,
>  	reaper = find_new_reaper(father, reaper);
>  	list_for_each_entry(p, &father->children, sibling) {
>  		for_each_thread(p, t) {
> -			t->real_parent = reaper;
> -			BUG_ON((!t->ptrace) != (t->parent == father));
> +			rcu_assign_pointer(t->real_parent, reaper);

Another case when RCU_INIT_POINTER() makes more sense (although to me it
too looks confusing). We didn't modify the new parent.

Oleg.


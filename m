Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62511131639
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgAFQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 11:40:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726448AbgAFQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578328836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O6LewDrc9QZp2Fx1nmEvO1S1UQTKNlKRcTEhAcucP8o=;
        b=AseWuJl8PNRAfyYw5HMWyWXZSbwEo6Qf3KvsSuxkXRpWrptirgCy7v29Uq/gTbSve/hTdz
        j+FqEh1+1HA8rEUx3RFZVN0Hqm+L3McYLDzot5hsSAzQvhmKfn8AmYslqLVwmigaBHt/8+
        jinEuLuHerJfaPiX0+gTQ85RHXI5sKQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-gRVGo6LQPPKG9QrTdaIxPA-1; Mon, 06 Jan 2020 11:40:35 -0500
X-MC-Unique: gRVGo6LQPPKG9QrTdaIxPA-1
Received: by mail-qt1-f198.google.com with SMTP id t4so34683207qtd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 08:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O6LewDrc9QZp2Fx1nmEvO1S1UQTKNlKRcTEhAcucP8o=;
        b=NYRqbiMbqIW4NvGnjeDZcyp3fw+sr3TsLeUoyBcnNT60HfrBPCQXEHze2DYTNDU39i
         unCzqLxXm3ifbzcea538Tr/7E26nfDUccqrkApnUJFQCWv9YioVceXGX7gfAwvKXj+OI
         9kppIEnlyRQxAff1eNC6NE0hhDXR7dE/Bg4+S5DEBTHUzSLLOUwrrq4THpYLuTaCIJcn
         EnwfcsrTgYZQpS9qJgRZBJA8uMZoGhV22fJAEnPFaqt6AUm7yAEdMZUXByUhxNuyzFj7
         8A4X0Lytz3wl1cDQE4q7GGz8VkT5+E4cLVfEsNtPy50mIQvBaDdSxd/1Sd7itdzNgsFf
         Im3A==
X-Gm-Message-State: APjAAAWqHQVBTuWUxl1QYWIiqAjnQTJdCW6Hr3ezcvwLK7350G55zDF/
        n2UOtrvIZ1hAIFkkJtffhWiz0shqwdD69NNfbLhk74anQZUclhtuAVWOx4narjCFprrgJLrEwk8
        VXnbNS9ABiHSxxo/Re0fWZd8U
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr83379097qkj.50.1578328834265;
        Mon, 06 Jan 2020 08:40:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqz86EFELGFsqREDWCmqpdtGkHrNej4Uny9NeI7c3Rc+mtT/asiV1IsiQd+5zJ0IbvClK0n+bQ==
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr83379075qkj.50.1578328833961;
        Mon, 06 Jan 2020 08:40:33 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id k62sm20793608qkc.95.2020.01.06.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 08:40:33 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:40:31 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/3] smp: Allow smp_call_function_single_async() to
 insert locked csd
Message-ID: <20200106164031.GA219677@xz-x1>
References: <20191216213125.9536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216213125.9536-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping - Would anyone like to review/pick this series?

Peter, is this series ok for you?

Thanks,

On Mon, Dec 16, 2019 at 04:31:22PM -0500, Peter Xu wrote:
> This v2 introduced two more patches to let mips/kernel/smp.c and
> kernel/sched/core.c to start using the new feature, then we can drop
> the customized implementations.
> 
> One thing to mention is that cpuidle_coupled_poke_pending is another
> candidate that we can consider, however that cpumask is special in
> that it's not only used for singleton test of the per-vcpu csd when
> injecting new calls, but also in cpuidle_coupled_any_pokes_pending()
> or so to check whether there's any pending pokes.  In that sense it
> should be good to still keep the mask because it could be faster than
> looping over each per-cpu csd.
> 
> Patch 1 is the same as v1, no change.  Patch 2-3 are new ones.
> 
> Smoke tested on x86_64 only.
> 
> Please review, thanks.
> 
> Peter Xu (3):
>   smp: Allow smp_call_function_single_async() to insert locked csd
>   MIPS: smp: Remove tick_broadcast_count
>   sched: Remove rq.hrtick_csd_pending
> 
>  arch/mips/kernel/smp.c |  8 +-------
>  kernel/sched/core.c    |  9 ++-------
>  kernel/sched/sched.h   |  1 -
>  kernel/smp.c           | 14 +++++++++++---
>  4 files changed, 14 insertions(+), 18 deletions(-)
> 
> -- 
> 2.23.0
> 

-- 
Peter Xu


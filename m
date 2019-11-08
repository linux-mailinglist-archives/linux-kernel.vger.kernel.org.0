Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD30F48A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391375AbfKHL6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 06:58:20 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37204 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390905AbfKHL6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:58:18 -0500
Received: by mail-wr1-f47.google.com with SMTP id t1so6769292wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gBB8RdG6cgVejm1+1f0yeucdoAW2HER5z2jtyPd3g1s=;
        b=cgRYI/7ou22BR4kVltlnBBqDlFDI8Gp8MkNZ/DQMG60IrDnEcssQ3nKLDVfFqDttj4
         Veqi2doC2GQqFzsAJMytjBUnMLqlPKqiI4KE12zjihv09FAQw+23SOeSnUUuZrrBcuMH
         FlamaHpcJHV3y+uvmM/7AmG/2vEmJD8o7QAeZmEEUlkMVe0Df6MxppiAIYqf61xuKw/G
         18Rte3s+bcF08katymvpVw7qh1aYJpze6r2dNVvvJFDlFxYsFjHbXUSioSaKpSOV6Svi
         +8TwHoz1/ZazR9+a+K/Gn94RBWUqI3x3Yxc4RG7nr1N4qlkFGBL1y486ENh+V6VGO/DD
         0J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gBB8RdG6cgVejm1+1f0yeucdoAW2HER5z2jtyPd3g1s=;
        b=CjyTw6DJENNEqdAxI/PYBa/0N+IbsasJl43HbgQ3ENRBZQ0tO5rv1y+QIOqqPfvXEd
         IeuRW2TBFtxpdSSXs9k8o8eG+dMv2cYldoOnWADha+SkIcE/jMj36fZQ47NHBYWOXCsv
         5509b7cCiKXPsMo/5/2RD/XsixqfR8RpUwEvA68sD45iY/iUq4q+s2V9Buz7Mjr1Wval
         NywaM9vxfPOcjE24RzdIBm1YVJztKnQLLbevYrtvitiEzkOldjBpY9T7zBLglvHLkt0l
         AsdytwDWpRoWILOwe6fCr57m7WjoaLV9A2O8zZFqauMu6XmkUfE9NMZkcUaad7LOCMyX
         /0vA==
X-Gm-Message-State: APjAAAVPn30jd5d3qvvFC3yofyBEVVU8kx0UXFw9OCfngoth9BtZ15S6
        qGavw9K3jppg9ziN5vcJitCuDQ==
X-Google-Smtp-Source: APXvYqyC9pw8OUJYHk/j0p9Odwzfg/Zr0rBxQNKGI7+vHgVIkdRqX8ubKPLeTAt2u6DNzu6GVvtCrw==
X-Received: by 2002:a05:6000:350:: with SMTP id e16mr8631754wre.276.1573214295884;
        Fri, 08 Nov 2019 03:58:15 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id v8sm8734669wra.79.2019.11.08.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 03:58:13 -0800 (PST)
Date:   Fri, 8 Nov 2019 11:58:10 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        mingo@kernel.org, pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108115810.GA83597@google.com>
References: <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
 <20191108110212.GA204618@google.com>
 <07d30588-22e6-e098-b591-29c7cd3c8054@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d30588-22e6-e098-b591-29c7cd3c8054@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Nov 2019 at 11:47:44 (+0000), Valentin Schneider wrote:
> I think we can ignore RETRY_TASK because this happens before the picking loop,
> so we'll observe any new DL/RT task that got enqueued while newidle released
> the lock. This also means we can safely break the balance loop in
> pick_next_task() when we get RETRY_TASK, because we've got something to pick
> (some new RT/DL task).

Ah right, the second loop always iterates from DL, so that works.

> This wants a comment though, methinks.

+1 :)

Thanks,
Quentin

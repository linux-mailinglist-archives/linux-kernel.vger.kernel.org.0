Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F071109A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 09:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKZIiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 03:38:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51687 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKZIiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:38:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so2201574wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5WDzH3Phk78QlbvRsLlPWPNF6CzKDT2M6VW7opXOYt4=;
        b=lErLBhStqTBxk9n+Zu5+J2NmRjN7ahKuz2DWbUDejlJwJa/bBymBlBb+SbEDCgUvyL
         ZjZvc2Hl4OLJvU7z/tl9U9OAW5wiE3cafCRealuj+C42nifLqWsbsgdHZOGqCZbR3oux
         b7Tru05gK+tPth7+r0is378nChAwX69pI05EP0KIi7WdOsP4eVt3x+wC3Gv/W70ZtNN8
         I5cUoz7IT1jVSzMgGkYrbB9S1SwUJZhqKkVR7dcIMPXddL1V8aCHDQ6Bu3ckv5TRcYwe
         61OCBlojpcTzSuah0y2MEKbvBBiMxsZG5mpfcvD1eCzAiXV12f2+w6bBdY8NTiVsfkNU
         L9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5WDzH3Phk78QlbvRsLlPWPNF6CzKDT2M6VW7opXOYt4=;
        b=BHYzX9gEZjYJiVVe3r69JEiH+3aHBAB8RxaacEEqoaA9Fk/x+4DTQIYYijJRvSe/6V
         6YUzDVM/tzn7dklGTuV0YID3h5fL5sxZlo08HhP0+FouWqEkDYSfA/gT49R7dEiQU5/4
         iKybSIiWiy9fZGZVl+kxuWZE0qMpxT7erIEraYVbnNUVlJ2iwG65n58mdv+C6BOYxwPq
         cba7RFu5qydrDyAFuuNJ4a3F2U3iwdTVUF6J9x+bpunzE8xz4U8J4NWrURoAIA7XcHP6
         8GEtElEfSC0z6bP9Z85FyJn0qK+5is3Jb1QVIuWQq9t89Kq8ExZPsLG4/Cr/APOpOMoB
         f2Uw==
X-Gm-Message-State: APjAAAW80yC/4wb0WzDHJxoOlpxPuVow7Pi7bfKOUingMEJPf+8G9Opi
        8vctsS1K33chDJzUQEDXZzo=
X-Google-Smtp-Source: APXvYqwlBPClfTHicRwPu5wh3sWpZErKSy0gvO8I3ZrKg5THJTPcIpjljE2xKcMwoqzKYka+Cd4s9A==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr3012986wme.89.1574757483640;
        Tue, 26 Nov 2019 00:38:03 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n189sm286158wmb.25.2019.11.26.00.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 00:38:03 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:38:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v5.5
Message-ID: <20191126083801.GB98591@gmail.com>
References: <20191125113542.GA109603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125113542.GA109603@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest locking-core-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus
> 
>    # HEAD: 500543c53a54134ced386aed85cd93cf1363f981 lkdtm: Remove references to CONFIG_REFCOUNT_FULL

>  net/core/sock.c                               |   2 +-

Merge conflict note, the following commit from the locking tree:

   5facae4f3549: ("locking/lockdep: Remove unused @nested argument from lock_release()")

Conflicts with the following new commit in the networking tree, also 
upstream now:

  8265792bf887: ("net: silence KCSAN warnings around sk_add_backlog() calls")

This is just a context conflict, the two one-liner changes can be applied 
independently, resulting in:

  5facae4f3549:                 mutex_release(&sk->sk_lock.dep_map, _RET_IP_);
  8265792bf887:        } else if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {

This resolution is in tip:master as well.

Thanks,

	Ingo

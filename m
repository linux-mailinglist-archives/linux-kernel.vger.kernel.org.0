Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D767169915
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 18:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBWRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 12:37:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45130 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgBWRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:37:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id z5so5135745lfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 09:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oo2h9DpzV8R6DzoyOn3xk6iUMc8ZtWKeVZcgxQnxqcQ=;
        b=VhyzIhNWwECgPdC5MwwHsqqdQSkcG0Xw7qqMhnAY4UFOZI4HyLBBSLcBFQWCHPuGcj
         vJa0wdQ7PHcIqQHrJXKe5AxBJYOS110g3VfSF4LJOCWVsQJnXWuABGDgZXM+dtG16Mhc
         /EG1GywwKMGkbI9+Bcps7nuk2B6yDm4FalYeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oo2h9DpzV8R6DzoyOn3xk6iUMc8ZtWKeVZcgxQnxqcQ=;
        b=PgXVOMvt8nvRZ2wGBFxrTWDBywQHy/AQd5J9BwudsSRMO+ykwt0sSUzggaHKA/99EC
         yeQoSFeRhXDn6+3WwjwQgbJ/EGxaEhPhGZEOZ7172wvKh9NXseuyMh2nORNmKMWUMgmt
         lgQAclr7WPQWMYzId9VtGwAbxre6fXdqkOw+b7BeavsMRSHSY/OKhb5GQa22nqncJtu9
         QqhnKnu1nlonag6glnExEyDgDb+6PK8bkd5f5bJ9MezLQBsbojQAOGKJRgSEqodKjggo
         lbuqgQ6U/iKfgipl2vXbZU5A+nDNWuO5VhkrTUks/g7JeXZHo3A/GJdbMTqgPIGW8eYy
         Ktew==
X-Gm-Message-State: APjAAAXhAe0wUjER3WsZXFti7tn67xb8p/dp30zT/Jy9jnDIJpbCGXuG
        gAViS6oB+5PAZ48oDdDUjvUkHKmtuQQ=
X-Google-Smtp-Source: APXvYqxtZV08IA7MihKgAse3tt2ONRKQytbAbJbuGnLYTxv3xAza6z2vaMEHwMMKbUnn6zbv9MjUlQ==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr25213504lfy.11.1582479446351;
        Sun, 23 Feb 2020 09:37:26 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k24sm5959596ljj.27.2020.02.23.09.37.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2020 09:37:24 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y6so7504027lji.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 09:37:23 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr27818722lja.204.1582479442680;
 Sun, 23 Feb 2020 09:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20200205123216.GO12867@shao2-debian> <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com> <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com>
In-Reply-To: <20200223141147.GA53531@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Feb 2020 09:37:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
Message-ID: <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 6:11 AM Feng Tang <feng.tang@intel.com> wrote:
>
> I tried to use perf-c2c on one platform (not the one that show
> the 5.5% regression), and found the main "hitm" points to the
> "root_user" global data, as there is a task for each CPU doing
> the signal stress test, and both __sigqueue_alloc() and
> __sigqueue_free() will call get_user() and free_uid() to inc/dec
> this root_user's refcount.

What's around it for you?

There might be that 'uidhash_lock' spinlock right next to it, and
maybe that exacerbates the issue?

> Then I added some alignement inside struct "user_struct" (for
> "root_user"), then the -5.5% is gone, with a +2.6% instead.

Do you actually need to align things inside the struct, or is it
sufficient to just align the structure itself?

IOW, is the cache conflicts _within_ the user_struct itself, or is it
with some nearby data (like that uidhash_lock or whatever?)

> One thing I don't understand is, this -5.5% only happens in
> one 2 sockets, 96C/192T Cascadelake platform, as we've run
> the same test on several different platforms. In therory,
> the false sharing may also take effect?

Is that the biggest machine you have access to?

Maybe it just isn't noticeable with smaller core counts. A lot of
conflict loads tend to have "exponential" behavior - when things get
overloaded, performance plummets because it just makes things worse as
everybody gets slower at that contention point and now it gets even
more contended...

             Linus

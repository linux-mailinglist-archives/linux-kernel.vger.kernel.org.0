Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E124D8BD47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfHMPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 11:37:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbfHMPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:37:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id d85so1322493pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lz+5UlOi1qxxGBIgahg/9X3yobOn5+akM80wHeA6n1k=;
        b=woBLh51WQ/ct5Mau6CtW3e2fv+4gutMwYr5IF6AzhtA/gRawkgJVjfj3lL2I9cQW6b
         oV9ghFkUDHHT6gzkNQmXvvL9gPL9RVP9dcZDUbOj0dMRylXq5DiVTQ3Oa5e6dut3Fj5v
         HUodcSNN8oxsllcQZnMdwLzV7Fzr/EGmVES7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lz+5UlOi1qxxGBIgahg/9X3yobOn5+akM80wHeA6n1k=;
        b=qaMcpCkOvEleTiiKAryWoEekoTLc3ECw46tBDqu93S64AjGSR5tlExBGwNFh6A6xXC
         Ml3CK6OaYWm4gWqLSxZXGgTQgSTrZVCFXzQN0xg60Foq1m47C4cZS891vuju7dkiwjVV
         4OCcEWc9iVXGzQlYydonyGrEyClziuCj7Pl0bFtIMMOAz2iHSVboIGcvcM5lMHci2Z72
         bl+5whE5T3d2t86wSBd23Sxdkx3QGFd14SXO7N/+Whm7trAlAgybXiiBuKqCuoHNHU5v
         XDjdLuA/4hMGPzMOQ2J1qiAOuCHn6e4kTWukTKJoTeEBre7jZQQ3t/XTx0ZErNvIKctu
         +X2w==
X-Gm-Message-State: APjAAAUw0r3BYw17meIJrtUxoTRKoiYAjRnvTbLcI9njk9bM5phYdAjT
        jVL1jrNE6xYIm4kOZiuM5wNuyQ==
X-Google-Smtp-Source: APXvYqwI65ttP97pW8RMlWdF32CvIfYXb4EMrQUFfUK/y0oRINDva/d4Zii5+wrMV6aDl9WtJzxUgA==
X-Received: by 2002:a62:f24b:: with SMTP id y11mr16086693pfl.0.1565710621336;
        Tue, 13 Aug 2019 08:37:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 124sm113820431pfw.142.2019.08.13.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 08:37:00 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:36:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>, khlebnikov@yandex-team.ru
Cc:     linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        paulmck@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 2/6] mm/page_idle: Add support for handling swapped
 PG_Idle pages
Message-ID: <20190813153659.GD14622@google.com>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <20190807171559.182301-2-joel@joelfernandes.org>
 <20190813150450.GN17933@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813150450.GN17933@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 05:04:50PM +0200, Michal Hocko wrote:
> On Wed 07-08-19 13:15:55, Joel Fernandes (Google) wrote:
> > Idle page tracking currently does not work well in the following
> > scenario:
> >  1. mark page-A idle which was present at that time.
> >  2. run workload
> >  3. page-A is not touched by workload
> >  4. *sudden* memory pressure happen so finally page A is finally swapped out
> >  5. now see the page A - it appears as if it was accessed (pte unmapped
> >     so idle bit not set in output) - but it's incorrect.
> > 
> > To fix this, we store the idle information into a new idle bit of the
> > swap PTE during swapping of anonymous pages.
> >
> > Also in the future, madvise extensions will allow a system process
> > manager (like Android's ActivityManager) to swap pages out of a process
> > that it knows will be cold. To an external process like a heap profiler
> > that is doing idle tracking on another process, this procedure will
> > interfere with the idle page tracking similar to the above steps.
> 
> This could be solved by checking the !present/swapped out pages
> right? Whoever decided to put the page out to the swap just made it
> idle effectively.  So the monitor can make some educated guess for
> tracking. If that is fundamentally not possible then please describe
> why.

But the monitoring process (profiler) does not have control over the 'whoever
made it effectively idle' process.

As you said it will be a guess, it will not be accurate.

I am curious what is your concern with using a bit in the swap PTE?

(Adding Konstantin as well since we may be interested in this, since we also
suggested this idea).

thanks,

 - Joel


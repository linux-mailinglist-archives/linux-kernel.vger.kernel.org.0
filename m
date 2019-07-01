Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42D163B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEGM0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 08:26:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfEGM0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:26:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEFD9AC3B;
        Tue,  7 May 2019 12:26:16 +0000 (UTC)
Date:   Tue, 7 May 2019 14:26:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Murray <timmurray@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507122615.GQ31017@dhcp22.suse.cz>
References: <20190317015306.GA167393@google.com>
 <20190317114238.ab6tvvovpkpozld5@brauner.io>
 <CAKOZuetZPhqQqSgZpyY0cLgy0jroLJRx-B93rkQzcOByL8ih_Q@mail.gmail.com>
 <20190318002949.mqknisgt7cmjmt7n@brauner.io>
 <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507021622.GA27300@sultan-box.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-05-19 19:16:22, Sultan Alsawaf wrote:
> This is a complete low memory killer solution for Android that is small
> and simple. Processes are killed according to the priorities that
> Android gives them, so that the least important processes are always
> killed first. Processes are killed until memory deficits are satisfied,
> as observed from kswapd struggling to free up pages. Simple LMK stops
> killing processes when kswapd finally goes back to sleep.
> 
> The only tunables are the desired amount of memory to be freed per
> reclaim event and desired frequency of reclaim events. Simple LMK tries
> to free at least the desired amount of memory per reclaim and waits
> until all of its victims' memory is freed before proceeding to kill more
> processes.

Why do we need something like that in the kernel? I really do not like
an idea of having two OOM killer implementations in the kernel. As
already pointed out newer kernels can do PSI and older kernels can live
with an out of tree code to achieve what they need. I do not see why we
really need this code in the upstream kernel.
-- 
Michal Hocko
SUSE Labs

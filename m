Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00A718217F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgCKTEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730805AbgCKTEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:04:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3E320739;
        Wed, 11 Mar 2020 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583953489;
        bh=0qTjkhntA0kD+y2Mff5lp9EgvstRLbEV9hT9cLx7ZlU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kVLQ46+B5v0R2xYEYXra/c3sQ+JFadjhoeB42QEdYhnrkkvIBKLSe+m7ufdEbCaoQ
         GrJOAPyy9tQibmQq/r3qsl41PA5NU/oQjG+vKjmS1gIB4GUpdMAS3J0SmheyteOd93
         fU9R60xvTdI8GoANhUkySlg8tU2vE/XqOxLa7eG8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 046F03522D70; Wed, 11 Mar 2020 12:04:48 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:04:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        elver@google.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/mm/pat: mark an intentional data race
Message-ID: <20200311190447.GA3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1581343816-6490-1-git-send-email-cai@lca.pw>
 <20200311161756.GE3470@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161756.GE3470@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:17:56PM +0100, Borislav Petkov wrote:
> + Paul.
> 
> On Mon, Feb 10, 2020 at 09:10:16AM -0500, Qian Cai wrote:
> > cpa_4k_install could be accessed concurrently as noticed by KCSAN,
> > 
> > read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
> > cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> > __change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
> > __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> > __set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
> > __kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
> > kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> > 
> > write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
> > cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> > __change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
> > __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> > __set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
> > __kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
> > kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> > 
> > Both accesses are due to the same "cpa_4k_install++" in
> > cpa_inc_4k_install. A data race here could be potentially undesirable:
> > depending on compiler optimizations or how x86 executes a non-LOCK'd
> > increment, it may lose increments, corrupt the counter, etc. Since this
> > counter only seems to be used for printing some stats, this data race
> > itself is unlikely to cause harm to the system though. Thus, mark this
> > intentional data race using the data_race() marco.
> > 
> > Suggested-by: Macro Elver <elver@google.com>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  arch/x86/mm/pat/set_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index c4aedd00c1ba..ea0b6df950ee 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
> >  
> >  static inline void cpa_inc_4k_install(void)
> >  {
> > -	cpa_4k_install++;
> > +	data_race(cpa_4k_install++);
> >  }
> >  
> >  static inline void cpa_inc_lp_sameprot(int level)
> > -- 
> 
> Acked-by: Borislav Petkov <bp@suse.de>

Applied, thank you both!

							Thanx, Paul

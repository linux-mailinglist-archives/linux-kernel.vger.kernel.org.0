Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895BB1809FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCJVJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 17:09:12 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35248 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgCJVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:09:10 -0400
Received: by mail-wm1-f54.google.com with SMTP id m3so2988842wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vBlVR0/6AqSx69KL2XC6YUUZMyEmq7M8pE/bxrslsfY=;
        b=ujZUNM+mfQSu3utMYqgnYjHCfuWXXVz/v/a958hqamf3hZU/fe2U4VAPmhxBJNM8Ud
         UfqH5GmWdDVsfvxNiZSqfFm7vmtEC+vuBVf8u0GL7yH2J3ArlJgmTXFi3dVXieMxABHv
         +bDdlcfWSk83GTpb9r1iAibQ+Cfs0zP8KV3CGY7lWfnmLM68vsVC3kL6QLUauYkBjq4n
         qwaZUlj1kuD2fl6PvejxcASkR1EutWnzrHMICLkc9Syn3PWL/bFCiVY/Ebmx12IMMzCa
         y/GStmIsmk6KvKFUiGkGYXffndmFTWkCnOiuz4oklrpTlPq85gyJd6i35rrMpK3k/jdL
         dHXg==
X-Gm-Message-State: ANhLgQ3HhZ3zNSiTMS+tDs4sYV1PIn+oXrmqgS0eECX4p6oR6KtX2Beu
        VwWJ3XIv8FjKUvTKaKIwuN0=
X-Google-Smtp-Source: ADFU+vscXDgpMC623/Va/knMMKGNYTRcsriKmLvs/0bz/CA0E/q41ws+2j4X5nm5BTI57+fggsZX4g==
X-Received: by 2002:a7b:cb10:: with SMTP id u16mr3718880wmj.96.1583874549025;
        Tue, 10 Mar 2020 14:09:09 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id 138sm271231wmb.21.2020.03.10.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:09:08 -0700 (PDT)
Date:   Tue, 10 Mar 2020 22:09:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200310210906.GD8447@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz>
 <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 20:11:45, Jann Horn wrote:
> On Tue, Mar 10, 2020 at 7:48 PM Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 10-03-20 19:08:28, Jann Horn wrote:
> > > Hi!
> > >
> > > >From looking at the source code, it looks to me as if using
> > > MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
> > > possible, even if other processes still have the same page mapped. Is
> > > that correct?
> > >
> > > If so, that's probably bad in environments where many processes (with
> > > different privileges) are forked from a single zygote process (like
> > > Android and Chrome), I think? If you accidentally call it on a CoW
> > > anonymous mapping with shared pages, you'll degrade the performance of
> > > other processes. And if an attacker does it intentionally, they could
> > > use that to aid with exploiting race conditions or weird
> > > microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
> > > talks about "the assumption that attackers can provoke page faults or
> > > microcode assists for (arbitrary) load operations in the victim
> > > domain").
> > >
> > > Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
> > > pages with mapcount>1, or something like that? Or does it already do
> > > that, and I just missed the check?
> >
> > I have brought up side channel attacks earlier [1] but only in the
> > context of shared page cache pages. I didn't really consider shared
> > anonymous pages to be a real problem. I was under impression that CoW
> > pages shouldn't be a real problem because any security sensible
> > applications shouldn't allow untrusted code to be forked and CoW
> > anything really important. I believe we have made this assumption
> > in other places - IIRC on gup with FOLL_FORCE but I admit I have
> > very happily forgot most details.

I have quickly checked FOLL_FORCE and it is careful to break CoW on the
write access.

> Android has a "zygote" process that starts up the whole Java
> environment with a bunch of libraries before entering into a loop that
> fork()s off a child every time the user wants to launch an app. So all
> the apps, and even browser renderer processes, on the device share
> many CoW VMAs. See
> <https://developer.android.com/topic/performance/memory-overview#SharingRAM>.

I still have to think about how this could be used for any reasonable
attack. But certainly the simplest workaround is to simply back off on
pages mapped multiple times as we do for THP already. Something like the
following should work but I haven't tested it at all
diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..02daa447bf47 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -351,6 +351,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				goto regular_page;
 			return 0;
 		}
+		
+		/* Do not interfere with other mappings of this page */
+		if (page_mapcount(page) != 1)
+			goto huge_unlock;
 
 		if (pmd_young(orig_pmd)) {
 			pmdp_invalidate(vma, addr, pmd);
@@ -426,6 +430,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 		}
 
+		/* Do not interfere with other mappings of this page */
+		if (page_mapcount(page) != 1)
+			continue;
+
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
 
 		if (pte_young(ptent)) {
-- 
Michal Hocko
SUSE Labs

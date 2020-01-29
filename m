Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8614D0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgA2THE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 14:07:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgA2THD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:07:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so797100wru.4;
        Wed, 29 Jan 2020 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=al7sS8M/717VVwE5/5undtsrujO0rBt1ejoTK551OXU=;
        b=roHPqOct4H2fUnD1pHVGmgmSikEmDQNoEYZkr6TOdKdwQEtvlV+qs5evNQE98ZWUAD
         VRKeTtA7jci2d9tKD/kkRkO2+uJ+hAzyc2SPdAQnVP78nGVlesuEqpcFMrODYP1OE81I
         G9Px2zca/2/XI9FjUS1YcTpaEHobU5Zc6iVp/q1nkCQ7mo969s1NLZYSM2R3cssius5F
         qsQHUkdpC1g4GvEbBjn3wfvSwRU3UXsXbkviMhc2LPwRvp/c2Ry12AzUfZxlJLhGs6JI
         8ysXin9KRNZjjCD8yCip8Y9cdyTQFpXd9erT6mwd7e6MDOZEz184ea30jKLHCa3/OOtx
         wOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=al7sS8M/717VVwE5/5undtsrujO0rBt1ejoTK551OXU=;
        b=Aedo691K4H/3OVHjhI50wOKIoDNtVY1pmztbCkK1vq1L0MMtraoCFVn9EvPXa/vHaM
         3B0BCtmRYG5GWeB4ssK9Hz9pl9r45Ce7yMlHbrX9ecyMfTtqq59J23WIaRshGILXBdcm
         /SRqD7jyCoeW5/CxmfAYZlhIfnGiVMivFLAftq+1hiEVqGVEwSf/uDS9AZSJ/Sgl0qKi
         cKGXX3ytxP+20L1PSFzF7474t3QxL05RfupBns1tNHGlndTzevtQxRFUlYYq29+1kDuU
         34DhA22zJdnc9WFDKU0SXK5rUSRT1Rrpvn8V4+sMfmbhMo7UVbJ6Ii4H/LD21vo1CglY
         BjFA==
X-Gm-Message-State: APjAAAXAP3Hij29zhZMmPvG6X46Kek/inVw782W3LGMRaM/XKVdVSuPP
        0TMLXUFFEPfmMDi/q9eUahs=
X-Google-Smtp-Source: APXvYqxsho39zIYkW621J2+3KehlPpfaeZRm1g1ckm9qtB1a/J+Ibv7yleSTCW/ngxMKmpetgLZC/A==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr310720wrm.338.1580324820489;
        Wed, 29 Jan 2020 11:07:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:8f9:806b:30e8:a48e])
        by smtp.gmail.com with ESMTPSA id a9sm3301053wmm.15.2020.01.29.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 11:06:59 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     sjpark@amazon.com, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, sj38.park@gmail.com,
        acme@kernel.org, amit@kernel.org, brendan.d.gregg@gmail.com,
        corbet@lwn.net, dwmw@amazon.com, mgorman@suse.de,
        rostedt@goodmis.org, kirill@shutemov.name,
        brendanhiggins@google.com, colin.king@canonical.com,
        minchan@kernel.org, vdavydov.dev@gmail.com, vdavydov@parallels.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Re: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Date:   Wed, 29 Jan 2020 20:06:45 +0100
Message-Id: <20200129190645.2137-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129180709.GS14879@hirez.programming.kicks-ass.net> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 19:07:09 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jan 29, 2020 at 03:37:58PM +0100, sjpark@amazon.com wrote:
> > On Wed, 29 Jan 2020 13:56:15 +0100 Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Tue, Jan 28, 2020 at 01:00:33PM +0100, sjpark@amazon.com wrote:
> > > 
> > > > I worried whether it could be a bother to send the mail to everyone in the
> > > > section, but seems it was an unnecessary worry.  Adding those to recipients.
> > > > You can get the original thread of this patchset from
> > > > https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.com/
> > > 
> > > I read first patch (the document) and still have no friggin clue.
> > 
> > Do you mean the document has insufficient description only?  If so, could you
> > please point me me which information do you want to be added?
> 
> There was a lot of words; but I'm still not sure what it actually does.

Sorry for my bad writing skill.  Will restructure and wordsmith it for next
spin.

> 
> I've read some of the code that followed; is it simply sampling the
> page-table access bit? It did some really weird things though, like that
> whole 3 regions thing.

Because simple Accessed bit sampling cannot preserve the accuracy of the
monitored access patterns, we use the mechanism called 'region based sampling'.
The patch introducing the mechanism would seems weird, mainly because it relies
on another mechanism follows the patch.  I should mentioned about it with the
patch.  I will add the description in next spin so people can understand that.

> 
> Also, you wrote you wanted feedback from perf people; but it doesn't use
> perf, what are you asking?

DAMON aims to be another source of data that perf, other profiling tools, or
even other kernel space code can use.  Therefore I wanted to get some opinions
about whether this data seems useful and how perf developers want the interface
of DAMON to be shaped for co-operation with perf.  Will make this more clear
with next spin's cover letter.

> 
> Perf can do address based sampling of memops, I suspect you can create
> something using that.

If you're saying implementing DAMON in 'perf mem', I think it would conflict
with abovely explained DAMON's goal.

Else, if you're saying it would be the right place to handle the DAMON
generated data, I agree, thank you for pointing me that.  Will keep it in mind
while shaping the interface of DAMON.


Thanks,
SeongJae Park

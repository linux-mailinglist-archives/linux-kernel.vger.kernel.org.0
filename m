Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E334A87C78
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407051AbfHIOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 10:18:58 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:35751 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfHIOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:18:58 -0400
Received: by mail-ua1-f53.google.com with SMTP id j21so37797486uap.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2WWG/iOTt94dMfB50rJSprelDOAYAI1KzIRPSZeDWw=;
        b=L0pZUfH1Uew/sDujE8pVsgpmSmCUSh/9v+Pm7AP7dGoWu3bbFxKnx/3EcFxtHRPa3t
         UfWE4qPsSieR1Oe2PcbiK5Y2dvSwWL2G7KsbVvBkddBqYDBIGYApL7PtXBXwpRc7/a69
         iqhUPNJ96VGAcIh0004onXloMthwIiwxNhghfaBPVb7Qj2OcPaSaOWn59wyvdV6yIHoE
         FISEPK2OWvJZH+HIlCd443YXuwMuV3Sbj8iQkVW9ezjUn4rshGiDPuiSblhbEGzLQoSd
         Owk2Ct8izWotiIN0D8dVtpAjDFF8znMsSw8tWksjOdwKeSnOAYW7A3SHCaXm8QzvqymQ
         QLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2WWG/iOTt94dMfB50rJSprelDOAYAI1KzIRPSZeDWw=;
        b=q9FV3bsneBT6+zl67MbzvWzMjivKd6ktNEIvyBwWWf3JepdS6Tv2NRMcfws8KWJMyg
         pwrLFM66qY8V6/Qxhyhnz4Sa005vjWqsnrWC9VBtdlxhlH6oGCDmEuBHCZp4BflC4Xh3
         Sj7H5XYbifeQXP5s7t/EytDfFrQXE3XLidgt1FhdnrLuDHkehsb7YvzsN3ghSme7kBy1
         TQCV+h1rRy4zW8c84t6SzkTnpUrP//vtEh9ZBWOZoJqZgFAtw7DfT2Cnjx1E/mSwR/VG
         cUc2Tm/vjaQ02X5UYN8Wnqxgn+Fhf3YdKMnKCOgwjIS3R4vBRsHIEOYrKlfDZboMGx+U
         MRQg==
X-Gm-Message-State: APjAAAWpMFs2FvnYJspi24vF4a+sQxAF+5zUNe7pFdi6bTeeOvuI0WvF
        OKDNKqmr2z9UrF/EKyzhaf7HlFn41HpFyeN/qxQ=
X-Google-Smtp-Source: APXvYqwPqrzwFtGX8NI73Jdcu/90zyRirukekqbQj1hpKKql3cvsF4mO9y3zDSB4f5aWhKn0nUHkZu30WEPW9VtTdLo=
X-Received: by 2002:ab0:30ae:: with SMTP id b14mr2034666uam.22.1565360336786;
 Fri, 09 Aug 2019 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190807075927.GO11812@dhcp22.suse.cz> <20190807205138.GA24222@cmpxchg.org>
 <20190808114826.GC18351@dhcp22.suse.cz> <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
 <20190808163228.GE18351@dhcp22.suse.cz> <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
 <20190808185925.GH18351@dhcp22.suse.cz> <08e5d007-a41a-e322-5631-b89978b9cc20@redhazel.co.uk>
 <20190809085748.GN18351@dhcp22.suse.cz> <cdb392ee-e192-c136-41cb-48d9e4e4bf47@redhazel.co.uk>
 <20190809105016.GP18351@dhcp22.suse.cz>
In-Reply-To: <20190809105016.GP18351@dhcp22.suse.cz>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 9 Aug 2019 19:48:45 +0530
Message-ID: <CAOuPNLiQ7je5DKwTBqxRHoeu_rchFGrBcb1Cdy2Rczt_VsMaNg@mail.gmail.com>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     ndrw <ndrw.xf@redhazel.co.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Pintu Kumar <pintu.ping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

Hi,

This is an interesting topic for me so I would like to join the conversation.
I will be glad if I can be of any help here either in testing PSI, or
verifying some scenarios and observation.

I have some experience working with low memory embedded devices, like
RAM as low as 128MB, 256MB, less than 1GB mostly, with/without
Display, DRM/Graphics support.
Along with ZRAM as swap space configured as 25% of RAM size.
The eMMC storage space is also as low as 4GB or 8GB max.

So, I have experienced this sluggishness, hang, OOM kill issues quite
a number of times.
So, I would like to share my experience and observation here.

Recently, I have been exploring the PSI feature on my ARM
Qemu/Beagle-Bone environment, so I can share some feedback for this as
well.

The system sluggish behavior can result from 4 types (specially on
smart phone devices):
* memory allocation pressure
* I/O pressure
* Scheduling pressure
* Network pressure

I think the topic of concern here is: memory pressure.
So, I would like to share some thoughts about this.

* In my opinion, memory pressure should be internal to the system and
not visible to the end users.
* The pressure metrics can very from system to system, so its
difficult to apply single policy.
* I guess this is the time to apply "Machine Learning" and "Artificial
Intelligence" into the system :)

* The memory pressure starts with how many times and how quickly
system is entering the slow-path.
  Thus slow-path monitoring may give some clue about pressure building
in the system.
  Thus I use to use slow-path-counter.
  Too much of slow-path in the beginning itself indicates that this
system needs to be re-designed.

* The system should be avoided to entering slow-path again and again
thus avoiding pressure.
  If this happens then its time to reclaim memory in large chunk,
rather than in smaller chunk.
  May be its time to think about shrink_all_memory() knob in kernel.
  It can be run as bottom-half processing, may be from cgroups.

* Some experiment were done in the past. Interested people can check this paper:
  http://events17.linuxfoundation.org/sites/events/files/slides/%5BELC-2015%5D-System-wide-Memory-Defragmenter.pdf

* The system is already behaving sluggish even before it enters oom-kill stage.
  So, most of the time oom stage is skipped, not occurred, or its just
looping around.
  Thus, some kind of oom-monitoring may help to gather some suspect.
  Thats the reason I proposed to use something called
oom-stall-counter. That means system entering oom, but not possibly
oom-kill.
  If this counter is updated means we assume that system started
behaving sluggish.

* A oom-kill-counter can also help in determining how much of killing
happening in kernel space.
  Example: If PSI pressure is building up and this counter is not updating...
  But in any case system-daemon should be avoided from killing.

* Some killing policy should be left to user space. So a standard
system-daemon (or kthread) should be designed along the line.
  It should be configured dynamically based on the system and oom-score.
  As my previous experience, in Tizen, we have used something called:
resourced daemon.
  https://git.tizen.org/cgit/platform/core/system/resourced/tree/src/memory?h=tizen

* Instead of static policy there should be something called "Dynamic
Low Memory Manager" (DLLM) policy.
  That is at every stage (slow-path, swapping, compaction-fail,
reclaim-fail, oom) some action can be taken.
  Earlier this event was triggered using vmpressure, but now it can
replace with PSI.

* Another major culprit with sluggish in the long run is, the
system-daemon occupying all of swap space and never releasing it.
  So, even if the kill applications due to oom, it may not help much.
Since daemons will never be killed.
  So, I proposed something called "Dynamic Swappiness", where
swappiness of daemons came be lowered dynamically, while normal
application have higher values.
  In the past I have done several experiments on this, soon I will be
publishing a paper on it.

* May be it is helpful to understand better, if we start from a very
minimal scale (just 64MB to 512MB RAM) with busy-box.
  If we can tune this perfectly, than large scale will automatically
have no issues.

With respect to PSI, here are my observations:
* PSI memory threshold (10, 60, 300) are too high for an embedded system.
  I think these settings should be dynamic, or user configurable, or
there should be on more entry for 1s or lesser.
* PSI memory values are updated after the oom-kill in kernel had
already happened, that means sluggish already occurred.
  So, I have to utilize the "total" field and monitor the difference manually.
  Like the difference between previous-total and next-total is more
than 100ms and rising, then we suspect OOM.
* Currently, PSI values are system-wide. That is, after sluggish
occurred, it is difficult to predict, which task causes sluggish.
  So, I was thinking to add new entry to capture task details as well.


These are some of my opinion. It may or may not be applicable directly.
Further brain-storming or discussions might be required.



Regards,
Pintu

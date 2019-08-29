Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD0A1F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfH2Pm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 11:42:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34328 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2Pm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:42:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id m10so3375821qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e13R8hnmhpY/divDO7DdtrQUgOCBRjC8fBV+Hlaeks4=;
        b=G7vIcUpXIyfAddMCAAprYrXSRVr0dgeGKNoQQ1RtOFMUKnx5GCLeNtr5LIcP5wf8HT
         xPWrdCkXGG+zbB0D2u+TW/X6oEp7J4d9RrpbdHDgAwZAEvn+ZiKszGcHrjPHrxSXa2bl
         Mz7W+AVtcOEJiy+atquNgK9YFeZe8/aGMjeS6R3TeNkdvwyTPMBmLrmzZyJovpV6dkdZ
         RvaxBDw3oAdFsfLjUcFmRde4E8PYxkTzPuSIewtiGE1qaYptcRsbbPDpz63DT6Ywtsoj
         FWsaFeYn0HmCtivbVG5Tq9NT0tsfCbh7/35+Ur5hspWdtT64ZR6yKZLouX0bbnRBxry0
         1C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e13R8hnmhpY/divDO7DdtrQUgOCBRjC8fBV+Hlaeks4=;
        b=j8SIbqjRfO4RTG0O5dSCtxKC0nFLgCkLjWtD1ej/D6Z86iNehA0p6gQDJ3I/zZ2wV4
         jeDnOvIcs8gRFYYcQ2Jzcntrt/2EpQgrmU8XaEHo9F0fi1wSFEeXtgaEs7hel1eHsvmc
         05T6vFYTE6jketLxosJRgvSG/TZkPhlIryc2k0xbiFRvJBG1fzHN7TSz1SJfye8iRo5y
         w40KPQ6okHjRyMS6exXssD+nknzN1KZVg4TjfAckKTEZ/CJom4n37uJg/IIxgt5tQm1Y
         71Pg1w3TX+7FCr+TYnqJjkNZMet+oaEJ5h4CKkcg46swbeNQ65K9cegOyEH/bukiYdi4
         ekxg==
X-Gm-Message-State: APjAAAXFeeZ4PXziSGXvfz2Yt2bbUVMu6tR2EFg/fWJAsjVPR+UXcMQT
        R0RaEKOrfMBhwFjsC1S5YHbpeQ==
X-Google-Smtp-Source: APXvYqx1BS4vkCOlpjk4W7mCJhFDZaNa7KO6ITvbKA2fO7/VzGJCEn76C3qEpWPdnZiVFWLB5Um1cw==
X-Received: by 2002:a05:620a:12f0:: with SMTP id f16mr10064503qkl.483.1567093346657;
        Thu, 29 Aug 2019 08:42:26 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y67sm1405561qkd.40.2019.08.29.08.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:42:25 -0700 (PDT)
Message-ID: <1567093344.5576.23.camel@lca.pw>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
From:   Qian Cai <cai@lca.pw>
To:     Edward Chron <echron@arista.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Date:   Thu, 29 Aug 2019 11:42:24 -0400
In-Reply-To: <CAM3twVSZm69U8Sg+VxQ67DeycHUMC5C3_f2EpND4_LC4UHx7BA@mail.gmail.com>
References: <20190826193638.6638-1-echron@arista.com>
         <20190827071523.GR7538@dhcp22.suse.cz>
         <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
         <20190828065955.GB7386@dhcp22.suse.cz>
         <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
         <20190829071105.GQ28313@dhcp22.suse.cz>
         <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
         <20190829115608.GD28313@dhcp22.suse.cz>
         <CAM3twVSZm69U8Sg+VxQ67DeycHUMC5C3_f2EpND4_LC4UHx7BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 08:03 -0700, Edward Chron wrote:
> On Thu, Aug 29, 2019 at 4:56 AM Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Thu 29-08-19 19:14:46, Tetsuo Handa wrote:
> > > On 2019/08/29 16:11, Michal Hocko wrote:
> > > > On Wed 28-08-19 12:46:20, Edward Chron wrote:
> > > > > Our belief is if you really think eBPF is the preferred mechanism
> > > > > then move OOM reporting to an eBPF.
> > > > 
> > > > I've said that all this additional information has to be dynamically
> > > > extensible rather than a part of the core kernel. Whether eBPF is the
> > > > suitable tool, I do not know. I haven't explored that. There are other
> > > > ways to inject code to the kernel. systemtap/kprobes, kernel modules and
> > > > probably others.
> > > 
> > > As for SystemTap, guru mode (an expert mode which disables protection
> > > provided
> > > by SystemTap; allowing kernel to crash when something went wrong) could be
> > > used
> > > for holding spinlock. However, as far as I know, holding mutex (or doing
> > > any
> > > operation that might sleep) from such dynamic hooks is not allowed. Also
> > > we will
> > > need to export various symbols in order to allow access from such dynamic
> > > hooks.
> > 
> > This is the oom path and it should better not use any sleeping locks in
> > the first place.
> > 
> > > I'm not familiar with eBPF, but I guess that eBPF is similar.
> > > 
> > > But please be aware that, I REPEAT AGAIN, I don't think neither eBPF nor
> > > SystemTap will be suitable for dumping OOM information. OOM situation
> > > means
> > > that even single page fault event cannot complete, and temporary memory
> > > allocation for reading from kernel or writing to files cannot complete.
> > 
> > And I repeat that no such reporting is going to write to files. This is
> > an OOM path afterall.
> > 
> > > Therefore, we will need to hold all information in kernel memory (without
> > > allocating any memory when OOM event happened). Dynamic hooks could hold
> > > a few lines of output, but not all lines we want. The only possible buffer
> > > which is preallocated and large enough would be printk()'s buffer. Thus,
> > > I believe that we will have to use printk() in order to dump OOM
> > > information.
> > > At that point,
> > 
> > Yes, this is what I've had in mind.
> > 
> 
> +1: It makes sense to keep the report going to the dmesg to persist.
> That is where it has always gone and there is no reason to change.
> You can have several OOMs back to back and you'd like to retain the output.
> All the information should be kept together in the OOM report.
> 
> > > 
> > >   static bool (*oom_handler)(struct oom_control *oc) = default_oom_killer;
> > > 
> > >   bool out_of_memory(struct oom_control *oc)
> > >   {
> > >           return oom_handler(oc);
> > >   }
> > > 
> > > and let in-tree kernel modules override current OOM killer would be
> > > the only practical choice (if we refuse adding many knobs).
> > 
> > Or simply provide a hook with the oom_control to be called to report
> > without replacing the whole oom killer behavior. That is not necessary.
> 
> For very simple addition, to add a line of output this works.
> It would still be nice to address the fact the existing OOM Report prints
> all of the user processes or none. It would be nice to add some control
> for that. That's what we did.

Feel like you are going in circles to "sell" without any new information. If you
need to deal with OOM that often, it might also worth working with FB on oomd.

https://github.com/facebookincubator/oomd

It is well-known that kernel OOM could be slow and painful to deal with, so I
don't buy-in the argument that kernel OOM recover is better/faster than a kdump
reboot.

It is not unusual that when the system is triggering a kernel OOM, it is almost
trashed/dead. Although developers are working hard to improve the recovery after
OOM, there are still many error-paths that are not going to survive which would
leak memories, introduce undefined behaviors, corrupt memory etc.

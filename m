Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1FA1E41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfH2PDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 11:03:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34066 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2PDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:03:32 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so7626085ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zORjbGk69oJ5dfKY3b1CqJAsKNTapFMC7SK80j7yvM=;
        b=j6VdB1714vSF2YQaaX7iXfHmGH1RD43tZxcwSxpbEk0OT8d23Dt6hUkqGiY4nsTWGs
         jlZ4H8W2hjcIVXH8dbCxGDpgm7G9HWEw8im9053hWj5MUJATS/KTjJ03vCtiAXSjdEDH
         Ja69Qn4LE0sSvAzAx9TjEGiXitRltLabCr56GvucPKS66SMC3FieNAjDizJioIhhZUtK
         u4ixXxOmfpbAiuxqEr20o59W6Bo2xopdUdi6icuPm42FGjclqj/hy4y3VkycolJNPKlC
         /cCy7kqGQAUS+VX80aqwTyGbS9Pd9gaOhReHPGxJwgi9DoGgmIZ4F974fCXEWHLpGuLz
         7spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zORjbGk69oJ5dfKY3b1CqJAsKNTapFMC7SK80j7yvM=;
        b=JxEzVjGQSAt3SpNDxbo0kmpz/rLqxlqea+DGSsqqC6Z2gmhtiMdRPnUbDWeYXqGmPL
         YxlHz87jsoBKcU85H7c13NTgICbUJUF06wY1RF9qd+SUfCFuDr0GR0+aAL8zW/NlY8aW
         iESBeC8wGlLcDBUbtbtFg4tFpduqx6wCf9bqTmGMIzfPL+qPGxnZdSNoJjZGe1Gnluca
         chyhfd1WjBBIXJ0KAA2vZ1u+BAzeUqOjE6ci/5EG5pJyYpKNlEkB5K22p+edbLKQQuzj
         GCPHpOPl1Ep1tQst+54XwqmDxihBF59fkQrq9aEtaiea9MpSXb92uoqF2VvJ4s3kpp8/
         Y6gw==
X-Gm-Message-State: APjAAAVJ3NfZCwGJWjCUMO3kHxQOpOQnqQoBa0xcOCDaI5EmMWSEi/1f
        GpmDGVQqRkvHAC8HUVMhClb61EIQA93mjwyY6JPU3+b8
X-Google-Smtp-Source: APXvYqx59i598mFm2GBgghGeivK6EaWlSPth0QzEwpZvp75pPj5w+oZSKXR7rqDv3ih969g1f7BxN8U/wVf1ecjdxpU=
X-Received: by 2002:a6b:8b0b:: with SMTP id n11mr5437384iod.101.1567091011925;
 Thu, 29 Aug 2019 08:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190826193638.6638-1-echron@arista.com> <20190827071523.GR7538@dhcp22.suse.cz>
 <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
 <20190828065955.GB7386@dhcp22.suse.cz> <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
 <20190829071105.GQ28313@dhcp22.suse.cz> <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
 <20190829115608.GD28313@dhcp22.suse.cz>
In-Reply-To: <20190829115608.GD28313@dhcp22.suse.cz>
From:   Edward Chron <echron@arista.com>
Date:   Thu, 29 Aug 2019 08:03:19 -0700
Message-ID: <CAM3twVSZm69U8Sg+VxQ67DeycHUMC5C3_f2EpND4_LC4UHx7BA@mail.gmail.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional information
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:56 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 29-08-19 19:14:46, Tetsuo Handa wrote:
> > On 2019/08/29 16:11, Michal Hocko wrote:
> > > On Wed 28-08-19 12:46:20, Edward Chron wrote:
> > >> Our belief is if you really think eBPF is the preferred mechanism
> > >> then move OOM reporting to an eBPF.
> > >
> > > I've said that all this additional information has to be dynamically
> > > extensible rather than a part of the core kernel. Whether eBPF is the
> > > suitable tool, I do not know. I haven't explored that. There are other
> > > ways to inject code to the kernel. systemtap/kprobes, kernel modules and
> > > probably others.
> >
> > As for SystemTap, guru mode (an expert mode which disables protection provided
> > by SystemTap; allowing kernel to crash when something went wrong) could be used
> > for holding spinlock. However, as far as I know, holding mutex (or doing any
> > operation that might sleep) from such dynamic hooks is not allowed. Also we will
> > need to export various symbols in order to allow access from such dynamic hooks.
>
> This is the oom path and it should better not use any sleeping locks in
> the first place.
>
> > I'm not familiar with eBPF, but I guess that eBPF is similar.
> >
> > But please be aware that, I REPEAT AGAIN, I don't think neither eBPF nor
> > SystemTap will be suitable for dumping OOM information. OOM situation means
> > that even single page fault event cannot complete, and temporary memory
> > allocation for reading from kernel or writing to files cannot complete.
>
> And I repeat that no such reporting is going to write to files. This is
> an OOM path afterall.
>
> > Therefore, we will need to hold all information in kernel memory (without
> > allocating any memory when OOM event happened). Dynamic hooks could hold
> > a few lines of output, but not all lines we want. The only possible buffer
> > which is preallocated and large enough would be printk()'s buffer. Thus,
> > I believe that we will have to use printk() in order to dump OOM information.
> > At that point,
>
> Yes, this is what I've had in mind.
>

+1: It makes sense to keep the report going to the dmesg to persist.
That is where it has always gone and there is no reason to change.
You can have several OOMs back to back and you'd like to retain the output.
All the information should be kept together in the OOM report.

> >
> >   static bool (*oom_handler)(struct oom_control *oc) = default_oom_killer;
> >
> >   bool out_of_memory(struct oom_control *oc)
> >   {
> >           return oom_handler(oc);
> >   }
> >
> > and let in-tree kernel modules override current OOM killer would be
> > the only practical choice (if we refuse adding many knobs).
>
> Or simply provide a hook with the oom_control to be called to report
> without replacing the whole oom killer behavior. That is not necessary.

For very simple addition, to add a line of output this works.
It would still be nice to address the fact the existing OOM Report prints
all of the user processes or none. It would be nice to add some control
for that. That's what we did.

> --
> Michal Hocko
> SUSE Labs

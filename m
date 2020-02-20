Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C4A1663CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgBTREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 12:04:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43218 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:04:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so34537996edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvdgQUVfRWdhk7IIxKIGzF9ura73FetwX0VHEX0nREE=;
        b=RGnBeupnO+gVMNXkgEdz6xF3Yi8xjYLf28C7kmJZbCp/KFVl0w6cwhb4aY9TegxhNz
         PC2blYcXwq9xna3dmHt6H7tOMG5jBLyaPwl1pHKf4CaYKMNRwe39XNdxk/7A72g4lvsh
         rkU85kltRa30/4PmfNhOS2Z8Rcs1Op1ALWzFBBY5ABZYnMjx1F5rR2qauxDPHgp19dmI
         KuUq6qUUeOpJ8RQYLIWjasTeIU0jc7tMQ0tnGIRyxpmvDhp5iT9DyfFZ+e15hxowm8Rt
         gvcBvRC6kh0+V5RpykIMk7IONdRYKQY6YjPzgF5g8ssgSV+GvfMAihN+Nr8kFiIOS4D/
         LeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvdgQUVfRWdhk7IIxKIGzF9ura73FetwX0VHEX0nREE=;
        b=DmRu4VTU3J4M/Egw4aDZ5nb87Ig4MCf87TI1839JCTQk8rzZuk9zhS2+jKaiI5vcZd
         f8c/6MyPNkCD7SDTJSBMlCT62EfxqaXCofvO8h+7lFU0hQHboKeqRLC5jgfuL0XXgbhm
         IafL8IFryJbwiqUJ4wgXQgTGEIPaOMSgFbcjHXFyY7WJ0ElfVqxSpj+Aza3BMz6q+UCj
         XJSArxqmRcvTjm+GGnCaV6GMIXZ7kAnTFDNOajLdxjFGChCf4B6ADpq03LKrNgDWBCn2
         F5v007BaK9zGKgyEWkHJOBg/XgSM6is7LEYJplYykVoZnSPz20SPU4C+klosQnAuo9FO
         CvnQ==
X-Gm-Message-State: APjAAAVPaTAihujHWtO/SiWk+3FlgeUvySkxXzExVBhDCNdw59LFlhHA
        vCZ0UDnnRZi9pSj2TG8PMHjziE2d0hSS4LOVhuwy5rU9
X-Google-Smtp-Source: APXvYqzDKRPRb1AfMfvE+R1DjelsaP1oPwnUkKn8biKIQS9+YWs9RuQ9kxVdlWudPc9yopXNmnx4HuBlCiSkQMqZ73U=
X-Received: by 2002:a05:6402:17aa:: with SMTP id j10mr27781546edy.256.1582218245755;
 Thu, 20 Feb 2020 09:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20200218224422.3407-1-richardw.yang@linux.intel.com>
 <20200219120810.c7677fa58594f5423549f59d@linux-foundation.org> <20200220075218.GA20509@dhcp22.suse.cz>
In-Reply-To: <20200220075218.GA20509@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Feb 2020 09:03:52 -0800
Message-ID: <CAHbLzkr9B1EdNuxPqRF5PrsoO+ZaHdJBydQiMRAEjgq9uRgpMQ@mail.gmail.com>
Subject: Re: [Patch v4] mm/vmscan.c: remove cpu online notification for now
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:52 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 19-02-20 12:08:10, Andrew Morton wrote:
> > On Wed, 19 Feb 2020 06:44:22 +0800 Wei Yang <richardw.yang@linux.intel.com> wrote:
> >
> > > kswapd kernel thread starts either with a CPU affinity set to the full
> > > cpu mask of its target node or without any affinity at all if the node
> > > is CPUless. There is a cpu hotplug callback (kswapd_cpu_online) that
> > > implements an elaborate way to update this mask when a cpu is onlined.
> > >
> > > It is not really clear whether there is any actual benefit from this
> > > scheme. Completely CPU-less NUMA nodes rarely gain a new CPU during
> > > runtime.
> >
> > This is the case across all platforms, all architectures, all users for
> > the next N years?  I'm surprised that we know this with sufficient
> > confidence.  Can you explain how you came to make this assertion?
>
> CPUless NUMA nodes are quite rare - mostly ppc with crippled LPARs.
> I am not aware those would dynamically get CPUs for those nodes later in
> the runtime. Maybe they do but we would like to learn about that. A
> missing cpu mask is not going cause any fatal problems anyway.

Persistent memory nodes are CPUless nodes. But, I don't think they
would get any CPU online later in the runtime.

>
> As the changelog states the callback can be reintroduced with a sign of
> testing and usecase description. I prefer we drop this code in the mean
> time as the benefit is not really clear or testable.
>
> > > Drop the code for that reason. If there is a real usecase then
> > > we can resurrect and simplify the code.
>
> --
> Michal Hocko
> SUSE Labs
>

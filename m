Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CE03272B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfFCERZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 00:17:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55938 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfFCERZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:17:25 -0400
Received: by mail-it1-f195.google.com with SMTP id i21so5430377ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 21:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peq2xV3j8zNOQJyA2LbX3LqEkuEYYsXuOFqRHr6IOqU=;
        b=JvnVuQ4DFdCbGb+8Zkv/5rIcwPRGyExzreijPgFZCDf13bLjpWA1pBc9IWKBym8Zq3
         Dci1cuZ6qApdvxMotCr/3WT1QMVvIwyzODuiB7N8fS74ianiMACqbup4doeNor1vXaW9
         K8qsNwrK3e6YPdAJqj906ywET3GPFb0BNLXfufIsz+30ofscGa/T135AsetxqGKwgwIZ
         6xZtbejKj08KOQpeoF3xUvEWXVcP7BUCI4ldDIipUBq6FvopxgB4ToFqrxl5SNgUm7TJ
         YoSAEM6WIJiPz7kGg5b+r9mz0kmSfIrv1xrpSDSRH1T9n2mfdZNXFN32wE/DMYTzYVdr
         k6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peq2xV3j8zNOQJyA2LbX3LqEkuEYYsXuOFqRHr6IOqU=;
        b=Jaj4ZG9wVUTzHp2LE8UbpEXoIE1f+/IR19AIRCHdQVPB9MZdfm646mK25N/0oHh3cA
         mMdfk0cjdfr1BtsDrEdm/bkJJ4l4uTAegqfcxCeWiaJVe19JdHfaK89YQ1/Wn3zR4U02
         IZL96CQWiVM2uXFYeyUilj5PhXL8wCBjKvlP22KBD8TfbN1LQEqAEZBZAM5ojvtUVXPj
         qRwrGtkTN1jFu5kIHDX+epPu9u9P6G8RpztppvZE0u/pd4dLOSFa9hvnfoVmZnUJHz4m
         im/lv5ryvFoDiSN+uuHSe0lXSKZon23K1IoKToc6cEeJSrYbG5b2AeEsHI3KylVRs+05
         P4zg==
X-Gm-Message-State: APjAAAXNqCj4hRBZd7ZL34cC3Q/Rs/vfkfjEZUg0hXjHRFhJ80dcE1Sv
        ShrQG6vJJsCW4r/6Idl70LE+x2lX5R5LD3T+8w==
X-Google-Smtp-Source: APXvYqzDOjcNERX9CF10zqE2yCDGi7bcANmriTIIlUc06WqLqaxg59EX82ZHvw1lnZvxd2+smyAh3WoWcHvrCLG+onA=
X-Received: by 2002:a24:7cd8:: with SMTP id a207mr6545545itd.68.1559535444067;
 Sun, 02 Jun 2019 21:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190513124112.GH24036@dhcp22.suse.cz> <1557755039.6132.23.camel@lca.pw>
 <20190513140448.GJ24036@dhcp22.suse.cz> <1557760846.6132.25.camel@lca.pw>
 <20190513153143.GK24036@dhcp22.suse.cz> <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz> <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
 <20190528182011.GG1658@dhcp22.suse.cz> <CAFgQCTtD5OYuDwRx1uE7R9N+qYf5k_e=OxajpPWZWb70+QgBvg@mail.gmail.com>
 <20190531090307.GL6896@dhcp22.suse.cz>
In-Reply-To: <20190531090307.GL6896@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 3 Jun 2019 12:17:12 +0800
Message-ID: <CAFgQCTv0oef9AX14FAzjB-WsdsNB+vBmjsRoRPKOGP9JfzJhLA@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA boot
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 5:03 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 30-05-19 20:55:32, Pingfan Liu wrote:
> > On Wed, May 29, 2019 at 2:20 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > [Sorry for a late reply]
> > >
> > > On Thu 23-05-19 11:58:45, Pingfan Liu wrote:
> > > > On Wed, May 22, 2019 at 7:16 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Wed 22-05-19 15:12:16, Pingfan Liu wrote:
> > > [...]
> > > > > > But in fact, we already have for_each_node_state(nid, N_MEMORY) to
> > > > > > cover this purpose.
> > > > >
> > > > > I do not really think we want to spread N_MEMORY outside of the core MM.
> > > > > It is quite confusing IMHO.
> > > > > .
> > > > But it has already like this. Just git grep N_MEMORY.
> > >
> > > I might be wrong but I suspect a closer review would reveal that the use
> > > will be inconsistent or dubious so following the existing users is not
> > > the best approach.
> > >
> > > > > > Furthermore, changing the definition of online may
> > > > > > break something in the scheduler, e.g. in task_numa_migrate(), where
> > > > > > it calls for_each_online_node.
> > > > >
> > > > > Could you be more specific please? Why should numa balancing consider
> > > > > nodes without any memory?
> > > > >
> > > > As my understanding, the destination cpu can be on a memory less node.
> > > > BTW, there are several functions in the scheduler facing the same
> > > > scenario, task_numa_migrate() is an example.
> > >
> > > Even if the destination node is memoryless then any migration would fail
> > > because there is no memory. Anyway I still do not see how using online
> > > node would break anything.
> > >
> > Suppose we have nodes A, B,C, where C is memory less but has little
> > distance to B, comparing with the one from A to B. Then if a task is
> > running on A, but prefer to run on B due to memory footprint.
> > task_numa_migrate() allows us to migrate the task to node C. Changing
> > for_each_online_node will break this.
>
> That would require the task to have preferred node to be C no? Or do I
> missunderstand the task migration logic?
I think in task_numa_migrate(), the migration logic should looks like:
  env.dst_nid = p->numa_preferred_nid; //Here dst nid is B
But later in
  if (env.best_cpu == -1 || (p->numa_group &&
p->numa_group->active_nodes > 1)) {
    for_each_online_node(nid) {
[...]
       task_numa_find_cpu(&env, taskimp, groupimp); // Here is a
chance to change p->numa_preferred_nid

There are serveral other broken by changing for_each_online_node(),
-1. show_numa_stats()
-2. init_numa_topology_type(), where sched_numa_topology_type may be
mistaken evaluated.
-3. ... can check call to for_each_online_node() one by one in scheduler.

That is my understanding of the code.

Thanks,
  Pingfan

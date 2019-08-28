Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9CC9FFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfH1KcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 06:32:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbfH1KcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:32:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 434A7AFBE;
        Wed, 28 Aug 2019 10:32:13 +0000 (UTC)
Date:   Wed, 28 Aug 2019 12:32:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Edward Chron <echron@arista.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
Message-ID: <20190828103211.GD28313@dhcp22.suse.cz>
References: <20190826193638.6638-1-echron@arista.com>
 <1566909632.5576.14.camel@lca.pw>
 <CAM3twVQEMGWMQEC0dduri0JWt3gH6F2YsSqOmk55VQz+CZDVKg@mail.gmail.com>
 <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw>
 <CAM3twVSdxJaEpmWXu2m_F1MxFMB58C6=LWWCDYNn5yT3Ns+0sQ@mail.gmail.com>
 <2A1D8FFC-9E9E-4D86-9A0E-28F8263CC508@lca.pw>
 <CAM3twVR5TVuuZSLM2qRJYnkCEKVZmA3XDNREaB+wdKH2Ne9vVA@mail.gmail.com>
 <20190828070845.GC7386@dhcp22.suse.cz>
 <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-08-19 19:12:41, Tetsuo Handa wrote:
> On 2019/08/28 16:08, Michal Hocko wrote:
> > On Tue 27-08-19 19:47:22, Edward Chron wrote:
> >> For production systems installing and updating EBPF scripts may someday
> >> be very common, but I wonder how data center managers feel about it now?
> >> Developers are very excited about it and it is a very powerful tool but can I
> >> get permission to add or replace an existing EBPF on production systems?
> > 
> > I am not sure I understand. There must be somebody trusted to take care
> > of systems, right?
> > 
> 
> Speak of my cases, those who take care of their systems are not developers.
> And they afraid changing code that runs in kernel mode. They unlikely give
> permission to install SystemTap/eBPF scripts. As a result, in many cases,
> the root cause cannot be identified.

Which is something I would call a process problem more than a kernel
one. Really if you need to debug a problem you really have to trust
those who can debug that for you. We are not going to take tons of code
to the kernel just because somebody is afraid to run a diagnostic.

> Moreover, we are talking about OOM situations, where we can't expect userspace
> processes to work properly. We need to dump information we want, without
> counting on userspace processes, before sending SIGKILL.

Yes, this is an inherent assumption I was making and that means that
whatever dynamic hooks would have to be registered in advance.

-- 
Michal Hocko
SUSE Labs

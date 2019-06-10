Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6293BC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbfFJS6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 14:58:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388069AbfFJS6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:58:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B8E2ABC7;
        Mon, 10 Jun 2019 18:58:05 +0000 (UTC)
Date:   Mon, 10 Jun 2019 20:58:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/5] proc: use down_read_killable for
 /proc/pid/smaps_rollup
Message-ID: <20190610185804.GB2388@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790967469.1319.14744588086607025680.stgit@buzz>
 <20190517124555.GB1825@dhcp22.suse.cz>
 <bda80d9c-7594-94c9-db2c-37b8bc3b58c8@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda80d9c-7594-94c9-db2c-37b8bc3b58c8@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-06-19 12:07:36, Konstantin Khlebnikov wrote:
[...]
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 2bf210229daf..781879a91e3b 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -832,7 +832,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
> > >   	memset(&mss, 0, sizeof(mss));
> > > -	down_read(&mm->mmap_sem);
> > > +	ret = down_read_killable(&mm->mmap_sem);
> > > +	if (ret)
> > > +		goto out_put_mm;
> > 
> > Why not ret = -EINTR. The seq_file code seems to be handling all errors
> > AFAICS.
> > 
> 
> I've missed your comment. Sorry.
> 
> down_read_killable returns 0 for success and exactly -EINTR for failure.

You are right of course. I must have misread the code at the time. Sorry
about that.
-- 
Michal Hocko
SUSE Labs

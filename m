Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32C3BC43E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 10:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440692AbfIXIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 04:48:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439012AbfIXIs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:48:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03C52B689;
        Tue, 24 Sep 2019 08:48:55 +0000 (UTC)
Date:   Tue, 24 Sep 2019 10:48:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: threads-max observe limits
Message-ID: <20190924084854.GD23050@dhcp22.suse.cz>
References: <20190917100350.GB1872@dhcp22.suse.cz>
 <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
 <20190917153830.GE1872@dhcp22.suse.cz>
 <87ftku96md.fsf@x220.int.ebiederm.org>
 <20190918071541.GB12770@dhcp22.suse.cz>
 <87h8585bej.fsf@x220.int.ebiederm.org>
 <20190922065801.GB18814@dhcp22.suse.cz>
 <875zlk3tz9.fsf@x220.int.ebiederm.org>
 <20190923080808.GA6016@dhcp22.suse.cz>
 <87mueuu2oz.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mueuu2oz.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-09-19 16:23:40, Eric W. Biederman wrote:
> 
> Michal,
> 
> Thinking about this I have a hunch about what changed.  I think at some
> point we changed from 4k to 8k kernel stacks.  So I suspect if your
> client is seeing a lower threads-max it is because the size of the
> kernel data structures increased.

This is indeed the case. Starting since 6538b8ea886e ("x86_64: expand
kernel stack to 16K") (3.16) we use THREAD_SIZE_ORDER = 2 and that
halved the auto-tuned value.

In the particular case
3.12
kernel.threads-max = 515561

4.4
kernel.threads-max = 200000

Neither of the two values is really insane on 32GB machine. 

I am not sure we want/need to tune the max_thread value further. If
anything the tuning should be removed altogether if proven not useful in
general. But we definitely need a way to override this auto-tuning.

Thanks
-- 
Michal Hocko
SUSE Labs

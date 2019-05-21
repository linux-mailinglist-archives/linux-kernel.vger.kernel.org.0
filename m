Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F268125392
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfEUPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 11:13:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35836 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:13:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id t1so7327222pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Cne2bRYNPxMo5lmC9R59wEbEO25DcAAnjTK4xwTSsw=;
        b=vvF2ly7Y0wh8rEKGoM/nP1Sr+IzMtLX6R8YZKQNaoZMuxDzWF30t1pjXXrwMnFWtYU
         YPWEZdFYsOK4jjKc7lSLLpkq6Yolzu8OeeVDtpOjFeEHbWwXnwS0tZF71Ehoz7SRP8JH
         cd/7Q7FGWBLP3qUx2SyBht7VsbmWCvyoNSx+VI3mtX2xszi2+EnRY7//0hd08r3oxfsd
         d5HYrRPLE/yGLtVUYPvR4RO9dwirfQf+IZ9Q3KgZuTre9w+IWg9nzYLAFViv+/hhiILl
         zgxCceVehFZmIea/bZtgKWoXByvQJpPyneRLY+kqq9XWyno/AUFyx3TJ/SsxpZHg7Lqc
         WOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Cne2bRYNPxMo5lmC9R59wEbEO25DcAAnjTK4xwTSsw=;
        b=QSkAqQU5/lLwzAg0MAZxEysHG+NAiM3No1nbMb8A7Q7hI5T2hMSwiv5A04PHgPHhJb
         tbRgBrTyMXGXvjUUZMrdU441o8DXHMzZ2J4Rhuw/wDG/SYQB6vmRWB2mcVaJZKyBJ0ke
         Ieo1AW7nAuCEHKmxApKIMZx7s76903XmcKZJQxGEvzhr1WXY3Q0ibtDU52ZnnCLjIUYt
         v5vYi79lQA3/+5ePWNSxsrbew4OnMS1dYGRps2eRNXN/KuxDdmGKLVV4yfFkRbjUGQsu
         +CxzlSPqUK5abkFrVn61xv/19HpNXFL7wfFjlCMaGFbsG0Pla/1aBq7LXJ/Ze6f8wxPm
         jNMQ==
X-Gm-Message-State: APjAAAVx5EnfAISK+O8mig4ByhEkTx5LB/yTRoO0JTrhztKGMz74p8cH
        Jfl43bA00CeiDoP8MMJI8KsQZg==
X-Google-Smtp-Source: APXvYqyZQId8yWqAlUm2SopVKQGWh4BCL659CihessrNtjNEiWmXlf6koJd2gpBMpnBH3euqpXn59A==
X-Received: by 2002:a62:cdc6:: with SMTP id o189mr61458362pfg.74.1558451638227;
        Tue, 21 May 2019 08:13:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5a76])
        by smtp.gmail.com with ESMTPSA id v1sm22978952pgb.85.2019.05.21.08.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 08:13:57 -0700 (PDT)
Date:   Tue, 21 May 2019 11:13:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     lkp@01.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [LKP] [mm] 42a3003535: will-it-scale.per_process_ops -25.9%
 regression
Message-ID: <20190521151355.GA2870@cmpxchg.org>
References: <20190520063534.GB19312@shao2-debian>
 <20190520215328.GA1186@cmpxchg.org>
 <20190521134646.GE19312@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521134646.GE19312@shao2-debian>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 09:46:46PM +0800, kernel test robot wrote:
> On Mon, May 20, 2019 at 05:53:28PM -0400, Johannes Weiner wrote:
> > Hello,
> > 
> > On Mon, May 20, 2019 at 02:35:34PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed a -25.9% regression of will-it-scale.per_process_ops due to commit:
> > > 
> > > 
> > > commit: 42a300353577ccc17ecc627b8570a89fa1678bec ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: will-it-scale
> > > on test machine: 192 threads Skylake-SP with 256G memory
> > > with following parameters:
> > 
> > Ouch. That has to be the additional cache footprint of the split
> > local/recursive stat counters, rather than the extra instructions.
> > 
> > Could you please try re-running the test on that host with the below
> > patch applied?
> 
> Hi,
> 
> The patch can fix the regression.
> 
> tests: 1
> testcase/path_params/tbox_group/run: will-it-scale/performance-process-100%-page_fault3/lkp-skl-4sp1
> 
> db9adbcbe7 ("mm: memcontrol: move stat/event counting functions out-of-line")
> 8d8245997d ("mm: memcontrol: don't batch updates of local VM stats and events")
> 
> db9adbcbe740e098  8d8245997dbd17c5056094f15c  
> ----------------  --------------------------  
>          %stddev      change         %stddev
>              \          |                \  
>   87819982                    85307742        will-it-scale.workload
>     457395                      444310        will-it-scale.per_process_ops

Fantastic, thank you for verifying! I'm going to take that as a
Tested-by.

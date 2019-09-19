Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55117B7483
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 09:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfISH7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 03:59:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbfISH7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:59:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF259AD2B;
        Thu, 19 Sep 2019 07:59:11 +0000 (UTC)
Date:   Thu, 19 Sep 2019 09:59:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: threads-max observe limits
Message-ID: <20190919075911.GA15782@dhcp22.suse.cz>
References: <20190917100350.GB1872@dhcp22.suse.cz>
 <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
 <20190917153830.GE1872@dhcp22.suse.cz>
 <87ftku96md.fsf@x220.int.ebiederm.org>
 <20190918071541.GB12770@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918071541.GB12770@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-09-19 09:15:41, Michal Hocko wrote:
> On Tue 17-09-19 12:26:18, Eric W. Biederman wrote:
[...]
> > b) Not being able to bump threads_max to the physical limit of
> >    the machine is very clearly a regression.
> 
> ... exactly this part. The changelog of the respective patch doesn't
> really exaplain why it is needed except of "it sounds like a good idea
> to be consistent".

Any take on this Heinrich? If there really is not strong reasoning about
the restricting user input then I will suggest reverting 16db3d3f1170
("kernel/sysctl.c: threads-max observe limits")

-- 
Michal Hocko
SUSE Labs

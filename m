Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1941997C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfHUOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 10:06:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbfHUOGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:06:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C940AF59;
        Wed, 21 Aug 2019 14:06:33 +0000 (UTC)
Date:   Wed, 21 Aug 2019 16:06:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, dan.j.williams@intel.com,
        osalvador@suse.de, richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
Message-ID: <20190821140632.GI3111@dhcp22.suse.cz>
References: <20190813014012.30232-1-khalid.aziz@oracle.com>
 <20190813140553.GK17933@dhcp22.suse.cz>
 <3cb0af00-f091-2f3e-d6cc-73a5171e6eda@oracle.com>
 <20190814085831.GS17933@dhcp22.suse.cz>
 <d3895804-7340-a7ae-d611-62913303e9c5@oracle.com>
 <20190815170215.GQ9477@dhcp22.suse.cz>
 <2668ad2e-ee52-8c88-22c0-1952243af5a1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2668ad2e-ee52-8c88-22c0-1952243af5a1@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-08-19 14:51:04, Khalid Aziz wrote:
> Hi Michal,
> 
> The smarts for tuning these knobs can be implemented in userspace and
> more knobs added to allow for what is missing today, but we get back to
> the same issue as before. That does nothing to make kernel self-tuning
> and adds possibly even more knobs to userspace. Something so fundamental
> to kernel memory management as making free pages available when they are
> needed really should be taken care of in the kernel itself. Moving it to
> userspace just means the kernel is hobbled unless one installs and tunes
> a userspace package correctly.

From my past experience the existing autotunig works mostly ok for a
vast variety of workloads. A more clever tuning is possible and people
are doing that already. Especially for cases when the machine is heavily
overcommited. There are different ways to achieve that. Your new
in-kernel auto tuning would have to be tested on a large variety of
workloads to be proven and riskless. So I am quite skeptical to be
honest.

Therefore I would really focus on discussing whether we have sufficient
APIs to tune the kernel to do the right thing when needed. That requires
to identify gaps in that area.
-- 
Michal Hocko
SUSE Labs

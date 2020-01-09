Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DA1351D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 04:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgAIDSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 22:18:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:33749 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbgAIDSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:18:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 19:18:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,412,1571727600"; 
   d="scan'208";a="421652315"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jan 2020 19:18:20 -0800
Date:   Thu, 9 Jan 2020 11:18:21 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200109031821.GA5206@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <20200106102345.GE12699@dhcp22.suse.cz>
 <20200107012241.GA15341@richard>
 <20200107083808.GC32178@dhcp22.suse.cz>
 <20200108003543.GA13943@richard>
 <20200108094041.GQ32178@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108094041.GQ32178@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 10:40:41AM +0100, Michal Hocko wrote:
>On Wed 08-01-20 08:35:43, Wei Yang wrote:
>> On Tue, Jan 07, 2020 at 09:38:08AM +0100, Michal Hocko wrote:
>> >On Tue 07-01-20 09:22:41, Wei Yang wrote:
>> >> On Mon, Jan 06, 2020 at 11:23:45AM +0100, Michal Hocko wrote:
>> >> >On Fri 03-01-20 22:34:07, Wei Yang wrote:
>> >> >> As all the other places, we grab the lock before manipulate the defer list.
>> >> >> Current implementation may face a race condition.
>> >> >
>> >> >Please always make sure to describe the effect of the change. Why a racy
>> >> >list_empty check matters?
>> >> >
>> >> 
>> >> Hmm... access the list without proper lock leads to many bad behaviors.
>> >
>> >My point is that the changelog should describe that bad behavior.
>> >
>> >> For example, if we grab the lock after checking list_empty, the page may
>> >> already be removed from list in split_huge_page_list. And then list_del_init
>> >> would trigger bug.
>> >
>> >And how does list_empty check under the lock guarantee that the page is
>> >on the deferred list?
>> 
>> Just one confusion, is this kind of description basic concept of concurrent
>> programming? How detail level we need to describe the effect?
>
>When I write changelogs for patches like this I usually describe, what
>is the potential race - e.g.
>	CPU1			CPU2
>	path1			path2
>	  check			  lock
>	  			    operation2
>				  unlock
>	    lock
>	    # check might not hold anymore
>	    operation1
>	    unlock
>
>and what is the effect of the race - e.g. a crash, data corruption,
>pointless attempt for operation1 which fails with user visible effect
>etc.

Hi, Michal, here is my attempt for an example. Hope this one looks good to
you.


    For example, the potential race would be:
    
        CPU1                      CPU2
        mem_cgroup_move_account   split_huge_page_to_list
          !list_empty
                                    lock
                                    !list_empty
                                    list_del
                                    unlock
          lock
          # !list_empty might not hold anymore
          list_del_init
          unlock
    
    When this sequence happens, the list_del_init() in
    mem_cgroup_move_account() would crash since the page is already been
    removed by list_del in split_huge_page_to_list().


-- 
Wei Yang
Help you, Help me

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8C14492C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 02:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAVBAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 20:00:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:61932 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgAVBAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:00:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 17:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="229081543"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2020 17:00:13 -0800
Date:   Wed, 22 Jan 2020 09:00:24 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
Subject: Re: [Patch v2 4/4] mm/page_alloc.c: extract commom part to check page
Message-ID: <20200122010024.GF11409@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-5-richardw.yang@linux.intel.com>
 <3987ae0f-cbfc-1066-c78f-c5c6efc570ed@arm.com>
 <20200120123621.GE18028@richard>
 <c4abbe4d-6777-6c06-2a47-e01585b12745@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4abbe4d-6777-6c06-2a47-e01585b12745@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 10:19:38AM +0530, Anshuman Khandual wrote:
>
>
>On 01/20/2020 06:06 PM, Wei Yang wrote:
>> On Mon, Jan 20, 2020 at 12:13:38PM +0530, Anshuman Khandual wrote:
>>>
>>>
>>> On 01/20/2020 08:34 AM, Wei Yang wrote:
>>>> During free and new page, we did some check on the status of page
>>>> struct. There is some common part, just extract them.
>>>
>>> Makes sense.
>>>
>>>>
>>>> Besides this, this patch also rename two functions to keep the name
>>>> convention, since free_pages_check_bad/free_pages_check are counterparts
>>>> of check_new_page_bad/check_new_page.
>>>
>>> This probably should be in a different patch.
>>>
>> 
>> In v1, they are in two separate patches. While David Suggest to merge it.
>> 
>> I am not sure whether my understanding is correct.
>
>Keeping code refactoring and renaming separate is always better
>but its okay, will leave it upto you.
>

Agree with you :-)

Maybe I misunderstand David. Will split it in next version.

-- 
Wei Yang
Help you, Help me

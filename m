Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1E96E93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 02:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfHUAxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 20:53:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:36686 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfHUAxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:53:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 17:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; 
   d="scan'208";a="178350826"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 20 Aug 2019 17:52:57 -0700
Date:   Wed, 21 Aug 2019 08:52:34 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mmap.c: extract __vma_unlink_list as counter part
 for __vma_link_list
Message-ID: <20190821005234.GA5540@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
 <20190814021755.1977-3-richardw.yang@linux.intel.com>
 <20190814051611.GA1958@infradead.org>
 <20190814065703.GA6433@richard>
 <2c5cdffd-f405-23b8-98f5-37b95ca9b027@suse.cz>
 <20190820172629.GB4949@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820172629.GB4949@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:26:29AM -0700, Matthew Wilcox wrote:
>On Wed, Aug 14, 2019 at 11:19:37AM +0200, Vlastimil Babka wrote:
>> On 8/14/19 8:57 AM, Wei Yang wrote:
>> > On Tue, Aug 13, 2019 at 10:16:11PM -0700, Christoph Hellwig wrote:
>> >>Btw, is there any good reason we don't use a list_head for vma linkage?
>> > 
>> > Not sure, maybe there is some historical reason?
>> 
>> Seems it was single-linked until 2010 commit 297c5eee3724 ("mm: make the vma
>> list be doubly linked") and I guess it was just simpler to add the vm_prev link.
>> 
>> Conversion to list_head might be an interesting project for some "advanced
>> beginner" in the kernel :)
>
>I'm working to get rid of vm_prev and vm_next, so it would probably be
>wasted effort.

You mean replace it with list_head?

-- 
Wei Yang
Help you, Help me

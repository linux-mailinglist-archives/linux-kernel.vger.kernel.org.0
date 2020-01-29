Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA914C40A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 01:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgA2Abv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 19:31:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:44879 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgA2Abu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:31:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 16:31:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,375,1574150400"; 
   d="scan'208";a="229457123"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 28 Jan 2020 16:31:48 -0800
Date:   Wed, 29 Jan 2020 08:32:00 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com
Subject: Re: [Patch v2 1/4] mm/migrate.c: not necessary to check start and i
Message-ID: <20200129003200.GB12835@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200122011647.13636-1-richardw.yang@linux.intel.com>
 <20200122011647.13636-2-richardw.yang@linux.intel.com>
 <fa4b94a7-4b70-ab01-e5e5-8eeb18b15c62@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4b94a7-4b70-ab01-e5e5-8eeb18b15c62@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:04:23AM +0100, David Hildenbrand wrote:
>On 22.01.20 02:16, Wei Yang wrote:
>> Till here, i must no less than start. And if i equals to start,
>> store_status() would always return 0.
>
>I'd suggest
>
>"
>mm/migrate.c: no need to check for i > start in do_pages_move()
>
>At this point, we always have i >= start. If i == start, store_status()
>will return 0. So we can drop the check for i > start.
>"
>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>

Thanks, I took it.

-- 
Wei Yang
Help you, Help me

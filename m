Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6828B456FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfFNIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 04:09:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:19825 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfFNIJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:09:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 01:09:16 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2019 01:09:14 -0700
Date:   Fri, 14 Jun 2019 16:08:50 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] kernel/memremap.c: use ALIGN/ALIGN_DOWN to calculate
 align_start/end
Message-ID: <20190614080850.GA19846@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190614060143.17867-1-richardw.yang@linux.intel.com>
 <CAPcyv4hohqZ0DVriW=cdgH+9jrxWoWq4FFk-KGqvtqJHOTt7eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hohqZ0DVriW=cdgH+9jrxWoWq4FFk-KGqvtqJHOTt7eg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:06:13PM -0700, Dan Williams wrote:
>On Thu, Jun 13, 2019 at 11:02 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> The purpose of align_start/end is to expand to SECTION boundary. Use
>> ALIGN/ALIGN_DOWN directly is more self-explain and clean.
>
>I'm actively trying to kill this code [1] so I don't see the need for
>this patch.
>
>[1]: https://lore.kernel.org/lkml/155977193326.2443951.14201009973429527491.stgit@dwillia2-desk3.amr.corp.intel.com/

Ah, thanks :-)

-- 
Wei Yang
Help you, Help me

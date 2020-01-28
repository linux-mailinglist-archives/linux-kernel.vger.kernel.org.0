Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11F14B302
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 11:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgA1KuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 05:50:11 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:37368 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgA1KuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580208609; x=1611744609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=WYtCBgBVN8ObAntGrLP9PSwj39O1B410LMI+5OpI30E=;
  b=nTDNH8XYvUKl0hzaXfJUaJG7iblk5gCxNUulLYXN2goLXts0pgEpZlFz
   xpoUdDptLQ6d3NdcRvX66fHJIDz470gq997a2s8jwnNETxOzqU3uSlONQ
   +jOl2EQSJEuBKOGD4nfrGlbUeKCgZS6h0HW1w5j8MrhzVABWQLP4TQ29u
   A=;
IronPort-SDR: 0Hsb+qv42wSiM41C93C4a1LfhcjySaLvJzM+hKrBuLySIDMN7FQIj68NhS/Pw2n8brqfJ6m+/6
 U5kUDS2M0P6g==
X-IronPort-AV: E=Sophos;i="5.70,373,1574121600"; 
   d="scan'208";a="14547675"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 28 Jan 2020 10:50:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 3B6FFA24EE;
        Tue, 28 Jan 2020 10:50:05 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 28 Jan 2020 10:50:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.74) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 10:49:56 +0000
From:   <sjpark@amazon.com>
To:     Qian Cai <cai@lca.pw>
CC:     <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, <sj38.park@gmail.com>,
        <acme@kernel.org>, <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <corbet@lwn.net>, <dwmw@amazon.com>, <mgorman@suse.de>,
        <rostedt@goodmis.org>, <kirill@shutemov.name>,
        <brendanhiggins@google.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Date:   Tue, 28 Jan 2020 11:49:42 +0100
Message-ID: <20200128104942.11419-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <D20B234E-04EE-4410-9B27-FF63AB3E1808@lca.pw> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.74]
X-ClientProxiedBy: EX13D39UWA001.ant.amazon.com (10.43.160.54) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 05:20:35 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> > On Jan 28, 2020, at 3:58 AM, sjpark@amazon.com wrote:
> > 
> > This patchset introduces a new kernel module for practical monitoring of data
> > accesses, namely DAMON.
> > 
> > The patches are organized in the following sequence.  The first four patches
> > implements the core logic of DAMON one by one.  After that, the fifth patch
> > implements DAMON's debugfs interface for users.  To provide a minimal reference
> > to the low level interface and for more convenient use/tests of the DAMON, the
> > sixth patch implements an user space tool.  The seventh patch adds a document
> > for administrators of DAMON, and the eightth patch provides DAMON's kunit
> > tests.  Finally, the ninth patch implements a tracepoint for DAMON.  As the
> > tracepoint prints every monitoring results, it will be easily integrated with
> > other tracers supporting tracepoints including perf.
> 
> I am a bit surprised that this patchset did not include perf maintainers which makes me wonder if there is any attempt to discuss first if we actually need a whole new subsystem for it or a existing tool can be enhanced.

For the comments from perf maintainers, I added Steven Rostedt and Arnaldo
Carvalho de Melo first, but I might missed someone.  If you recommend some more
people, I will add them to recipients.

I made DAMON as a new subsystem because I think no existing subsystem fits well
to be a base of DAMON, due to DAMON's unique goals and mechanisms described
below in the original cover letter.

The existing subsystem that most similar to DAMON might be 'mm/page_idle.c'.
However, there are many conceptual differences with DAMON.  One biggest
difference I think is the target.  'page_idle' deals with physical page frames
while DAMON deals with virtual address of specific processes.

Nevertheless, if you have some different opinion, please let me know.


Thanks,
SeongJae Park

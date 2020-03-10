Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CE17F6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCJL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 07:56:32 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:36263 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCJL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841392; x=1615377392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=XgE7fl2rsu1FY7ZdIVhp6neAOLJV5gIrJsW3gETU0eM=;
  b=HEVK8xf50yNJCWCslyH5qH7VsjfplPeENWOnOla3jcP8gwZ4ZCL1l0q4
   T8cocqDUSYFDBgLOxxqQCAyBbHdnkjjHszR213oeMuJ/0aJAgCHoTCE2L
   A1ICcn90vLlupGYRp4hlqlSVLspu6y6NhurXoEOpxld9mTEoGzdhMzLjf
   8=;
IronPort-SDR: 0Hzydumc9Ij+7hDen+sL7JUWLL5Ret2Tmu1RWo6Sr1AL94jtdCPeH/n9LuHToof97fSrrZZupW
 HxW5PLblkjgg==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="30315489"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Mar 2020 11:56:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id A4F76A0687;
        Tue, 10 Mar 2020 11:56:17 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:56:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.67) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:56:04 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 06/14] mm/damon: Implement access pattern recording
Date:   Tue, 10 Mar 2020 12:55:49 +0100
Message-ID: <20200310115550.24668-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310090134.000052fb@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.67]
X-ClientProxiedBy: EX13D16UWB004.ant.amazon.com (10.43.161.170) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 09:01:34 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:39 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit implements the recording feature of DAMON. If this feature
> > is enabled, DAMON writes the monitored access patterns in its binary
> > format into a file which specified by the user. This is already able to
> > be implemented by each user using the callbacks.  However, as the
> > recording is expected to be used widely, this commit implements the
> > feature in the DAMON, for more convenience and efficiency.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> I guess this work whilst you are still developing, but I'm not convinced
> writing to a file should be a standard feature...

I also not sure whether this is right feature of the kernel or not, but this
would minimize many efforts in user space.  I also thought that this might be
not out of the intention of the 'kernel_write()'.

Nonetheless, this patch could be simply removed, as DAMON supports tracepoints
and the recording can be implemented on user space using it.

Could I ask your other suggestions for this feature?


Thanks,
SeongJae Park

> 
> > ---
[...]

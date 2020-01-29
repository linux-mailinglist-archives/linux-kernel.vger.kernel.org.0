Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91A14CC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 15:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgA2Oia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 09:38:30 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:48016 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgA2Oi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580308708; x=1611844708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=bqxr2sAx9WQlUP82ojVknqUNvkUIq8pa07GIMIXno9s=;
  b=QULbXXD6K8Jk5L0OLjMUg5rD9NyLcmUTrXTDWqBlEJtuKOKOIk0nYBiO
   40t+LNutdYLWjEv32pZPS0zCX6peGCPaRH3IbMS3xek66/erDkjt9GQG+
   6ieYuyl5oO8d8eXt8jYjf3riLqPFllELeyin6Mr2eEoLUOP824/AKe8SV
   U=;
IronPort-SDR: AClB7990+0/opEElcsfz8DKWhav6SwPcIhOng9L/QrIR61E1xBkJnpmolex7GGj0v2jaWOucPq
 EOh+6YBOZfnQ==
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="15303139"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 29 Jan 2020 14:38:25 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id E62C4A2A04;
        Wed, 29 Jan 2020 14:38:23 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 14:38:23 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 14:38:13 +0000
From:   <sjpark@amazon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, <sj38.park@gmail.com>,
        <acme@kernel.org>, <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <corbet@lwn.net>, <dwmw@amazon.com>, <mgorman@suse.de>,
        <rostedt@goodmis.org>, <kirill@shutemov.name>,
        <brendanhiggins@google.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>
Subject: Re: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Date:   Wed, 29 Jan 2020 15:37:58 +0100
Message-ID: <20200129143758.896-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129125615.GQ14879@hirez.programming.kicks-ass.net> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D02UWC001.ant.amazon.com (10.43.162.243) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 13:56:15 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jan 28, 2020 at 01:00:33PM +0100, sjpark@amazon.com wrote:
> 
> > I worried whether it could be a bother to send the mail to everyone in the
> > section, but seems it was an unnecessary worry.  Adding those to recipients.
> > You can get the original thread of this patchset from
> > https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.com/
> 
> I read first patch (the document) and still have no friggin clue.

Do you mean the document has insufficient description only?  If so, could you
please point me me which information do you want to be added?


Thanks,
SeongJae Park

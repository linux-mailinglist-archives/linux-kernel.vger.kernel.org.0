Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2510F4A0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfFRMXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 08:23:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kNi3XQTa/+ngtDRDU/l4s27s4LRCp411GOAAso5qJSY=; b=F/I7R90ceFW+vmCgY+WJQOJbA
        pvhriAwL77+n2hr/V0SY5YVh+q6jxecKm0igOHx2o2ZXLcgUUe5AZaKu4Przn8gyt5lIOUx+H2PW2
        bTH+beQOHI67CgnkH7JxSkMQSzaD1zf440yUCztXudXE14U52SBXNbdnzu7ZNjw+4a4Q881/0VSOC
        Jr8HGqVj2tMSqEhghpDjzVTNXJETzsInnYJ9afOnarjb3mIQNb0D1cnnGFpGKTAHlkYAD9SWSpakD
        tiMq3I6gpclW9GBKx8lzKnrz+N/n1h9tPgX9kUf9vdaXWEFlvZvHT2mGOX04TofqkeYY9R4OJa2ho
        BQXbBINNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdD99-0004ua-Ho; Tue, 18 Jun 2019 12:23:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F8302076F70F; Tue, 18 Jun 2019 14:23:29 +0200 (CEST)
Date:   Tue, 18 Jun 2019 14:23:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH V4] perf: event preserve and create across cpu hotplug
Message-ID: <20190618122329.GE3419@hirez.programming.kicks-ass.net>
References: <1560337045-13298-1-git-send-email-mojha@codeaurora.org>
 <1560848091-15694-1-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560848091-15694-1-git-send-email-mojha@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 02:24:51PM +0530, Mukesh Ojha wrote:
> Perf framework doesn't allow preserving CPU events across
> CPU hotplugs. The events are scheduled out as and when the
> CPU walks offline. Moreover, the framework also doesn't
> allow the clients to create events on an offline CPU. As
> a result, the clients have to keep on monitoring the CPU
> state until it comes back online.
> 
> Therefore,

That's not a therefore. There's a distinct lack of rationale here. Why
do you want this?

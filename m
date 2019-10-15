Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1029FD71E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfJOJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 05:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfJOJOE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:14:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0FE9309BDBC;
        Tue, 15 Oct 2019 09:14:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id E5B9860BE2;
        Tue, 15 Oct 2019 09:14:01 +0000 (UTC)
Date:   Tue, 15 Oct 2019 11:14:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf list: Hide deprecated events by default
Message-ID: <20191015091401.GE10951@krava>
References: <20191015025357.8708-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015025357.8708-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 15 Oct 2019 09:14:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:53:57AM +0800, Jin Yao wrote:
> There are some deprecated events listed by perf list. But we can't remove
> them from perf list with ease because some old scripts may use them.
> 
> Deprecated events are old names of renamed events.  When an event gets
> renamed the old name is kept around for some time and marked with
> Deprecated. The newer Intel event lists in the tree already have these
> headers.
> 
> So we need to keep them in the event list, but provide a new option to
> show them. The new option is "--deprecated".
> 
> With this patch, the deprecated events are hidden by default but they can
> be displayed when option "--deprecated" is enabled.

not sure it's wise to hide them, because people will not read man page
to find --deprecated option, they will rather complain right away ;-)

how about to display them as another topic, like:

pipeline:
	...
uncore:
	...
deprecated:
	...

jirka

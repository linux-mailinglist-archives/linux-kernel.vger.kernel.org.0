Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE2DB0FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436676AbfJQPVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 11:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31019 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404818AbfJQPVE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:21:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBC5018CB91B;
        Thu, 17 Oct 2019 15:21:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id D4E8A19C70;
        Thu, 17 Oct 2019 15:21:01 +0000 (UTC)
Date:   Thu, 17 Oct 2019 17:21:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf list: Separate the deprecated events
Message-ID: <20191017152100.GC21168@krava>
References: <20191017135214.18620-1-yao.jin@linux.intel.com>
 <20191017144644.GV9933@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017144644.GV9933@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 17 Oct 2019 15:21:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:46:44AM -0700, Andi Kleen wrote:
> >  v2:
> >  ---
> >  In v1, the deprecated events are hidden by default but they can be
> >  displayed when option "--deprecated" is enabled. In v2, we don't use
> >  the new option "--deprecated". Instead, we just display the deprecated
> >  events under the title "--- Following are deprecated events ---".
> 
> It's redundant with what the event description already says.
> If we always want to show it we don't need to do anything.
> 
> I really would much prefer to hide it. What's the point of showing
> something that people are not supposed to use?
> 
> The only reason for keeping the deprecated events is to not
> break old scripts, but those don't care about perf list output.

I thought this might be a problem for users,
but don't have anything to back this up ;-)

if that's the case we can go with the original patch

jirka

> 
> So I think the only sane option is to hide it by default.
> 
> -Andi

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A16F1182
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfKFIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 03:55:20 -0500
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:55124 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbfKFIzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:55:20 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8824A180A68CB;
        Wed,  6 Nov 2019 08:55:18 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2902:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4362:5007:6261:7875:8660:9040:10004:10400:10848:10967:11232:11658:11914:12043:12291:12297:12683:12740:12760:12895:13069:13148:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21939:30054:30062:30064:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: shock61_4b3e606027b34
X-Filterd-Recvd-Size: 1995
Received: from grimm.local.home (unknown [94.155.134.143])
        (Authenticated sender: rostedt@goodmis.org)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Nov 2019 08:55:16 +0000 (UTC)
Date:   Wed, 6 Nov 2019 03:55:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: Re: [PATCH 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
Message-ID: <20191106035512.3ff7bc20@grimm.local.home>
In-Reply-To: <1573021660-30540-2-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1573021660-30540-1-git-send-email-piotrx.maziarz@linux.intel.com>
        <1573021660-30540-2-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 07:27:40 +0100
Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:

> Without this, buffers can be printed with __print_array macro that has
> no formatting options and can be hard to read. The other way is to
> mimic formatting capability with multiple calls of trace event with one
> call per row which gives performance impact and different timestamp in
> each row.
> 
> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>  include/linux/trace_events.h |  5 +++++
>  include/linux/trace_seq.h    |  4 ++++
>  include/trace/trace_events.h |  6 ++++++
>  kernel/trace/trace_output.c  | 15 +++++++++++++++
>  kernel/trace/trace_seq.c     | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+)
> 

I'd like to see in the patch series (patch 3?) a use case of these
added functionality. Or at least a link to what would be using it.

Thanks!

-- Steve

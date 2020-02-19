Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99285163B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 04:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBSDed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 22:34:33 -0500
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:44318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbgBSDed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:34:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8381F182CED2A;
        Wed, 19 Feb 2020 03:34:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:3874:4321:4605:5007:6120:7974:8660:10004:10400:10848:10967:11026:11232:11658:11914:12043:12294:12296:12297:12438:12679:12740:12760:12895:13148:13230:13439:14181:14659:14721:21080:21325:21451:21611:21627:30029:30054:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: eggs49_276b585518d5b
X-Filterd-Recvd-Size: 2918
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 03:34:30 +0000 (UTC)
Message-ID: <658fe8a43c01360813d11087ea974b12c02bb6b4.camel@perches.com>
Subject: Re: [RFC PATCH 0/2] trace: Move trace data to new section
 _ftrace_data
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 19:33:08 -0800
In-Reply-To: <20200218222615.713d542d@gandalf.local.home>
References: <cover.1582077698.git.joe@perches.com>
         <20200218215328.16744447@gandalf.local.home>
         <899e4e41c4cf5c62a4fbce0923e5796141ef46f0.camel@perches.com>
         <20200218222615.713d542d@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 22:26 -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2020 19:09:10 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > I don't care about the section name at all.
> > 
> > I used that name for consistency with _ftrace_event
> > in the same file. 
> > Perhaps the _ftrace_event section
> > name could be renamed to something
> > intelligible too.
> 
> Yes, that should probably get changed. That's a leftover when we just
> called everything "ftrace", but it should have been changed when I
> renamed the file from ftrace.h to trace_event.h.

Pick a name.

btw: it's not used in an x86-64 allmodconfig or defconfig
as an actual separate section as far as I tell.

$ git grep _ftrace_events
include/asm-generic/vmlinux.lds.h:                      __start_ftrace_events = .;                      \
include/asm-generic/vmlinux.lds.h:                      KEEP(*(_ftrace_events))                         \
include/asm-generic/vmlinux.lds.h:                      __stop_ftrace_events = .;                       \
include/linux/syscalls.h:         __attribute__((section("_ftrace_events")))                    \
include/linux/syscalls.h:         __attribute__((section("_ftrace_events")))                    \
include/trace/trace_events.h: * __section(_ftrace_events) *__event_<call> = &event_<call>;
include/trace/trace_events.h:static struct trace_event_call __used __section(_ftrace_events)            \
include/trace/trace_events.h:static struct trace_event_call __used __section(_ftrace_events)            \
kernel/module.c:        mod->trace_events = section_objs(info, "_ftrace_events",
kernel/trace/trace_events.c:extern struct trace_event_call *__start_ftrace_events[];
kernel/trace/trace_events.c:extern struct trace_event_call *__stop_ftrace_events[];
kernel/trace/trace_events.c:    for_each_event(iter, __start_ftrace_events, __stop_ftrace_events) {
kernel/trace/trace_export.c:static struct trace_event_call * __used __section(_ftrace_events)   \



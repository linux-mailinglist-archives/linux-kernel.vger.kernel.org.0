Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5844ACEBCE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfJGS3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 14:29:00 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:46744 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728031AbfJGS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:28:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 190F9182251CC;
        Mon,  7 Oct 2019 18:28:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:7903:8985:9025:10004:10400:11232:11658:11914:12043:12114:12297:12346:12555:12740:12760:12895:12986:13069:13255:13311:13357:13439:14181:14659:14721:21080:21433:21627:21811:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: neck58_87ecfa613314b
X-Filterd-Recvd-Size: 2424
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 18:28:53 +0000 (UTC)
Message-ID: <0e5abed9afe267155cc8601d0fd7fdaa63883920.camel@perches.com>
Subject: Re: [PATCH 2/4] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 07 Oct 2019 11:28:53 -0700
In-Reply-To: <CAKwvOdkVZ64sLppKxF1XRgarPmCbhw1WLsSq1VcV1tagPgWtUg@mail.gmail.com>
References: <cover.1570292505.git.joe@perches.com>
         <79237afe056af8d81662f183491e3589922b8ddd.1570292505.git.joe@perches.com>
         <CANiq72kU2_s=58HqdN6VMGDAh_+G+dtns9xzoc4huSVwP+ZXUg@mail.gmail.com>
         <CAKwvOdkVZ64sLppKxF1XRgarPmCbhw1WLsSq1VcV1tagPgWtUg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 11:14 -0700, Nick Desaulniers wrote:
> > On Sat, Oct 5, 2019 at 6:46 PM Joe Perches <joe@perches.com> wrote:
> > > Reserve the pseudo keyword 'fallthrough' for the ability to convert the
> 
> Have we precedent already for "pseudo keywords?"

Many.  see bool vs _Bool, u32 vs uint32_t, etc.

> I kind of like the
> double underscore prefix we use for attributes (which this is one of),

Linus apparently (and rightly IMO) prefers
fallthrough over __fallthrough.

https://lore.kernel.org/lkml/201909161516.A68C8239A@keescook/



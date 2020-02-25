Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A1B16F2E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 00:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgBYXEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 18:04:15 -0500
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:37452 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729090AbgBYXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:04:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 01AFD181D341A;
        Tue, 25 Feb 2020 23:04:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2689:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3870:4321:5007:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12683:12740:12760:12895:13069:13311:13357:13439:14110:14659:14721:21080:21451:21611:21626:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brake21_7beb87a1c190d
X-Filterd-Recvd-Size: 1650
Received: from XPS-9350 (unknown [172.58.27.58])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 23:04:11 +0000 (UTC)
Message-ID: <37831d22bd91f9694f7b35be158969fb997cc544.camel@perches.com>
Subject: Re: [PATCH] tools/perf/util/*.c: Use "%zd" output format for size_t
 type
From:   Joe Perches <joe@perches.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Date:   Tue, 25 Feb 2020 15:02:39 -0800
In-Reply-To: <20200225063901.20165-1-yangx.jy@cn.fujitsu.com>
References: <20200225063901.20165-1-yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 14:39 +0800, Xiao Yang wrote:
> Avoid the following errors when building perf:
> -----------------------------------------------
> util/session.c: In function 'perf_session__process_compressed_event':
> util/session.c:91:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
>   pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
[]
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
[]
> @@ -88,7 +88,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  		session->decomp_last = decomp;
>  	}
>  
> -	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
> +	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);

likely better as %zu, etc...



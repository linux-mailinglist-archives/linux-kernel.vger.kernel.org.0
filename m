Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E773817D104
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 04:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgCHDUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 22:20:45 -0500
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:39390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbgCHDUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 22:20:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E3356180A5B05;
        Sun,  8 Mar 2020 03:20:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3876:3877:4321:5007:6114:6642:6742:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: night89_5d7274ac97a01
X-Filterd-Recvd-Size: 1736
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 03:20:42 +0000 (UTC)
Message-ID: <bfc9f9b69681c3ef285bf11b6506fa5b42b5917a.camel@perches.com>
Subject: Re: [PATCH] mm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Date:   Sat, 07 Mar 2020 19:19:04 -0800
In-Reply-To: <20200308031634.GA1125@jagdpanzerIV.localdomain>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
         <20200308031634.GA1125@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 12:16 +0900, Sergey Senozhatsky wrote:
> On (20/03/06 23:58), Joe Perches wrote:
> [..]
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -424,7 +424,7 @@ static void *zs_zpool_map(void *pool, unsigned long handle,
> >  	case ZPOOL_MM_WO:
> >  		zs_mm = ZS_MM_WO;
> >  		break;
> > -	case ZPOOL_MM_RW: /* fall through */
> > +	case ZPOOL_MM_RW:
> >  	default:
> >  		zs_mm = ZS_MM_RW;
> >  		break;
> 
> Seems like missing fallthrough; for ZPOOL_MM_RW?

Consecutive case labels do not need an interleaving fallthrough



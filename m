Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECB3175B54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 14:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCBNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 08:11:32 -0500
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:45496 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727334AbgCBNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:11:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E6E32B2BE;
        Mon,  2 Mar 2020 13:11:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:4321:5007:7903:10004:10400:10848:11026:11232:11473:11658:11914:12048:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21611:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: teeth95_644aa53c30800
X-Filterd-Recvd-Size: 2034
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Mar 2020 13:11:29 +0000 (UTC)
Message-ID: <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to
 copy_from_user()
From:   Joe Perches <joe@perches.com>
To:     glider@google.com, tkjos@google.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, arve@android.com, mingo@redhat.com
Cc:     dvyukov@google.com, jannh@google.com, devel@driverdev.osuosl.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 05:09:58 -0800
In-Reply-To: <20200302130430.201037-2-glider@google.com>
References: <20200302130430.201037-1-glider@google.com>
         <20200302130430.201037-2-glider@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> Certain copy_from_user() invocations in binder.c are known to
> unconditionally initialize locals before their first use, like e.g. in
> the following case:
[]
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
[]
> @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
>  
>  		case BC_TRANSACTION_SG:
>  		case BC_REPLY_SG: {
> -			struct binder_transaction_data_sg tr;
> +			struct binder_transaction_data_sg tr __no_initialize;
>  
>  			if (copy_from_user(&tr, ptr, sizeof(tr)))

I fail to see any value in marking tr with __no_initialize
when it's immediately written to by copy_from_user.

>  				return -EFAULT;
> @@ -3799,7 +3799,7 @@ static int binder_thread_write(struct binder_proc *proc,
>  		}
>  		case BC_TRANSACTION:
>  		case BC_REPLY: {
> -			struct binder_transaction_data tr;
> +			struct binder_transaction_data tr __no_initialize;
>  
>  			if (copy_from_user(&tr, ptr, sizeof(tr)))

etc...



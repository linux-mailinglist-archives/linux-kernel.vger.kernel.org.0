Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C2153B73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBEWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:52:14 -0500
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:52144 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727722AbgBEWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:52:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C02BD3AB6;
        Wed,  5 Feb 2020 22:52:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:966:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2525:2553:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:4385:4605:5007:7903:9025:10004:10400:10848:11026:11232:11233:11658:11914:12043:12048:12262:12297:12438:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21365:21451:21611:21627:21740:21811:21939:30012:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: order36_1316b577d5b11
X-Filterd-Recvd-Size: 2066
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Feb 2020 22:52:11 +0000 (UTC)
Message-ID: <5a14078affad5e26330627d91df394da990ba301.camel@perches.com>
Subject: Re: [PATCH] drm: Add missing newline after comment
From:   Joe Perches <joe@perches.com>
To:     Stefan Agner <stefan@agner.ch>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel.vetter@ffwll.ch
Cc:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Wed, 05 Feb 2020 14:50:59 -0800
In-Reply-To: <586aab08af596120f48858005bb6784c83035d59.1580941448.git.stefan@agner.ch>
References: <586aab08af596120f48858005bb6784c83035d59.1580941448.git.stefan@agner.ch>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 23:26 +0100, Stefan Agner wrote:
> Clang prints a warning:
> drivers/gpu/drm/drm_lock.c:363:6: warning: misleading indentation;
> statement is not part of the previous 'if' [-Wmisleading-indentation]
>          */     mutex_lock(&dev->struct_mutex);
>                 ^
> drivers/gpu/drm/drm_lock.c:357:2: note: previous statement is here
>         if (!drm_core_check_feature(dev, DRIVER_LEGACY))
>         ^
> 
> Fix this by adding a newline after the multi-line comment.

Thanks, already in -next

commit 5b99cad6966b92f757863ff9b6688051633fde9a
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed Jan 8 08:43:12 2020 +0300

    gpu/drm: clean up white space in drm_legacy_lock_master_cleanup()
    
    We moved this code to a different file and accidentally deleted a
    newline.
    
    Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
    Link: https://patchwork.freedesktop.org/patch/msgid/20200108054312.yzlj5wmbdktejgob@kili.mountain



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728D310A67A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 23:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKZWVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 17:21:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfKZWVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:21:45 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D53CB20678;
        Tue, 26 Nov 2019 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574806904;
        bh=oQw7FcwOKOaJY05Uo2S4Tg3LlfwSBCGmMqmL8YvEBfI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ax3NZIf/cdbc5clChODZcsz5lgHLdenRqZkKUvKDOcfT2PL9C7lC7NNaSstz6Qerl
         KKYzZrCUO+uH2BpjJ3K9GwWNZrOeG8G4A+nLsSfjqYhGwTMSEEBEerQY5uxILrBC9R
         OiS4lDVgzCXAdyse+s/yfOI6iieWja/FxtqBVUqI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9590835227AB; Tue, 26 Nov 2019 14:21:44 -0800 (PST)
Date:   Tue, 26 Nov 2019 14:21:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     corbet@lwn.net, will@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/7] docs: Update ko_KR translations
Message-ID: <20191126222144.GW2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191121234125.28032-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121234125.28032-1-sj38.park@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:41:18AM +0100, SeongJae Park wrote:
> This patchset contains updates of Korean translation documents and a fix
> of original document.
> 
> First 4 patches update the Korean translation of memory-barriers.txt.
> Fifth patch fixes a broken section reference in the original
> memory-barriers.txt.
> 
> Sixth and seventh patches update the Korean translation of howto.rst.

The sixth and seventh probably have some other more natural path,
but I queued them.  Any chance of a Reviewed-by from one of our other
Korean-language kernel hackers?

							Thanx, Paul

> *** BLURB HERE ***
> 
> SeongJae Park (7):
>   docs/memory-barriers.txt/kokr: Rewrite "KERNEL I/O BARRIER EFFECTS"
>     section
>   Documentation/kokr: Kill all references to mmiowb()
>   docs/memory-barriers.txt/kokr: Fix style, spacing and grammar in I/O
>     section
>   docs/memory-barriers.txt/kokr: Update I/O section to be clearer about
>     CPU vs thread
>   docs/memory-barriers.txt: Remove remaining references to mmiowb()
>   Documentation/translation: Use Korean for Korean translation title
>   Documentation/process/howto/kokr: Update for 4.x -> 5.x versioning
> 
>  Documentation/memory-barriers.txt             |  11 +-
>  Documentation/translations/ko_KR/howto.rst    |  56 +++--
>  Documentation/translations/ko_KR/index.rst    |   4 +-
>  .../translations/ko_KR/memory-barriers.txt    | 227 +++++++-----------
>  4 files changed, 119 insertions(+), 179 deletions(-)
> 
> -- 
> 2.17.2
> 

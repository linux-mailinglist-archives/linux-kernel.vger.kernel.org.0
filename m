Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2B336D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfFCRfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 13:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfFCRfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:35:12 -0400
Subject: Re: [GIT PULL] nds32 patches for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559583312;
        bh=EmOdwOqdPNBlgSiiWTxmL20CuHjHK8XBdr01UnETDHo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pGXTs4zvYy6j5zZOBEJjtUf/pZxiJFnOCeGzoA9OvBGFumrk7KmHMYU6+WB8JP/FY
         TvVFQcZdrTDfEOd++6IFK1PkkPh0VcIdpgv1YN5llcCm9hDYGxOdadAKTGNvRmEeWT
         pJqb4r//6OFHPxlB/Tj07UaAyJyMVMVpsQYiTDSk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAEbi=3eRJMkGUT-H=Tts8A+Lju_CuYDbKpP+ofD1GVMM_1P05A@mail.gmail.com>
References: <CAEbi=3eRJMkGUT-H=Tts8A+Lju_CuYDbKpP+ofD1GVMM_1P05A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAEbi=3eRJMkGUT-H=Tts8A+Lju_CuYDbKpP+ofD1GVMM_1P05A@mail.gmail.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
 tags/nds32-for-linux-5.2-rc3
X-PR-Tracked-Commit-Id: 932296120543149e3397af252e7daee7af37eb05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30d1d92a888d03681b927c76a35181b4eed7071f
Message-Id: <155958331231.6762.11217275132125938542.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jun 2019 17:35:12 +0000
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jun 2019 21:58:42 +0800:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linux-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30d1d92a888d03681b927c76a35181b4eed7071f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

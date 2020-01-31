Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1BA14F398
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 22:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgAaVKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 16:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgAaVKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:10:15 -0500
Subject: Re: [GIT PULL] GFS2 changes for the 5.6 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580505015;
        bh=iba5F50V90G+dlH4PwC+j6dEvijazd05NJfliKOC/ac=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UySml0yThgq5MWl8jx7V5iIwE0i27jI0cYlkqUT+CneQe0MdG0EDgvIo7h6DsDhqE
         Su04gPctpWyrs1wR3o1Yu/ZgeiXzaszrfUa3Nk2Y67DrOqdlF7X8HXl/+svQYXTeGl
         T4g6wPLxIEmST7kygR9qXPkbFytgiEMh1tVU5CLo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131154823.30363-1-agruenba@redhat.com>
References: <20200131154823.30363-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131154823.30363-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-for-5.6
X-PR-Tracked-Commit-Id: a31b4ec539e966515f1f97f4000d0e2a399930ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a62aa6f7f50a9a0af5e07d98774f8a7b439d390f
Message-Id: <158050501536.4115.8230409088114911082.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 21:10:15 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 16:48:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a62aa6f7f50a9a0af5e07d98774f8a7b439d390f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

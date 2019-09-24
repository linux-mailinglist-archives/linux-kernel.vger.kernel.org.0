Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983B3BBFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 03:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392612AbfIXBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 21:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388857AbfIXBZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:25:24 -0400
Subject: Re: [GIT PULL] Smack patches for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569288323;
        bh=RTBIkV8Ln/WwqAEQWqooPniHxtNFp5/G5rR7rAAk/3g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r+YflSVjI7VQx/lY3355EvodQct5eDrML+CP/ICojjxtg6FXuKVuqNH+nOvjQ8pQy
         jMfLLLD3vGeP1PiQo/tIWdyOtZh1uGRzllnAI8U3m6oXVFMU2jcSMg7NmMVKd5Cyzn
         L3q9Kyki5bo9YpcGsPXRLOWrc/3wGQGnaYaZXEwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
References: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next.git smack-for-5.4
X-PR-Tracked-Commit-Id: e5bfad3d7acc5702f32aafeb388362994f4d7bd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e94f8ccde4710f9a3e51dd3bc6134c96e33f29b3
Message-Id: <156928832348.12932.6115301261032637406.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 01:25:23 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 Sep 2019 10:24:21 -0700:

> https://github.com/cschaufler/smack-next.git smack-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e94f8ccde4710f9a3e51dd3bc6134c96e33f29b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

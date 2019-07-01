Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA93211FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 04:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfEQCZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 22:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfEQCZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:25:23 -0400
Subject: Re: [GIT PULL] cgroup fix for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558059922;
        bh=EyOVpBGb2xQrzM0KKtaYF1rXCIifN2J4zZJ+WcvC3i4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2r6V8apmT25NmwSI2WqP3gDQSPKwgj4eP5+UcEh2THZU6H/cq8NtuGf4L/d/plHMY
         T4uPGFFk9XGz9XhXrLtj9P5e/ZH4YSUklj89T+tm3oyKivb3T//QfEEFF6v9pD08Yy
         xltYXQDjMOiXXOb98D/jrhhe5eDoEvP3DKBO1T1E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516223752.GE374014@devbig004.ftw2.facebook.com>
References: <20190516223752.GE374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516223752.GE374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2-fixes
X-PR-Tracked-Commit-Id: 05b289263772b0698589abc47771264a685cd365
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f3ab27b9eb7f1b97e6d4460ac4e494588e09f0c
Message-Id: <155805992272.6110.15306204735351185312.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 02:25:22 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Oleg Nesterov <oleg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 15:38:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f3ab27b9eb7f1b97e6d4460ac4e494588e09f0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

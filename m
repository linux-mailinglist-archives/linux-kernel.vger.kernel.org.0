Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED1B67580
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 21:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfGLTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 15:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfGLTpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 15:45:11 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562960710;
        bh=1QqbemreydjIz63S14gMZpafF/H+Kf3VrNIwXMXXTag=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U9qcnNGeUmVRewkiQc9bxmJAVm/8HMpYm/MIgL0uRTUD7YOxXECM+iQPxc5H0fdep
         7mwU47yHDZTpCLZRJizDIyxaYZT/GLl6HyCpay1a5F5hSykXrUnFRA3ucPKohzUqnp
         uxDoT8L9gXWgYJYMcaAj9arPYu2QntHNX1RLIo1c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712073623.GA16253@kroah.com>
References: <20190712073623.GA16253@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712073623.GA16253@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.3-rc1
X-PR-Tracked-Commit-Id: c33d442328f556460b79aba6058adb37bb555389
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f632a8170a6b667ee4e3f552087588f0fe13c4bb
Message-Id: <156296071064.25412.1083376525972231634.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Jul 2019 19:45:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 09:36:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f632a8170a6b667ee4e3f552087588f0fe13c4bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

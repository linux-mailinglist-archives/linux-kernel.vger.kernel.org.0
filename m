Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D803B16F21
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 04:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEHCkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 22:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfEHCkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:40:12 -0400
Subject: Re: [GIT PULL] SELinux patches for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557283212;
        bh=u2GBr45b52Owzs2YuLYw9iZjMpSuRVKRcqQ735BO2/w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xAPew/dfvA6gSL/Z1gXsrqKtPFFw7dlVLzVKnuvOAmIbaQxcMn4fS26WWQnrytY95
         /Hqn42rGB/cioBS/Xn/k5ASsDe3vSE4DWZb0P/ahZTRNMdhI8RIw1625bx3Pv9V3Rx
         3wBlhgQ23jTWrL3OVw44fkpsMJ4jU0VYxCFeFefU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSkOmRGvOje3HycoauPL+ZW9g9zZ3dqiPDmQTPUPnhCPg@mail.gmail.com>
References: <CAHC9VhSkOmRGvOje3HycoauPL+ZW9g9zZ3dqiPDmQTPUPnhCPg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhSkOmRGvOje3HycoauPL+ZW9g9zZ3dqiPDmQTPUPnhCPg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20190507
X-PR-Tracked-Commit-Id: 35a196bef449b5824033865b963ed9a43fb8c730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f72dae20891d7bcc43e9263ab206960b6ae5209f
Message-Id: <155728321226.19924.13180646017168860982.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 02:40:12 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 13:23:03 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20190507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f72dae20891d7bcc43e9263ab206960b6ae5209f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

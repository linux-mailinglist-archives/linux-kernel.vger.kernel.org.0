Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93EB1AE53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 00:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfELWZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 18:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfELWZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 18:25:13 -0400
Subject: Re: [GIT PULL] UML changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557699913;
        bh=RC/SFlx7pUbr2aKhL4Qp9KVW6/GsSP/cHWqzfSXiEmM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OYlesAXjP5WgQ6rWpenReliwyxNAwioEGooqA8ISK+Y1W7Lrm47rwel6Mf66r2os6
         RVrLw3rgQ7ggOC9MUGwPqMwu44E+uYRFXB3rLdTppPggu3HN6gBCmGmjGEacB1Q0Tl
         9/7WAQtZ6PsJXYr3MRrPzgRt40H17LUtCbe/OQHg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1836274340.56055.1557697309728.JavaMail.zimbra@nod.at>
References: <1836274340.56055.1557697309728.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1836274340.56055.1557697309728.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 tags/for-linus-5.2-rc1
X-PR-Tracked-Commit-Id: 1987b1b8f9f17a06255877e7917d0bb5b5377774
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 983dfa4b6ee556563f7963348e4e2f97fc8a15b8
Message-Id: <155769991315.32032.11407094999268511120.pr-tracker-bot@kernel.org>
Date:   Sun, 12 May 2019 22:25:13 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 May 2019 23:41:49 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/983dfa4b6ee556563f7963348e4e2f97fc8a15b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

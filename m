Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52AC71A258
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfEJRfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 13:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfEJRfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:35:13 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557509713;
        bh=3iDpQ0zrwJ51S/xQVUe7au2ThKA46IuvuXI7x+yUDLc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F7SDZPz3Ijnn68B//wBIrNQAEroaDl8Xszir5wTJjSkK/5a3gfRxXWyOG7SbyFEkM
         BAJO6SrNQd0yy+RUP9itbJORDizd/uOXkfJIdybSQPFc7Xnqpwvu6Bha/f9AnkQPFR
         F9VceTOcp0ceRuem1U/V+9bNBupMzMVVNjeIIqbI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2cJiXMVaPX+r7TS_mFa=o-dj9HEOjZ2+8GEbs8kUX1Xw@mail.gmail.com>
References: <CABb+yY2cJiXMVaPX+r7TS_mFa=o-dj9HEOjZ2+8GEbs8kUX1Xw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2cJiXMVaPX+r7TS_mFa=o-dj9HEOjZ2+8GEbs8kUX1Xw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v5.2
X-PR-Tracked-Commit-Id: 8fbbfd966efa67ef9aec37cb4ff412f9f26e1e84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15500c0a506e256976a81c858e33844bb0781e02
Message-Id: <155750971311.27249.14786266789867232105.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 17:35:13 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 02:30:42 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15500c0a506e256976a81c858e33844bb0781e02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

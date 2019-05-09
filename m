Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A119019516
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 00:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfEIWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 18:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbfEIWPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:15:19 -0400
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557440118;
        bh=BQobdt6CAD9lHDDvfoBIYnw9dhCRJcfjmwNu8OSy7H0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EXm7cFQscv9XNdTN1QC/UXcNAZ0arl270HZbyz2WX8Zo2BgR2NQ97BC65HGAzeSOw
         rjVgYi0OuJjy6MjPjO4sZvD/ESf5AYQWqdSO4I7UHhrpKORVoBOtOfznYgiPfNGn6B
         KKJvLoftmattMJ60YMEv/3VRlDNGcqjnqHO6TuC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509.143531.499657137828123463.davem@davemloft.net>
References: <20190509.143531.499657137828123463.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509.143531.499657137828123463.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: f4d9a23d3dad0252f375901bf4ff6523a2c97241
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b6c9e96f941c5ab13dad7278a3622f58e5672fc
Message-Id: <155744011853.23477.16345216067726345740.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 22:15:18 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 May 2019 14:35:31 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b6c9e96f941c5ab13dad7278a3622f58e5672fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

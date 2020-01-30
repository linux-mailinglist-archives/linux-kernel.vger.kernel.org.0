Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6514E05E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 19:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgA3SA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 13:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbgA3SAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:23 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407223;
        bh=R/nIrE0xwV5wbpf9YeNLK0ex8wz/xZv2iwgrKi0gigw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jwa7EwZ7OPIOQUVOcKkuQS3nYtyE2Y2t4i0PT5cSMM/+MJj2Fdd3f5pv0wUWzChjV
         GyJ3jCwlUvQcCH+JUC6+q1EeMkk7ESFrunN8R9d+oM/a9JfYCb+zCv/dM9Cf1VGpeg
         lxBSFf87wZqIjZKqxEophj3ybEivbhWpgDPXAEjY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130.154123.1710430183269161404.davem@davemloft.net>
References: <20200130.154123.1710430183269161404.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130.154123.1710430183269161404.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 9fbf082f569980ddd7cab348e0a118678db0e47e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c715a659a16e193a23051ddff4becdad8e18ba1
Message-Id: <158040722339.2766.7207116743416320389.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:23 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 15:41:23 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c715a659a16e193a23051ddff4becdad8e18ba1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

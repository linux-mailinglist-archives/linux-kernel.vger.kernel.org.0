Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20D14E05C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgA3SAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 13:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbgA3SAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:00:20 -0500
Subject: Re: [GIT] IDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580407219;
        bh=TVVDERnbLki7svyKzOyarGVOuHHjFwqBLbk8pS/iIKM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=08aifFAukUW0CWZ7A+kr2tcJsnlEQpYEddSH0PEpqzdrWTQlXMgDQUtU6D7+MrhMg
         l41f4zFTBCUNuDC/uYNbk3oaFhJNl+wcdUvXyQbWDKF9yktI8IQup3HO57lDgqyL9n
         hyYNkFJvEq0u4mHg+jJqzJjqtNOmNSJdRiALjnmI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200130.110713.2121058244629085751.davem@davemloft.net>
References: <20200130.110713.2121058244629085751.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200130.110713.2121058244629085751.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master
X-PR-Tracked-Commit-Id: 2fd3c5c617937cde5aafa48db4f4056e1f705987
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e237e8c77279a0873a5e9806a5459ebc840c9ce
Message-Id: <158040721985.2766.17217644178676220349.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 18:00:19 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jan 2020 11:07:13 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e237e8c77279a0873a5e9806a5459ebc840c9ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

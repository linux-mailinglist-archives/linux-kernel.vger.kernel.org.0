Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9014F306
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgAaUFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 15:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgAaUFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:05:14 -0500
Subject: Re: [GIT PULL] Modules updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580501113;
        bh=KesAKAcsZ1VwpuMvCZ1E07I3z4KoXgI09eGHQ2msyRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bMiccVZF+0lBAh5VNaBtPg7icbnlf7izN6rYlfTChBXnBBBLscLiwWYBj7j59E4MU
         xOzMBbP8IN1EBxUioD+m7grE8UEHz/35nZ4fPvJJBeJyAnMMEEOLtRqZjiei7tTzHh
         Et6cd1QUdQbvon2444Wwq7PR5Var0uHT93+HFxEw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131172319.GA16783@linux-8ccs>
References: <20200131172319.GA16783@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131172319.GA16783@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.6
X-PR-Tracked-Commit-Id: 6080d608eeff7cb5090a2ddbaf723bfb0ff133fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddaefe8947b48b638f726cf89730ecc1000ebcc3
Message-Id: <158050111376.11349.17356570730316749692.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 20:05:13 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 18:23:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddaefe8947b48b638f726cf89730ecc1000ebcc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

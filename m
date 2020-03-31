Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0382C19A22D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 01:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgCaXAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 19:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgCaXAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 19:00:14 -0400
Subject: Re: [GIT PULL] Security subsystem updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585695614;
        bh=rQveBukJRrxsN9RgjHZvRoDCoJiJ5F6f61zIAiKMSBg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=boPcL6j7jGTZgSINfKeYDbk8q1u99R3qHoc5c9hpLuSSve7llzFyBxZ8NvVlph4Yn
         QvPBN14b7CExM8b7/tpSld/k7wfMhRItxCK4Ii7naAKU2pS4TvDMTDVkPokDye2j8C
         oian9FO/tO61EFYSO7AI6GUfoOy4cNVP1X1fuyRs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.2004010936310.15848@namei.org>
References: <alpine.LRH.2.21.2004010936310.15848@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.2004010936310.15848@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security
 next-general
X-PR-Tracked-Commit-Id: 3e27a33932df104f4f9ff811467b0b4ccebde773
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a16298439bd5469d89ec0e575e1c26e7b9a8178a
Message-Id: <158569561414.19383.16918938223645880841.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 23:00:14 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 09:38:36 +1100 (AEDT):

> git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-security next-general

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a16298439bd5469d89ec0e575e1c26e7b9a8178a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB81606A7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 22:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBPVKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 16:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPVKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 16:10:18 -0500
Subject: Re: [GIT PULL] IPMI bug fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581887418;
        bh=zRJ9f5umV6ieTK530YJ6FMkXa5tTm3dOjtwbPTng79M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=szG5xPEmSFePtISxuNmT3FZuLmpqMqou1VXlo8JQE4lnzcKa/n1ndf8o2KcNRjBjP
         HOCc29SbXFEgn7pO8PSjxP3Iy2Vr4HzNXmgbxVCR7+dHf36qHILpJGE+ui/CmHVK82
         QPTi0jNZ1e/xTO+/L31lvQLE5wQxpTW+ymJXVKDw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200211001836.GI7842@minyard.net>
References: <20200211001836.GI7842@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200211001836.GI7842@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.6-1
X-PR-Tracked-Commit-Id: e0354d147e5889b5faa12e64fa38187aed39aad4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab02b61f24c76b1659086fcc8b00cbeeb6e95ac7
Message-Id: <158188741828.12275.17520604145616390715.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Feb 2020 21:10:18 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Feb 2020 18:18:36 -0600:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab02b61f24c76b1659086fcc8b00cbeeb6e95ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8611F63C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfGITzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfGITzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:55:09 -0400
Subject: Re: [GIT PULL] LSM: capabilities updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562702109;
        bh=p8McqkZPbJMafKOclnSs3qGsZajsOXS/ra5BNJGRfnw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ISxjqDyrk1nojQDLvDQlB7BRJhFDhHYMOoMhUsun1dTas4TkFEQsbCjaP24eXLobz
         kzQTe4dOn78x3vkugFiRlJpMnm1p5iWzDhSY6ctk6Esvxr0gRf4anQ0ONY1P5sdP3r
         jHK6YFbDtx/hwn9wLjSWw7g15bB6+xWA2Pylk/xg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1907090427070.13953@namei.org>
References: <alpine.LRH.2.21.1907090427070.13953@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1907090427070.13953@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-lsm
X-PR-Tracked-Commit-Id: c5eaab1d131d0a6272df7d55a971a67400d63f56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d22167f34305280c5dd57a74c21651da3c23015
Message-Id: <156270210912.21525.4158654088652904074.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 19:55:09 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 04:32:39 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lsm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d22167f34305280c5dd57a74c21651da3c23015

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

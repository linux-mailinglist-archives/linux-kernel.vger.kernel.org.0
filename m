Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7323815270C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 08:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBEHfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 02:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgBEHfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:35:04 -0500
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580888104;
        bh=DxGrXlF0Xw+rWXtckYXPk0C8anbhJB6STJjrDypSdvg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y1J3ipZzfPNxO388MJYjKWw8iGNwW52vvpUNwb9EJaJWCd3kVsr7RQBhLfnxGn1aB
         CtjfLuchPAQGxe4HeqzgL/7lmtY2hSRH4G9Cl9D4LX2CejzvJ1lXPdHOVCt/6nhu09
         iS9P6rPMNWec47cQIiMNZKdADXjsRhuK3FXMHEI4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205070604.GA11613@ls3530.fritz.box>
References: <20200205070604.GA11613@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205070604.GA11613@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.6-1
X-PR-Tracked-Commit-Id: 84669923e1edf30f55e71fce9f831242502372c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6992ca0dd017ebaa2bf8e9dcc49f1c3b7033b082
Message-Id: <158088810425.30437.1803267607407340432.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 07:35:04 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 08:06:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6992ca0dd017ebaa2bf8e9dcc49f1c3b7033b082

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

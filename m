Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46CF168FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfEGRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfEGRUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:20:09 -0400
Subject: Re: [GIT PULL] Security subsystem: general updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249608;
        bh=KkJlf7VBOYLIp2BJ7v+Ugggdywbfl7gTZzDwmBxXYRw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VwZIRSLs6GOtqnrihfVMNQVIypQw3N5rGkvsI4sRqQ8PfElRymEIIUNC3t/Swg/Dx
         33xGBigvd/Fafe7+kGYhghxnb7/nx1e0P88XMs3EtoTR2vANT3GdswBRJMRrw/7gAA
         1Em3qee3pECciPCmWX4NIQshkCiyD+W/jGlME9QM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1905071333580.5714@namei.org>
References: <alpine.LRH.2.21.1905071333580.5714@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1905071333580.5714@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 next-general
X-PR-Tracked-Commit-Id: 6beff00b79ca0b5caf0ce6fb8e11f57311bd95f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78ee8b1b9b2fa1b51c51c42f3cffa0e12ad5f0ab
Message-Id: <155724960854.23705.6925791491708118672.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:20:08 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 13:35:39 +1000 (AEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78ee8b1b9b2fa1b51c51c42f3cffa0e12ad5f0ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

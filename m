Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CC156C6B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 21:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBIUkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 15:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgBIUkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:40:24 -0500
Subject: Re: [GIT pull] time(r) fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581280823;
        bh=mRKITbRJYS3WbLsQ208lL4Rchb0mDdsBRA10fXKV/y8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NabRqbM+vJQCBkYnXP8ST9t4XTtlNekYJyUT5Gn50Pov5xwlRiOr0k9uV2IO+rvZF
         C94Vw0nQedV1wpqIM70oLQmIuGMvgHx42T0j20HFxnUeD9lF0G/5zROi7vTW6HY8Os
         6saLOCYMcRX2V40aZWihXlEsJPangQxP6nvmVqCU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158125695732.26104.9630376117953711880.tglx@nanos.tec.linutronix.de>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.9630376117953711880.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158125695732.26104.9630376117953711880.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-02-09
X-PR-Tracked-Commit-Id: febac332a819f0e764aa4da62757ba21d18c182b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fbc23c738350f1a47007da7ad92ae2e4ea63951
Message-Id: <158128082362.31187.13632616836856187091.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 20:40:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Feb 2020 14:02:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fbc23c738350f1a47007da7ad92ae2e4ea63951

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

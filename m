Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4B66107
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfGKVPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 17:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfGKVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:15:09 -0400
Subject: Re: [GIT pull] core/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562879708;
        bh=Y/o72BhLin7wKyl6QOmk5iKhGqxURtOUiohTxPH1RV4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rVvyX/wJa0tvfguNU0mMmJwtDs9bWG0PSbkAHsU/jonF8lXL17Q3ZhZCQlslqzIcp
         4tAO+ti3fn9SOFaao4g7iEor59v6IqVBEUfMrrvhkM8uhyhTUWOFnFRbR+BiCCZFLA
         0ggB33la98E6ezQJQ6aKDL7bjnPWeMUFsycasf5g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 7e8e6816c6495a1168f9a7a50125d82c23e59300
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02150fab6ae9924ef03e21a15f2d5f7415a9cdf7
Message-Id: <156287970841.8575.3777016484102552467.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 21:15:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 20:02:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02150fab6ae9924ef03e21a15f2d5f7415a9cdf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

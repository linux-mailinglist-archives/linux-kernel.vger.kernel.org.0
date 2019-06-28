Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05F58F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 02:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF1AzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 20:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfF1AzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:55:04 -0400
Subject: Re: [GIT PULL] fixes for v5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561683303;
        bh=AeykGisETI19pMTMY7Y0ctoaJTVvUm9DspONR5Tte4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DwUktA+HC2hC4FnxRIDud/FykKoMb8mMajyc+rQuc5DsE4+ClRVLEyoRu56sxZZz/
         AgacqhE8+3QGyH9FHZLEWfJ7nxfPUU3QzoI7OtHadShdLAlusmb8wpjN4QvHgosSOK
         QA4bjLLvNTnawBcTi4MZt5O5wCXXzWkNqJPKgIoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190627112430.6590-1-christian@brauner.io>
References: <20190627112430.6590-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190627112430.6590-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190627
X-PR-Tracked-Commit-Id: 30d158b143b6575261ab610ae7b1b4f7fe3830b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a702b4e82d8730d6964bfd98b3b024c126e9846
Message-Id: <156168330366.8716.3052438043309398771.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:55:03 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ldv@altlinux.org, viro@zeniv.linux.org.uk, jannh@google.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jun 2019 13:24:30 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190627

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a702b4e82d8730d6964bfd98b3b024c126e9846

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

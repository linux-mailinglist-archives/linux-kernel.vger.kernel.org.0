Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29293111BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 23:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfLCWZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 17:25:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfLCWZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:25:20 -0500
Subject: Re: [GIT PULL] SPDX fix for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575411919;
        bh=tF5czheHaqvgSYr3wgP2trCYzcTTvvS5A+gjSVwzK8c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A0NDGQ9FgjKg0Zth8Pxj11N3Kwulk0BtoUrWG2AIcKzZWqcpiHhA42jYNKCYikLGh
         Cmh4iy/2FhbfPoSzHqD7+vv2nlalfa0nPC4l+02+BIoW9ANno5ue9+Bx5LfP+Qx1IX
         vpw3gWOp0nt6buKxL+vND4hXCYxEDTavmwxtKnY0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203203711.GA3189820@kroah.com>
References: <20191203203711.GA3189820@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203203711.GA3189820@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
 tags/spdx-5.5-rc1
X-PR-Tracked-Commit-Id: bf49d9dd6fef688733e2ddbd55f7bcb57df194e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 388c645a33a739bb96aa5ffe283ec68786ea7890
Message-Id: <157541191988.11917.3482716950500609195.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 22:25:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 21:37:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/388c645a33a739bb96aa5ffe283ec68786ea7890

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

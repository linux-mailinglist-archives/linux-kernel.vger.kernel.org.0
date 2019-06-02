Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D261D32474
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfFBRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 13:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFBRZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:25:14 -0400
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559496314;
        bh=iOnJZE8EJahNdGN3ThHkcdQCXFY2cOQbI2F+QCjOLS8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RHvbWUzXpI3l1sxlMgNRQz3Z0gL8JRktj2q/DOx/UwH8IxlLdWmF+Wlj5WJZ8Xhgg
         JpEyLFr0cO5KZfkLeLYOAFR6EvhJj89CHaott+3b83g/ln/n92FRcYSIg8Tf+QxPhq
         xf/NVx6zpfradz87JxLvt7dWkcbfo1jMpS794SO8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190602063905.GA14513@kroah.com>
References: <20190602063905.GA14513@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190602063905.GA14513@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/spdx-5.2-rc3-2
X-PR-Tracked-Commit-Id: 8e82fe2ab65a80b1526b285c661ab88cc5891e3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a68dc6188242e1cc6f72eb3361e71633b4bc02a7
Message-Id: <155949631417.24242.14157611336640878616.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 17:25:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 2 Jun 2019 08:39:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a68dc6188242e1cc6f72eb3361e71633b4bc02a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

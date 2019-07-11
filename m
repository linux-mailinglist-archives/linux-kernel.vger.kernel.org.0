Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665EA661EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfGKWpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbfGKWpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:45:13 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562885112;
        bh=D/w243M5dsqOwBO9sWlPTL4P8QTC4CgTd+rbtik/ZEE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rXRlxtK/x2Bsq+T2pv2CQmRq0Ho+sYSS6B+vIzdfOGddIl1adQwKMtl5I6oSKnZWN
         Q4XFT5jmXPyFgFzlFAaFn4dMcDxj6oeLuqiBr+43igOxQ1vq84Tn77AmSk4IEKLqwD
         Sp5Vd2MP3lYBc+195uCAdw33qNomMlQyBSbPCbII=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710133156.GA23980@kroah.com>
References: <20190710133156.GA23980@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710133156.GA23980@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.3-rc1
X-PR-Tracked-Commit-Id: 2f4281f4dce12440727ab770683cfb83eab62a26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97ff4ca46d3279134cec49752de8c5a62dc68460
Message-Id: <156288511250.25905.810215783360550964.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:45:12 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 15:31:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97ff4ca46d3279134cec49752de8c5a62dc68460

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

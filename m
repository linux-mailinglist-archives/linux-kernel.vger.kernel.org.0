Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37707BFA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 22:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfIZUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 16:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbfIZUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:10:30 -0400
Subject: Re: [GIT PULL] usercopy fix for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569528629;
        bh=58a6cUOD9IA7HFPjJ2f+bkAcP30bilb5nehkgkxWZ20=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FwVAz5usrBDCm0ULHRIOUE+J/Kc93LRBjrq6qpzdpEXh6dWipKuxWyL9YYtUaKqrD
         k1fIHVSNDxG3vg9dCtUlDK5rttkJvqhdCz3SbnJFG3c9QtN+lo4N4YYJ1uySkpxX67
         CcUAXtl/Ow4E6I4bI2mqljM4ncTfJWv0Pxsyyk88=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201909261131.65DA27B@keescook>
References: <201909261131.65DA27B@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201909261131.65DA27B@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/usercopy-v5.4-rc1
X-PR-Tracked-Commit-Id: 314eed30ede02fa925990f535652254b5bad6b65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0576f0602a4926b0027fdd7561a1c0053fa99d26
Message-Id: <156952862990.24871.564035307385464885.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 20:10:29 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 11:35:41 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/usercopy-v5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0576f0602a4926b0027fdd7561a1c0053fa99d26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

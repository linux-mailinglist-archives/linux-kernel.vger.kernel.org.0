Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB06661E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfGKWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729470AbfGKWpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:45:12 -0400
Subject: Re: [GIT PULL] HID for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562885111;
        bh=FrbJsCuogLEA/dq87ZyuHsFqaKsQSel9wVJkTgt/USQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aqyoeqcLReC+h3t+1fY6WjaXQ3DYBJxYTvQAgK0/knZUtUDgyYhw3dHvNQpWpgPkv
         d11O3iPwIp+Nj6okgzqoYbSjUZDRGx9EDPMAIabFp8dkdUg7dalNKuIzbMCbbYQK3X
         FYXbw0o5lRN4da0sX6WujSJu9RxpzP6t/TIz6oig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1907100143190.5899@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1907100143190.5899@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1907100143190.5899@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 86766756ac2b10ad23849becdc245ea903466616
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4832a4dada1a2baefac76b70e4f3a78e71a7c35c
Message-Id: <156288511179.25905.6502635712874027345.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:45:11 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 01:47:48 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4832a4dada1a2baefac76b70e4f3a78e71a7c35c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

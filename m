Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151A0F6B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKJVAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 16:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKJVAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:07 -0500
Subject: Re: [GIT PULL] SMB3 Fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419606;
        bh=1nssyDQ5n4F91Cta/pggDN72IAbM0kSK5eyvXFrshWc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HZ1yu8ox/S8QtRQIwnbueWNAnY+SIPkZKslhGLUwiBGLQYotmhXuuv53ouQ0AA8Ab
         wafzcwDMe4tsNmXBEehsw8AHvTc3sxC8L7nG7Fc5Lfsgub0GWwxQMkwK6EsgCrv43g
         DvUdghZR9LtiW9yse1GyM0MA/CWkYIGIknSD2y3g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muiDNRJJGnrmdcE=MG5SQvjau=J7sG4CJGUzAe9KpW1bQ@mail.gmail.com>
References: <CAH2r5muiDNRJJGnrmdcE=MG5SQvjau=J7sG4CJGUzAe9KpW1bQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muiDNRJJGnrmdcE=MG5SQvjau=J7sG4CJGUzAe9KpW1bQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.4-rc7-smb3-fix
X-PR-Tracked-Commit-Id: d243af7ab9feb49f11f2c0050d2077e2d9556f9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79a64063a84fda220115181fea803c1ae60b4149
Message-Id: <157341960662.30887.14232160082263517430.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 02:10:18 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.4-rc7-smb3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79a64063a84fda220115181fea803c1ae60b4149

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

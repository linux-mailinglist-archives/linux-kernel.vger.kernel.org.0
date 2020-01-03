Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA412F2B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgACBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgACBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Subject: Re: [GIT PULL] gcc-plugins fix for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578014705;
        bh=wuJ6jyetQrQE5AgzbPce08e3RKECGcbyg5676m6mvhY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jdrPbdFjbgKAhQyxM4wF0mKmlFd2pZ2tu1WEq/Lp7g22+k8UNlT93PqaXgh/hpXU9
         1dN4wqV5ti6IjMDZnOMyhDsAqW5pX64+HGtwvxjfMStO/ug52AJO9PtKxbZ/dZPs9r
         YQnX6II11CqNJ4f5jmuEBq7q3jmHNUUXawn/A1cQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202001021335.14622751ED@keescook>
References: <202001021335.14622751ED@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202001021335.14622751ED@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/gcc-plugins-v5.5-rc5
X-PR-Tracked-Commit-Id: a5b0dc5a46c221725c43bd9b01570239a4cd78b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90e0a47be934644944e7c6a29b8fc561be168ee1
Message-Id: <157801470583.30243.4425392975724560462.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 01:25:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jan 2020 13:38:15 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90e0a47be934644944e7c6a29b8fc561be168ee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

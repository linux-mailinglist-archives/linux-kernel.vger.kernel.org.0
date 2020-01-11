Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C061381A4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 15:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgAKOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 09:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729837AbgAKOpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 09:45:05 -0500
Subject: Re: [GIT PULL] pstore fix for v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578753905;
        bh=eaAZH6GvI/NqgGKMXPBT/vj2NICbj1FOZi2dC4hx8rk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=14+bZklKxCt/UBXXWL2GxIw4dI4Q3b9jUsjUaBBeajmh33qvpq9e9MjIAwNbeq7cS
         VgeuEjVhjShA22Wpbk287Y15hsb5rDhUylX8UT+yUalcuYDy8snTVk0fewzuWn65MT
         n9GeeXOCggSshNpmn40yWopCdvOzlfApFcbt0S68=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202001092044.EE43B805@keescook>
References: <202001092044.EE43B805@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202001092044.EE43B805@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.5-rc6
X-PR-Tracked-Commit-Id: e163fdb3f7f8c62dccf194f3f37a7bcb3c333aa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bef1d88263ff769f15aa0e1515cdcede84e61d15
Message-Id: <157875390506.30634.10154844647759820656.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jan 2020 14:45:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cengiz Can <cengiz@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Jan 2020 20:46:57 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bef1d88263ff769f15aa0e1515cdcede84e61d15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

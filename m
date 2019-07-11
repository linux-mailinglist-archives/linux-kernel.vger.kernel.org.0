Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E093661BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfGKWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfGKWaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:30:09 -0400
Subject: Re: [GIT PULL] loadpin update for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562884208;
        bh=smUDeMWXonwWEqu0mhASbAtsvOKEScpazHDeDS35oIA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gWPg7Mb62uLawFZlwee3TdAVCxoZ24svK4Yenz/l0MtoEDDykpO3L4mrszmCy8CiR
         lxKHjhgv0IQJtKYEkYClXRthCzl+3dcizQs4UN/HSjMNHoOPK0brZB02jUNCMGfzz5
         PFkW1ftIT4Vvz5QgPhi8S3cAdx4lhg77UD23TsRY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201907082117.455440C84@keescook>
References: <201907082117.455440C84@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201907082117.455440C84@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/loadpin-v5.3-rc1
X-PR-Tracked-Commit-Id: 0ff9848067b7b950a4ed70de7f5028600a2157e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c079512aad9718c12c6bb1b661880b15a73dfd69
Message-Id: <156288420874.10140.5984555969011404746.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:30:08 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>, Ke Wu <mikewu@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 21:18:05 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/loadpin-v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c079512aad9718c12c6bb1b661880b15a73dfd69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

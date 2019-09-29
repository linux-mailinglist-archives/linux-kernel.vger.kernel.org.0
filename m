Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F5C1440
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 12:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfI2Kxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 06:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfI2Kxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 06:53:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1D520815;
        Sun, 29 Sep 2019 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569754430;
        bh=Cf13wGV+1QSyxWqzEWb6pHz/6+hGcOq0+BvEj16aEms=;
        h=Date:From:To:Cc:Subject:From;
        b=lx9O4BfRgqAjeOpofa7yI18dWk26FTgVSFdaXKLH47NzksgH/aa+LAt6F9apQJxvY
         9FKMZA51bTlyxP4ZTxqXyBvymYVhrAdP28EPWCndnuxh+HD4uSmDlFv5HV4Q5CYmON
         ddxxHa13FfP3jh8Oxj8l9Pf08v8Gb8wFJuxq9AME=
Date:   Sun, 29 Sep 2019 12:53:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation/process/embargoed-hardware-issues patches
 for 5.4-rc1
Message-ID: <20190929105347.GA1949165@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc1

for you to fetch changes up to dc925a36060e8cef050a9d05c64dae1c30dc5027:

  Documentation/process: Clarify disclosure rules (2019-09-29 12:43:18 +0200)

----------------------------------------------------------------
Documentation/process update for 5.4-rc1

Here are 2 small Documentation/process/embargoed-hardware-issues.rst
file updates that missed my previous char/misc pull request for 5.4-rc1.

The first one adds an Intel representative for the process, and the
second one cleans up the text a bit more when it comes to how the
disclosure rules work, as it was a bit confusing to some companies.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Thomas Gleixner (1):
      Documentation/process: Clarify disclosure rules

Tony Luck (1):
      Documentation/process: Volunteer as the ambassador for Intel

 .../process/embargoed-hardware-issues.rst          | 42 +++++++++++++++++-----
 1 file changed, 34 insertions(+), 8 deletions(-)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21688B30
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfHJMHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 08:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfHJMHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:07:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A39E2089E;
        Sat, 10 Aug 2019 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565438823;
        bh=gBREeprl7UjLCI8vwtjTf7ivqsGO2i5y+aNxz9PTlC0=;
        h=Date:From:To:Cc:Subject:From;
        b=yoaQOXfalcI00serWD4dD0l18vgXmr42bwt7s1VWPFAdlC6x59Yg3uSYB1sv0+WyH
         nNFDs1sUfXAw0n9mXcP/deNcjr2UHk32pjiHJb9GUjTC977EmE2nwR+A4Nx4pM977A
         W5UhscEvoT+5CJBNeL1XiZllOey/pzozdAZcKrcs=
Date:   Sat, 10 Aug 2019 14:07:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     tech-board-discuss@lists.linuxfoundation.org
Subject: Linux Kernel Code of Conduct Committee: September 2018 to July 2019
 report
Message-ID: <20190810120700.GA7360@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: September 2018 to July 2019 report

In the period of September 15, 2018 through July 31, 2019, the Committee
received the following reports:
  - Inappropriate language in the kernel source: 1
  - Insulting behavior in email: 3

The result of the investigations:
  - Education and coaching: 4

We would like to thank the Linux kernel community members who have supported
the adoption of the Code of Conduct and who continue to uphold the professional
standards of our community.  If you have questions about this report,
please write to <conduct@kernel.org>.

------------

Side-note, yes, the website at
https://www.kernel.org/code-of-conduct.html is not up to date with the
list of the current members of the kernel code of conduct committee, nor
does it contain this report yet, but that will be resolved next week
when I have a chance to fix it up.  Sometimes web site changes are hard
for kernel programmers :)

To let everyone know, the current members of the Kernel Code of Conduct
Committe are:
	Mishi Choudhary
	Shuah Khan
	Greg Kroah-Hartman
One other person has been nominated, but due to travel issues has not
formally accepted.  Their name will be added to the above web site when
that happens in a few weeks.

thanks,

greg k-h

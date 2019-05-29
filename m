Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79B2DDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfE2NNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:13:06 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46211 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfE2NNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:13:06 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8E45B40017;
        Wed, 29 May 2019 13:13:01 +0000 (UTC)
Date:   Wed, 29 May 2019 15:13:00 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
Message-ID: <20190529131300.GV3274@piout.net>
References: <20190521133257.GA21471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521133257.GA21471@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 21/05/2019 15:32:57+0200, Greg KH wrote:
>   - Add GPL-2.0-only or GPL-2.0-or-later tags to files where our scan

I'm very confused by those two tags because they are not mentioned in
the SPDX 2.1 specification or the kernel documentation and seem to just
be from https://spdx.org/ids-howi which doesn't seem to be versionned
anywhere.
While I understand the rationale behind those, I believe the correct way
of introducing them would be first to add them in the spec and
documentation and then make use of them.

Now, what should we do with all the GPL-2.0 and GPL-2.0+ tags that we
have?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

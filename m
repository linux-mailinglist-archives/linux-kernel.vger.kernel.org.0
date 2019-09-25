Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 110DBBE7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 23:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfIYVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 17:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfIYVuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:50:13 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493A72146E;
        Wed, 25 Sep 2019 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569448212;
        bh=0hElOx3BzQbrRg4qLp+t1hnvhiKVtH9mNvFATszNKeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K7O5+35b6Ac+m64iTBbK2S6SB+lhgxNCKhjM7IcdVSDsv1wm7VwMvx8Y6X/oB6XEk
         4u5uDYsizKBl250xDMeM150DYHz5cAUc3Ysh6oykM1xh2Oz8ds2ZhW5teJoNQwajnj
         9nIEmyflO26x5euUTVsqw+gs4DY2MTPCjo/SjYYI=
Date:   Wed, 25 Sep 2019 14:50:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH V2 1/2] string: Add stracpy and stracpy_pad mechanisms
Message-Id: <20190925145011.c80c89b56fcee3060cf87773@linux-foundation.org>
In-Reply-To: <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
References: <cover.1563889130.git.joe@perches.com>
        <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 06:51:36 -0700 Joe Perches <joe@perches.com> wrote:

> Several uses of strlcpy and strscpy have had defects because the
> last argument of each function is misused or typoed.
> 
> Add macro mechanisms to avoid this defect.
> 
> stracpy (copy a string to a string array) must have a string
> array as the first argument (dest) and uses sizeof(dest) as the
> count of bytes to copy.
> 
> These mechanisms verify that the dest argument is an array of
> char or other compatible types like u8 or s8 or equivalent.
> 
> A BUILD_BUG is emitted when the type of dest is not compatible.
> 

I'm still reluctant to merge this because we don't have code in -next
which *uses* it.  You did have a patch for that against v1, I believe? 
Please dust it off and send it along?


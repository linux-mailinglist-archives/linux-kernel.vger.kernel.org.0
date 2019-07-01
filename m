Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3DF44767
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfFMQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbfFMAQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:16:53 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0164120B7C;
        Thu, 13 Jun 2019 00:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560385013;
        bh=3RW4ZL44OOyTLO9aMA8OLP0G8v0dfCC/xXm6TXHDWbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lLT1tf/lBAgc9gaM7UNXCbnkWeZ3Z63UxIfuweXQwHi8wgYjIPL4QCEFUx5dcfSML
         0VyFRRIpU+ezOoce9s8KpxL7vdTAL6MtaihiW7By8qV+4CvF71b0LHbJkp5B/lSvBp
         pMb8yQLeDX/0IiK4I3HorwRUcMSKeICfZjiDPoSc=
Date:   Wed, 12 Jun 2019 17:16:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-next@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH linux-next] sysctl: fix build error
Message-Id: <20190612171652.b8ba1f05d835e3fc870829e4@linux-foundation.org>
In-Reply-To: <20190612220120.31312-1-mcroce@redhat.com>
References: <20190612220120.31312-1-mcroce@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 00:01:20 +0200 Matteo Croce <mcroce@redhat.com> wrote:

> Commit cefdca0a86be ("userfaultfd/sysctl: add vm.unprivileged_userfaultfd")
> reintroduces a reference to 'zero' and 'one'.
> Use the SYSCTL_{ZERO,ONE} symbols instead.

proc-sysctl-add-shared-variables-for-range-check-fix.patch (which has
been in linux-next for over a week) already fixed that.

> Reported-by: kbuild test robot <lkp@intel.com>

Some robot glitch I guess?


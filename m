Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604F814023D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 04:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbgAQDQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 22:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgAQDQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:16:10 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE85220679;
        Fri, 17 Jan 2020 03:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579230969;
        bh=Pv2hU0kC+NNhp2G0ieTjOr4w9ey+PNyLJxlmNWkf/j4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PxYqemw+WtaVcgnGoE30v238L3q61frkBF7mDd9rfw2Li3dIWg6z/0I805u3XKDLz
         AZMCUCujV11mMjaPdcQLcHrgZhDfI88Bod1Avr6KwaH3JOY68+8ZqpfUgw0gUZfTDp
         NjsAvGFq3rCcT3rIqmOZcdhFIPzT78HTOTXokPPA=
Date:   Thu, 16 Jan 2020 19:16:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, thp: fix defrag setting if newline is not used
Message-Id: <20200116191609.3972fd5301cf364a27381923@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.2001141757490.108121@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2001141757490.108121@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 17:58:36 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> If thp defrag setting "defer" is used and a newline is *not* used when
> writing to the sysfs file, this is interpreted as the "defer+madvise"
> option.
> 
> This is because we do prefix matching and if five characters are written
> without a newline, the current code ends up comparing to the first five
> bytes of the "defer+madvise" option and using that instead.
> 
> Find the length of what the user is writing and use that to guide our
> decision on which string comparison to do.

Gee, why is this code so complicated?  Can't we just do

	if (sysfs_streq(buf, "always")) {
		...
	} else if sysfs_streq(buf, "defer+madvise")) {
		...
	}
	...




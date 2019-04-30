Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8725F26D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfD3JD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 05:03:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34316 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3JD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/4BqZLU8mnQ9G3nFMLNLEctwoygnWU1IgTL2Gev8I/E=; b=I8VQaob5wOVn1vyXsaFo+zQqb
        7dQdH9BGHllwFQO71G5MBZHRUCCDz1FGp4DLX7sxn5CVTyzePvN4ccCLmmNtUJ7q4W0roXzSEaXBs
        mWSZQBs4VjY/cDcvORpvgk13pOIcr4DWUcf0bfSKEIOnV4ByzciRMuLSms03W9pkJbn3BTrnJKTt4
        5hS2vlzkEYNWRu5THt6O/GX+s9c8XxO30oORlHAZ9gCt0lcFmbQjmqRzT0HZ2tUWKPCBk24v5TyIo
        vykg0NDyhNK0xJmxMrw19oOELuoS9SniDupWXrHNII4+7YxWGpZEu+lbXM56+ui7iAYmI3KnIyNir
        QwY8GViNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLOfX-0007gk-AF; Tue, 30 Apr 2019 09:03:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 157F628B8D737; Tue, 30 Apr 2019 11:03:18 +0200 (CEST)
Date:   Tue, 30 Apr 2019 11:03:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, tj@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 3/4] perf cgroup: Add cgroup ID as a key of RB tree
Message-ID: <20190430090318.GK2623@hirez.programming.kicks-ass.net>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:44:04AM -0700, kan.liang@linux.intel.com wrote:

> Add unique cgrp_id for each cgroup, which is composed by CPU ID and css
> subsys-unique ID.

*WHY* ?! that doesn't make any kind of sense.. In fact you mostly then
use the low word because most everything is already per CPU.

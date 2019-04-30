Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CCDF1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfD3IJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 04:09:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3IJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NM23KKv9SPDsosuv69/SSr34Q0Nt39CFbFpZnOc9o7E=; b=2RoXeikaey7tkyiZJ806dJcKL
        WQdWjIeIkwi/PW4lIDdFjmPcRfayzpGW0zdBM7HnrQa+ufVDRFxU+WqeHF4aXbAV4mwEfoDUfhMCw
        nwoRJUivRcJiMgB7DdyRvaA9+9k0vaicPVdwvUySaXzJoRUJopMzQ6CIF0W4p6PS0jDpFm+oLyRFL
        bjkdTkUoRH3gXr2nwqhDSDaJzonBr6UZcoifdnbEP+brpwFpgd1TwXO6OGL4SJ40KMfTg36yT8Obr
        ONFGFRKja6mswOuSVY/wmgu8tO4XumxyjC6Zq/1HZp/N+j/aCAreT8lE+h7amjhSNlb8StYZJYi+z
        OaL4tRvGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLNpA-0007Ms-LZ; Tue, 30 Apr 2019 08:09:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 555A129D2D6D4; Tue, 30 Apr 2019 10:09:10 +0200 (CEST)
Date:   Tue, 30 Apr 2019 10:09:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ying Huang <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] latencytop lock usage improvement
Message-ID: <20190430080910.GI2623@hirez.programming.kicks-ass.net>
References: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:03:28PM +0800, Feng Tang wrote:
> Hi All,
> 
> latencytop is a very nice tool for tracing system latency hotspots, and
> we heavily use it in our LKP test suites.

What data does latency-top give that perf cannot give you? Ideally we'd
remove latencytop entirely.

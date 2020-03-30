Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9573197FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 17:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgC3Pby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 11:31:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3Pbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d9IF+7A4U87STc2EkrU6CXYaSvjSZQZt/o3dlCtbImg=; b=hOPpVHbdlGXoRpnY11oW3HuaMT
        /aDUHwn+wtU7sEyijuOzUWJS9OmsLqdtZqLnhSXHQ3iFgZ8p+HSgsVQdZg+xAv5aLjq0ZMoeWsWMz
        GZo9ZOLFrzCGpdKiwHwxhqhshuZJC2bX1U67kk2/SoA13pNgQbLR5Uvio4hTQVXXXqgnatKCks1Q1
        P008Q3nFrfkj2gKgNASD1GfPAhpsFOyPxrzjRvqw7+WaO13wGitVtv4XQX5VP3GnPaPVdADpv3DBR
        LHHRdZbaLKNGLOTAbnCSnvKewENHDDuA5A6eHn98+o6k0V3e+3EVaIfb+itZWYvEpo/crqZrUBy0+
        R6KH7Rzw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIwOD-0005aM-RQ; Mon, 30 Mar 2020 15:31:49 +0000
Date:   Mon, 30 Mar 2020 08:31:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/18] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200330153149.GE22483@bombadil.infradead.org>
References: <20200330023248.164994-11-joel@joelfernandes.org>
 <202003301715.9gMSa9Ca%lkp@intel.com>
 <20200330152951.GA2553@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330152951.GA2553@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:29:51PM +0200, Uladzislau Rezki wrote:
> Hello, Joel.
> 
> Sent out the patch fixing build error.

... where?  It didn't get cc'd to linux-mm?

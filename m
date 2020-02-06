Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46480154A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 12:36:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49014 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SMyOfhZzZPZuujUA9E6GKG9U2eDhQH0R/BujkYeevWk=; b=cESW/Gp9HDS3+G9FpVQTt6hOML
        sjgfAiMlMAPrC4TEVSciFPIhysWIP8ufQdJNbRKMnaikCo8+eDJVaTBvgSUfdGUwuKazj8S5/zve7
        SBkf/3rkk/p/TKFS6tlJnf7uMgL8rChYdeX2tHYoD6liZjqYo5imoBuFHVXbY/CMckJiLTHagj090
        iktPwKHYbuBQWOb3us0vZkN0q8aFayNFrHfWZ8BrhbMcept9LCEkDWVRrRnXagS/b9CneWfFZWFcK
        nWq0TCHsJEFcLdftOsZdiO+WEmMdgzv0QAIsnyf/HZgwx1UUx9SzYff5sySRduCbm+dGIYnxu1jJB
        pDWRlu2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izl3z-0006cL-Vd; Thu, 06 Feb 2020 17:35:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B93FA30066E;
        Thu,  6 Feb 2020 18:33:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40AB22B813367; Thu,  6 Feb 2020 18:35:38 +0100 (CET)
Date:   Thu, 6 Feb 2020 18:35:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
Message-ID: <20200206173538.GY14914@hirez.programming.kicks-ass.net>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-9-kristen@linux.intel.com>
 <20200206103830.GW14879@hirez.programming.kicks-ass.net>
 <202002060356.BDFEEEFB6C@keescook>
 <20200206145253.GT14914@hirez.programming.kicks-ass.net>
 <9f337efdf226e51e3f5699243623e5de7505ac94.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f337efdf226e51e3f5699243623e5de7505ac94.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:25:01AM -0800, Kristen Carlson Accardi wrote:

> That's right - all of these tables that you mention had relocs and thus
> I did not have to do anything special for them. The orc_unwind_ip
> tables get sorted during unwind_init(). 

No they're not:

  f14bf6a350df ("x86/unwind/orc: Remove boot-time ORC unwind tables sorting")

Or rather, it might be you're working on an old tree.

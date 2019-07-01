Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7775269BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfEVSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 14:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfEVSTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:19:18 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FF92173C;
        Wed, 22 May 2019 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558549157;
        bh=FwWp5RRKikkIIRHUmRqkwRpc7CY4CyqIf4M/5GG0/tk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BWHq6373GnTo8u02TOCLcpwAujfx/Jtic6RHRvtS/cCp1RooT9vzGcrvy7c7N0y8k
         mmNdKiFe5SB8Da56xeTTokV/wocZWrAIczQslB4vlWePuM9uu8uTnWXaPMpF2JQzaL
         9OdaA7e1AGMKU7YcbfPO5GIbpgk/ZpmoCqXWEYpU=
Date:   Wed, 22 May 2019 11:19:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Message-Id: <20190522111916.b99a18d67bc76f7cf207d9e6@linux-foundation.org>
In-Reply-To: <20190522150939.24605-4-urezki@gmail.com>
References: <20190522150939.24605-1-urezki@gmail.com>
        <20190522150939.24605-4-urezki@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 17:09:39 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> function, it means if an empty node gets freed it is a BUG
> thus is considered as faulty behaviour.

So... this is an expansion of the assertion's coverage?

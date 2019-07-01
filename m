Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF902D478
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 06:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfE2ES2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 00:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfE2ES2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:18:28 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1AA2075C;
        Wed, 29 May 2019 04:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559103507;
        bh=UCoSBziCPhM34UxaNiokPrwVzYzZYIsmWDVJIPGcZqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MUfztLfM2HnwlYhIlBFmei3xc7llqPTTjMBONPqsdNnjQJyiPtGAm5eL19MlY5vzO
         tSo0vVQTUBl6dwv+uKzb60PVt3IgWWRXIuAuk5bdbRQKY52JeRzvR0wdSTbNJnKlhg
         JyDda8Z8xHZ757MndAPgkg0tZcdlzGV/mxV+4gIA=
Date:   Tue, 28 May 2019 21:18:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Hugh Dickins <hughd@google.com>, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/fpu: Use fault_in_pages_writeable() for
 pre-faulting
Message-Id: <20190528211826.0fa593de5f2c7480357d3ca5@linux-foundation.org>
In-Reply-To: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
References: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2019 19:33:25 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Hugh Dickins <hughd@google.com>
> 
> Since commit
> 
>    d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")

Please add this as a

Fixes: d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")

line so that anyone who backports d9c9ce34ed5c8 has a chance of finding
this patch also.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA80B4858
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404487AbfIQHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 03:34:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44951 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404465AbfIQHeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:34:36 -0400
Received: from static-dcd-cqq-121001.business.bouyguestelecom.com ([212.194.121.1] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iA80O-0001j7-JQ; Tue, 17 Sep 2019 07:34:32 +0000
Date:   Tue, 17 Sep 2019 09:34:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Add __ASSEMBLY__ guards around struct clone_args
Message-ID: <20190917073431.6k2gumjah7htzqan@wittgenstein>
References: <20190917071853.12385-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190917071853.12385-1-seth.forshee@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:18:53AM +0200, Seth Forshee wrote:
> The addition of struct clone_args to uapi/linux/sched.h is not
> protected by __ASSEMBLY__ guards, causing a FTBFS for glibc on
> RISC-V. Add the guards to fix this.
> 
> Fixes: 7f192e3cd316 ("fork: add clone3")
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fixes

Just replaced FTBS with "failure to build from source" since I had to
search for this and also added Cc: <stable@vger.kernel.org> for 5.3.

Thanks!
Christian

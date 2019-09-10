Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98015AEA25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbfIJMUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 08:20:35 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46586 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbfIJMUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:20:34 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4363B72CC6C;
        Tue, 10 Sep 2019 15:20:32 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BD4867CCB47; Tue, 10 Sep 2019 15:20:31 +0300 (MSK)
Date:   Tue, 10 Sep 2019 15:20:31 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] fork: fail on non-zero higher 32 bits of args.exit_signal
Message-ID: <20190910122031.GA5311@altlinux.org>
References: <20190910115711.GA3755@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910115711.GA3755@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:57:11PM +0100, Eugene Syromiatnikov wrote:
> Previously, higher 32 bits of exit_signal fields were lost when
> copied to the kernel args structure (that uses int as a type for the
> respective field).  Fail with EINVAL if these are set as it looks like
> there's no sane reason to accept them.
> 
> * kernel/fork.c (copy_clone_args_from_user): Fail with -EINVAL if
> args.exit_signal converted to unsigned int is not equal to the original
> value.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>


-- 
ldv

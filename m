Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D96FC14E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 09:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKNIOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 03:14:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60198 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfKNIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:14:20 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVAGP-00078t-4y; Thu, 14 Nov 2019 08:14:01 +0000
Date:   Thu, 14 Nov 2019 09:14:00 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v9 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191114081359.axnoioa25grf3ffv@wittgenstein>
References: <20191114070709.1504202-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114070709.1504202-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:07:08AM +0100, Adrian Reber wrote:
>   * The structure is versioned by size and thus extensible.
>   * New struct members must go at the end of the struct and
> @@ -71,6 +85,8 @@ struct clone_args {
>  	__aligned_u64 stack;
>  	__aligned_u64 stack_size;
>  	__aligned_u64 tls;
> +	__aligned_u64 set_tid;
> +	__aligned_u64 set_tid_size;

Oh, one thing that is missing is the addition of

+#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */

in sched.h. Please add that, when you resend.

Thanks!
Christian

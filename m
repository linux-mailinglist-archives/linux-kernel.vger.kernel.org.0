Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88120FE848
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 23:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKOWwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 17:52:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56154 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKOWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:52:00 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVkRP-0005U8-CP; Fri, 15 Nov 2019 22:51:47 +0000
Date:   Fri, 15 Nov 2019 23:51:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v11 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191115225145.c6r5avibiluzxj3c@wittgenstein>
References: <20191115123621.142252-1-areber@redhat.com>
 <fada5995-7fcc-7ca8-0933-4d0f52deef6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fada5995-7fcc-7ca8-0933-4d0f52deef6e@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 04:54:06PM +0000, Dmitry Safonov wrote:
> On 11/15/19 12:36 PM, Adrian Reber wrote:
> [..]
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> > Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
> 
> [though, I have 2 minor nits below]
> 
> [..]
> > + * @set_tid:      Pointer to an array of type *pid_t. The size
> > + *                of the array is defined using @set_tid_size.
> > + *                This array is used select PIDs/TIDs for newly
> 
> /is used select/is used to select/s

I fixed this up while applying.

Thanks!
Christian

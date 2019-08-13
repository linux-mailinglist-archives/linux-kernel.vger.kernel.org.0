Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47488BBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfHMOqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 10:46:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58412 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfHMOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:46:43 -0400
Received: from [208.54.80.146] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxY4B-0002Ox-F7; Tue, 13 Aug 2019 14:46:28 +0000
Date:   Tue, 13 Aug 2019 16:46:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v6 2/2] selftests: add tests for clone3()
Message-ID: <20190813144618.r57njm3maoh7epr3@wittgenstein>
References: <20190812200939.23784-1-areber@redhat.com>
 <20190812200939.23784-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812200939.23784-2-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:09:39PM +0200, Adrian Reber wrote:
> This tests clone3() with and without set_tid to see if all desired PIDs
> are working as expected. The test tries to clone3() with a set_tid of
> -1, 1, pid_max, a PID which is already in use and an unused PID. The
> same tests are also running in PID namespace.
> 
> In addition the clone3 test (without set_tid) tries to call clone3()
> with different sizes of clone_args.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>

This is missing a .gitignore file for the new binaries. But no need to
resend I'll just add that myself.

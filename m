Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB210577D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 17:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKUQws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 11:52:48 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:56845 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:52:48 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iXpgx-0004CD-G1; Thu, 21 Nov 2019 16:52:27 +0000
Message-ID: <1634aafd2a99cedceb63efe57e4c7e0a7317917b.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 21/23] y2038: itimer: change implementation to
 timespec64
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Date:   Thu, 21 Nov 2019 16:52:26 +0000
In-Reply-To: <20191108211323.1806194-12-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
         <20191108211323.1806194-12-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 22:12 +0100, Arnd Bergmann wrote:
[...] 
> @@ -292,8 +296,8 @@ static unsigned int alarm_setitimer(unsigned int seconds)
>  	 * We can't return 0 if we have an alarm pending ...  And we'd
>  	 * better return too much than too little anyway
>  	 */
> -	if ((!it_old.it_value.tv_sec && it_old.it_value.tv_usec) ||
> -	      it_old.it_value.tv_usec >= 500000)
> +	if ((!it_old.it_value.tv_sec && it_old.it_value.tv_nsec) ||
> +	      it_old.it_value.tv_nsec >= 500000)
[...]

This is now off by a factor of 1000.  It might be helpful to use
NSEC_PER_SEC / 2 here so no-one has to count the 0 digits.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


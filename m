Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB813D8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 12:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgAPLT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 06:19:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgAPLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:19:58 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is3Bq-0005DA-Jz; Thu, 16 Jan 2020 12:19:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3F1F8101B66; Thu, 16 Jan 2020 12:19:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] kernel: set taint flag 'L' at any kind of lockup
In-Reply-To: <157503370645.8187.6335564487789994134.stgit@buzz>
References: <157503370645.8187.6335564487789994134.stgit@buzz>
Date:   Thu, 16 Jan 2020 12:19:54 +0100
Message-ID: <87eevzwsv9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:
> Any lockup or stall notifies about unexpected lack of progress.
> It's better to know about them for further problem investigations.
>
> Right now only softlockup has own taint flag. Let's generalize it.
>
> This patch renames TAINT_SOFTLOCKUP into TAINT_LOCKUP at sets it for:

Please search 'This patch' in Documentation/process/submitting-patches.rst

> - softlockup
> - hardlockup
> - RCU stalls
> - stuck in workqueues
> - detected task hung

This does too many things at once and wants to be split in pieces:

  1) Change the TAINT flag and update documentation

  2) Add the tainting to the places which are not yet covered

Thanks,

        tglx

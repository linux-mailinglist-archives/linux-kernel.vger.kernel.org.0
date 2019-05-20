Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF823CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 18:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392539AbfETQGk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 May 2019 12:06:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58073 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbfETQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:06:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hSko9-00056D-G8; Mon, 20 May 2019 18:06:37 +0200
Date:   Mon, 20 May 2019 18:06:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
References: <20190519221700.GA7154@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190519221700.GA7154@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-20 00:17:01 [+0200], Pavel Machek wrote:
> Hi!
Hi,

> emacs segfaults... when I attempt to exit it. And that did not use to
> be the case. Nothing suspect in the dmesg. Rest of the machine seems
> to work ok.
…
> Ideas welcome...

I assume that this happens with -rc1, too. Could you please check if
emacs still segfaults with commit

  d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")

and commit

  89833fab15d60 ("x86/fpu: Fix __user annotations")

?

Sebastian

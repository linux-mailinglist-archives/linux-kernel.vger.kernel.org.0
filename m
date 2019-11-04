Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B472EEE1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 23:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390730AbfKDWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 17:12:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390371AbfKDWL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:11:58 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRkZm-0007xK-RG; Mon, 04 Nov 2019 23:11:55 +0100
Date:   Mon, 4 Nov 2019 23:11:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spdxcheck.py complains about the second OR?
In-Reply-To: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> scripts/spdxcheck.py warns the following two files.
> 
> $ ./scripts/spdxcheck.py
> drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: OR
> drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: OR
> 
> I do not understand what is wrong with them.
> 
> I think "A OR B OR C" is sane.

Yes it is, but obviously we did not expect files with 3 possible
alternative licenses.

Thanks,

	tglx

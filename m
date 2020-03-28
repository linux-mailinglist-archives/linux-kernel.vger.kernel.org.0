Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B901965B1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 12:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgC1LWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 07:22:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1LWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:22:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jI9XY-000480-BR; Sat, 28 Mar 2020 12:22:12 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A1A231040C1; Sat, 28 Mar 2020 12:22:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jules Irenge <jbi.octave@gmail.com>, julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Armijn Hemel <armijn@tjaldur.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muchun Song <smuchun@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] softirq: Replace BUG() after if statement with BUG_ON
In-Reply-To: <20200327212358.5752-6-jbi.octave@gmail.com>
References: <20200327212358.5752-1-jbi.octave@gmail.com> <20200327212358.5752-6-jbi.octave@gmail.com>
Date:   Sat, 28 Mar 2020 12:22:11 +0100
Message-ID: <871rpcyba4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jules,

Jules Irenge <jbi.octave@gmail.com> writes:
> Coccinelle reports a warning tasklet_action_common()
>
> WARNING: Use BUG_ON instead of if condition followed by BUG
>
> To fix this, BUG() is replaced by BUG_ON() with the recommended
> suggestion

Well, the suggestion is wrong to begin with. The suggestion should be:

      Is this BUG() actually necessary and is this the only way to deal
      with this problem?

Only if that question can be answered with yes, then the recommended
replacement is ok.

BUG() is the last resort and each and every instance wants to be looked
at and not mechanically changed to some 'better' version of it.

Thanks,

        tglx

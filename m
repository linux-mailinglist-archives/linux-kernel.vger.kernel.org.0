Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB82B604
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 15:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfE0NIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 09:08:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47671 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfE0NIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:08:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hVFMu-0004AJ-VY; Mon, 27 May 2019 15:08:49 +0200
Date:   Mon, 27 May 2019 15:08:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.1.0-next-20190520 -- emacs segfaults on 32-bit machine Re:
 5.2-rc0.8: emacs segfaults?! x220, with 32-bit userland
Message-ID: <20190527130848.lec6zp3ntyhemsbj@linutronix.de>
References: <20190519221700.GA7154@amd>
 <20190520160636.z6fpjiidc2d5ko5g@linutronix.de>
 <20190520231342.GA20835@amd>
 <20190521073240.mikv2ufwyriy4q7r@linutronix.de>
 <20190522183329.GB10003@amd>
 <20190523083724.GA21185@amd>
 <20190523145035.wncfmwem57z2oxb7@linutronix.de>
 <20190527130317.GB19795@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190527130317.GB19795@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-27 15:03:17 [+0200], Pavel Machek wrote:
> > could you please send me (offlist) your .config? Also, what kind of
> > userland do you run? Something like Debian stable?
> 
> Yep, debian stable.

Since we had a little bit of development recently, could you please
check if
	http://lkml.kernel.org/r/20190526173325.lpt5qtg7c6rnbql5@linutronix.de

makes any difference?

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB6ED40E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 18:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfKCRzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 12:55:19 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:37738 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfKCRzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1572803718; bh=MGuxCWQzSNeVxIqwqCpa7bikLB+K0iCdvBhW6Ol153o=;
        h=In-Reply-To:Date:Subject:From:To:Cc;
        b=kFhdAD88qqxarFQEazbEIieC/wU2asm7jGSTmfIuNiAhPbyk4+B5Q9883qt1UiPnC
         kZH1pFJrnEMo3gMyka7PrtVaE5otIewtR6GSzgTrnT6Xj7B3pEFRxX90jv/P4JZTFM
         7/RQ09qp05zA+2m+wpqQeUY+lXbvRyWdlCdqCO6Q=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191103175011.GA751209@kroah.com>
Date:   Sun, 03 Nov 2019 12:55:18 -0500
Subject: Re: [PATCH] firmware loader: log path to loaded firmwares
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <~sircmpwn/public-inbox@lists.sr.ht>
Message-Id: <BY6GDXDCFDBR.1R9QENSVRGR7L@homura>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Nov 3, 2019 at 6:50 PM Greg Kroah-Hartman wrote:
> And it's totally noisy :(
>=20
> Please just make this a debug call, that way you can turn it on
> dynamically if you really want to see what firmware is attempting to be
> loaded.

The typical setup won't need more than say, 10-20 firmwares? On my
system I need 13, and 12 of them are just for AMDGPU. In the 20 minutes
since I rebooted to this kernel, it constitutes less than 1% of my dmesg
volume, and will only get less so over time unless I start hotplugging
stuff (in which case, their respective drivers are likely to make noise,
too). In practice, I don't think it'll be especially noisy.

On the other hand, enabling debug logs just to get this information
would generate heaps of noise for a little bit of signal. This use-case
isn't the exceptional case for me, on my systems I only install the
firmwares I need so this is something I would reach for every time I set
up a new system.

> Also, if you have a 'struct device' you should always use the dev_*()
> calls instead, which will show you exactly what device is asking for
> what.

Understood.

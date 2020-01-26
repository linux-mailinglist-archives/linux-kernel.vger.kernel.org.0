Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2514999E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 09:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAZIJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 03:09:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAZIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 03:09:58 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ivczT-0004Yw-Fn; Sun, 26 Jan 2020 09:09:55 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7F883100490; Sun, 26 Jan 2020 09:09:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <1579977166-63618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <1579977166-63618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Date:   Sun, 26 Jan 2020 09:09:54 +0100
Message-ID: <8736c2myel.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob Pan <jacob.jun.pan@linux.intel.com> writes:

> It seems we could avoid force_retrigger once IR is turned on. I have tried
> this patch with IR turned on, still seeing force_retrigger=1 for MSIs w/o
> masking.

Yes. That patch was a POC and surely not a final solution. Aside of that
I'm still looking into a solution to avoid that which does not involve
horrible locking and tons of scary code.

Thanks,

        tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB1130FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 11:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFKB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 05:01:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFKB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:01:29 -0500
Received: from [10.137.127.45] (unknown [46.114.39.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 930D11EC05B0;
        Mon,  6 Jan 2020 11:01:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578304887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QSIzxH5jcor0r8Gl6bz00CjoIyuEsmLJNCnaaNkYNYE=;
        b=MZS2XSPCoccmJbUJJpRaijZz+68+WEKnLapV3yNrncAFmez+v2U0+0yP5AE++A4wrEbkHS
        RCHsUkrZo9JHTO4T2ON/MVD8j/E7+WUtK/W/o85IZUnU9l7frrzcIaMWwEeoq6X+WYh4mS
        vYqeDe+hCBUJFbsZnkR7J7xF/Z2WOwc=
Date:   Mon, 06 Jan 2020 11:01:25 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A615FC2FF@SHSMSX101.ccr.corp.intel.com>
References: <20200106064155.64-1-chuansheng.liu@intel.com> <20200106070759.GB12238@zn.tnic> <27240C0AC20F114CBF8149A2696CBE4A615FC2FF@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized therm_work
To:     "Liu, Chuansheng" <chuansheng.liu@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <130561C3-5E52-4693-B15F-B89C8B8366B0@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 6, 2020 10:22:06 AM GMT+01:00, "Liu, Chuansheng" <chuansheng=2El=
iu@intel=2Ecom> wrote:
>I traced there is about 2s gap between unmask interrupt and workqueue
>Initialization=2E=20

And that is a problem because?

You setup workqueue etc and *then* unmask the irq=2E=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 

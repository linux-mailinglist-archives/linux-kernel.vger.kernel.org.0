Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF8DFB70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 04:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfJVCK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 22:10:29 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:11591 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbfJVCK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:10:29 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x9M1q10Y068205;
        Tue, 22 Oct 2019 09:52:01 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 22 Oct 2019
 10:09:00 +0800
Date:   Tue, 22 Oct 2019 10:09:00 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>, <alankao@andestech.com>,
        <palmer@sifive.com>, <aou@eecs.berkeley.edu>, <glider@google.com>,
        <dvyukov@google.com>, <corbet@lwn.net>, <alexios.zavras@intel.com>,
        <allison@lohutok.net>, <Anup.Patel@wdc.com>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <atish.patra@wdc.com>,
        <kstewart@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/3] kasan: Archs don't check memmove if not support
 it.
Message-ID: <20191022020900.GA29285@andestech.com>
References: <cover.1570514544.git.nickhu@andestech.com>
 <c9fa9eb25a5c0b1f733494dfd439f056c6e938fd.1570514544.git.nickhu@andestech.com>
 <ba456776-a77f-5306-60ef-c19a4a8b3119@virtuozzo.com>
 <alpine.DEB.2.21.9999.1910171957310.3156@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910171957310.3156@viisi.sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x9M1q10Y068205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:58:04PM -0700, Paul Walmsley wrote:
> On Thu, 17 Oct 2019, Andrey Ryabinin wrote:
> 
> > On 10/8/19 9:11 AM, Nick Hu wrote:
> > > Skip the memmove checking for those archs who don't support it.
> >  
> > The patch is fine but the changelog sounds misleading. We don't skip memmove checking.
> > If arch don't have memmove than the C implementation from lib/string.c used.
> > It's instrumented by compiler so it's checked and we simply don't need that KASAN's memmove with
> > manual checks.
> 
> Thanks Andrey.  Nick, could you please update the patch description?
> 
> - Paul
>

Thanks! I would update the description in v4 patch.

Nick 

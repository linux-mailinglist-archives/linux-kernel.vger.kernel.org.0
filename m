Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874BC41EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408141AbfFLISH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 04:18:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:33427 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfFLISG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:18:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5C8HkA7008611;
        Wed, 12 Jun 2019 03:17:47 -0500
Message-ID: <ff34090039ba2ce880a74b0a3714c8ed38f64ed7.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@ozlabs.org,
        Christoph Hellwig <hch@infradead.org>,
        Russell Currey <ruscur@au1.ibm.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jun 2019 18:17:46 +1000
In-Reply-To: <CAOSf1CFcYnhKf0EJkm+E5uHg4e=QYGe+vAUz_TjX-v6UsmNtFA@mail.gmail.com>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
         <20190611095857.GB24058@kroah.com> <20190611151753.GA11404@infradead.org>
         <20190611152655.GA3972@kroah.com>
         <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
         <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
         <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
         <CAOSf1CFcYnhKf0EJkm+E5uHg4e=QYGe+vAUz_TjX-v6UsmNtFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 15:45 +1000, Oliver O'Halloran wrote:
> 
> Also, are you sure about the MSI thing? The IODA3 spec says the only
> important bits for a 64bit MSI are bits 61:60 (to hit the window) and
> the lower bits that determine what IVE to use. Everything in between
> is ignored so ORing in bit 59 shouldn't break anything.

On IODA3... could be different on another system. My point is you can't
just have a fixed setting for all top bits for DMA & MSIs.

> > This will only work as long as all of the system memory can be
> > addressed at an offset from that fixed address that itself fits your
> > device addressing capabilities (50 bits in this case). It may or may
> > not be the case but there's no way to check since the DMA mask logic
> > won't really apply.
> > 
> > You might want to consider fixing your HW in the next iteration... This
> > is going to bite you when x86 increases the max physical memory for
> > example, or on other architectures.
> 
> Yes, do this. The easiest way to avoid this sort of wierd hack is to
> just design the PCIe interface to the spec in the first place.

Ben.


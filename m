Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BFE14534E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 12:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgAVLAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 06:00:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAVLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:00:08 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iuDjm-0000vT-0P; Wed, 22 Jan 2020 11:59:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5700C101F92; Wed, 22 Jan 2020 11:59:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: About irq_create_affinity_masks() for a platform device driver
In-Reply-To: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com>
References: <84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com>
Date:   Wed, 22 Jan 2020 11:59:53 +0100
Message-ID: <87o8uveoye.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

John Garry <john.garry@huawei.com> writes:
> Would there be any issue with a SCSI platform device driver referencing 
> this function?
>
> So I have a multi-queue platform device, and I want to spread interrupts 
> over all possible CPUs, just like we can do for PCI MSI vectors. This 
> topic was touched on in [0].
>
> And, if so it's ok, could we export that same symbol?

I think you will need something similar to what we have in the pci/msi
code, but that shouldn't be in your device driver. So I'd rather create
platform infrastructure for this and export that.

Thanks,

        tglx

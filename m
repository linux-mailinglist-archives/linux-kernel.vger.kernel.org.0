Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E935140BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 14:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAQN63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 08:58:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56278 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:58:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isS8c-0001HZ-Q4; Fri, 17 Jan 2020 14:58:14 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3D509100C19; Fri, 17 Jan 2020 14:58:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        zhabin@linux.alibaba.com, jing2.liu@intel.com,
        chao.p.peng@intel.com
Subject: Re: [PATCH v1 1/2] x86/msi: Enhance x86 to support platform_msi
In-Reply-To: <c0919551d21bf519b05e00e6a924cbde95c5df32.1577240905.git.zhabin@linux.alibaba.com>
Date:   Fri, 17 Jan 2020 14:58:14 +0100
Message-ID: <874kwu2nih.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zha Bin <zhabin@linux.alibaba.com> writes:

> From: Liu Jiang <gerry@linux.alibaba.com>
>
> The x86 platform currently only supports specific MSI/MSI-x for PCI
> devices. To enable MSI to the platform devices such as virtio-mmio
> device, this patch enhances x86 with platform MSI by leveraging the
> already built-in platform-msi driver (drivers/base/platform-msi.c)
> and makes it as a configurable option.

Why are you trying to make this an architecture feature instead of
having a generic implementation which can work on all architectures
which support virtio-mmio?

> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>

This Signed-off-by chain is invalid.

Thanks,

        tglx

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A65F8CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 11:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 05:39:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33236 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKLKjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:39:01 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUTZX-0007yN-6G; Tue, 12 Nov 2019 11:38:55 +0100
Date:   Tue, 12 Nov 2019 11:38:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/12] riscv: abstract out CSR names for supervisor vs
 machine mode
In-Reply-To: <20191028121043.22934-2-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1911121137430.1833@nanos.tec.linutronix.de>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-2-hch@lst.de>
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

On Mon, 28 Oct 2019, Christoph Hellwig wrote:

> Many of the privileged CSRs exist in a supervisor and machine version
> that are used very similarly.  Provide versions of the CSR names and
> fields that map to either the S-mode or M-mode variant depending on
> a new CONFIG_RISCV_M_MODE kconfig symbol.
> 
> Contains contributions from Damien Le Moal <Damien.LeMoal@wdc.com>
> and Paul Walmsley <paul.walmsley@sifive.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For those:

>  drivers/clocksource/timer-riscv.c  |  8 ++--
>  drivers/irqchip/irq-sifive-plic.c  | 11 +++--

Acked-by: Thomas Gleixner <tglx@linutronix.de>

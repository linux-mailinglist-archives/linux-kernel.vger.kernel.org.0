Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037FC71CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 18:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390876AbfGWQeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 12:34:36 -0400
Received: from verein.lst.de ([213.95.11.211]:43210 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfGWQef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:34:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7270068B02; Tue, 23 Jul 2019 18:34:33 +0200 (CEST)
Date:   Tue, 23 Jul 2019 18:34:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, mbrugger@suse.com,
        hch@lst.de, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [RFC] ARM: bcm2835: register dmabounce on devices hooked to
 main interconnect
Message-ID: <20190723163433.GA2234@lst.de>
References: <20190723161934.4590-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723161934.4590-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int bcm2835_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)

Too long line..

> +void __init bcm2835_init_early(void)
> +{
> +	if(of_machine_is_compatible("brcm,bcm2711"))

Odd formatting.

Otherwise this looks good to me.

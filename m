Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B511BC41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfLKSxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 13:53:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59174 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLKSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:53:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBIqxps001589;
        Wed, 11 Dec 2019 12:52:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576090379;
        bh=f15tC67Mw6VJaPjDHx03fxOkJ7SSEWEdq7lkKckL4yU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AyYcGg18UkMJwm2f0NstPTMLZFABrS0QB1qhka2ELieoiik8THCIf1DY91U/VnBn0
         +dwJZn8aIwFNi3WKJlApshKK4AI3Oyql7CmYkshRxw9vQMjqVI1UvxWfNH4VvG4Ulz
         U0KRjdcbAzmArt6aHs9k6sJMZuFw1llGZQqGI2QQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBIqxlf042246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 12:52:59 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 12:52:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 12:52:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBIqxYD128795;
        Wed, 11 Dec 2019 12:52:59 -0600
Date:   Wed, 11 Dec 2019 12:52:24 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3 2/7] usb: musb: dma: Add support for shared IRQ
Message-ID: <20191211185224.GD16429@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
References: <20191210171110.62141-1-paul@crapouillou.net>
 <20191210171110.62141-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191210171110.62141-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 06:11:05PM +0100, Paul Cercueil wrote:
> The implementation of the Inventra IP in some of the Ingenic JZ47xx SoCs
> does not use a separate IRQ line for DMA transfers.
> 
> Allow these SoCs to be supported by adding a flag 'dma_share_usb_irq'
> in the struct musb. If set, no extra IRQ line is required, and the musb
> glue will need to call the API function musbhs_dma_controller_irq()
> within its interrupt handler.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
 
Queued for usb-next. Thanks.

-Bin.

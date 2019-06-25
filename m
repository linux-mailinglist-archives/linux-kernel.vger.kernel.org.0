Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE854DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 13:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfFYLpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 07:45:40 -0400
Received: from ns.iliad.fr ([212.27.33.1]:42304 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfFYLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:45:40 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E6C8E202C7;
        Tue, 25 Jun 2019 13:45:38 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id D2A73202C1;
        Tue, 25 Jun 2019 13:45:38 +0200 (CEST)
Subject: Re: [PATCH 2/2] dma-mapping: remove dma_max_pfn
To:     Christoph Hellwig <hch@lst.de>
References: <20190625092042.19320-1-hch@lst.de>
 <20190625092042.19320-3-hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2cf24650-512e-688d-fe24-119d36ed92f5@free.fr>
Date:   Tue, 25 Jun 2019 13:45:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625092042.19320-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Jun 25 13:45:38 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

There are some typos in the commit message that make it harder
(for me) to parse.

On 25/06/2019 11:20, Christoph Hellwig wrote:

> These days the DMA mapping code must bounce buffer for any not supported

Add comma after "These days" ?
s/must bounce buffer/must bounce buffers/ ?
s/not supported/unsupported/ ?

> address, and if they driver needs to optimize for natively supported

s/if they driver/if the driver/ ?

> ranged it should use dma_get_required_mask.

s/ranged it should/ranges, then it should/ ?

Regards.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8B92273
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfHSLbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 07:31:18 -0400
Received: from foss.arm.com ([217.140.110.172]:52924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSLbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AEE328;
        Mon, 19 Aug 2019 04:31:14 -0700 (PDT)
Received: from [10.37.12.162] (unknown [10.37.12.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7983F246;
        Mon, 19 Aug 2019 04:31:12 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 02/11] xen/arm: use dev_is_dma_coherent
To:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-3-hch@lst.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <0998bb38-6afd-d281-5c37-925adf2403d1@arm.com>
Date:   Mon, 19 Aug 2019 12:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816130013.31154-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 8/16/19 2:00 PM, Christoph Hellwig wrote:
> Use the dma-noncoherent dev_is_dma_coherent helper instead of the home
> grown variant.

It took me a bit of time to understand that dev->archdata.dma_coherent 
and dev->dma_coherent will always contain the same value.

Would you mind it mention it in the commit message?

Other than that:

Reviewed-by: Julien Grall <julien.grall@arm.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Cheers,

-- 
Julien Grall

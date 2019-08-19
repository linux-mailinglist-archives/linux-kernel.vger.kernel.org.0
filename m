Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2877B92593
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfHSNxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:53:44 -0400
Received: from foss.arm.com ([217.140.110.172]:54762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfHSNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:53:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F20028;
        Mon, 19 Aug 2019 06:53:43 -0700 (PDT)
Received: from [10.37.12.162] (unknown [10.37.12.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54FBF3F718;
        Mon, 19 Aug 2019 06:53:42 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 08/11] swiotlb-xen: use the same foreign page
 check everywhere
To:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-9-hch@lst.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <5c987a35-4e66-6d12-82e4-06fcffc3be3e@arm.com>
Date:   Mon, 19 Aug 2019 14:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816130013.31154-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 8/16/19 2:00 PM, Christoph Hellwig wrote:
> xen_dma_map_page uses a different and more complicated check for
> foreign pages than the other three cache maintainance helpers.
> Switch it to the simpler pfn_vali method a well.

NIT: s/pfn_vali/pfn_valid/

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall

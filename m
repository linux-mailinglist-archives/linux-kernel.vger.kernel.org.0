Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9E3CEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbfFKOgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 10:36:06 -0400
Received: from foss.arm.com ([217.140.110.172]:34452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387551AbfFKOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:36:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C1F337;
        Tue, 11 Jun 2019 07:36:02 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B72D3F557;
        Tue, 11 Jun 2019 07:36:01 -0700 (PDT)
Subject: Re: [PATCH 8/8] iommu/arm-smmu-v3: Add support for PCI PASID
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-9-jean-philippe.brucker@arm.com>
 <20190611114542.000021f1@huawei.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <3994ac33-e3e5-ba34-a669-c70a76a97e6e@arm.com>
Date:   Tue, 11 Jun 2019 15:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611114542.000021f1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 11:45, Jonathan Cameron wrote:
>> +	pci_disable_pasid(pdev);
>> +	master->ssid_bits = 0;
> 
> If we are being really fussy about ordering, why have this set of
> ssid_bits after pci_disable_pasid rather than before (to reverse order
> of .._enable_pasid)?

Sure, I'll change that

Thanks,
Jean

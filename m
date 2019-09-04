Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B72A7D39
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfIDH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 03:59:11 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:1160 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbfIDH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:59:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 0DE733F5F0;
        Wed,  4 Sep 2019 09:59:10 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=IQ61v1gT;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VlwumVT_5Fq4; Wed,  4 Sep 2019 09:59:09 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id BEF383F346;
        Wed,  4 Sep 2019 09:59:08 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 847A536117F;
        Wed,  4 Sep 2019 09:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567583948; bh=u13FcfsPPB+rHX6dHh07axBYmf9RAYcEXi36fo/oS+E=;
        h=To:Cc:From:Subject:Date:From;
        b=IQ61v1gTFy6dWmoVldP8ckGJ3X2qWRd+BKgDVG3BVpcHQy5IONzEICcwffHpL5pEl
         ciM4ra7cN3gxcTvsHkXON0Ol7lKJ7hsK8OVCKMSDUSBnFj2HZNtX9X0FzH0+adWEBA
         R0JNPmR1kyNo1bykPHpgzj0ZzCC37gdLTILuy1Zk=
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Subject: dma api errors with swiotlb
Organization: VMware Inc.
Message-ID: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
Date:   Wed, 4 Sep 2019 09:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Cristoph.

Another DMA related question before I start to post patches in this area 
again..

Our virtual SCSI device (which BTW is fully DMA compliant) has a large 
queue depth and therefore runs out of SWIOTLB space => The scsi middle 
layer behaves nicely and asks the driver to retry the dma mapping 
operation. All fine.

The problem is that while this happens, the kernel log spits out a 
number of dma- and SWIOTLB errors, which are really harmless.

While one could probably just say go and increase the SWIOTLB size, but 
on some systems that might not be doable.

We could reduce the queue depth when SEV is active, which is probably 
one of those hacky solutions you dislike.

We could silence the dma- and swiotlb errors? At least selectively for 
some devices?

Do you have any guidance into the best solution here?

Thanks,
Thomas.







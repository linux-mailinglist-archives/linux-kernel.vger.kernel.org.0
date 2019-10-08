Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B2DCF9DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfJHMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:34:22 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:39830 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbfJHMeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:34:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id B3B493FA9A;
        Tue,  8 Oct 2019 14:34:19 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=RBvmbRVj;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ahkiahV7a3lc; Tue,  8 Oct 2019 14:34:18 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 1BA573FA16;
        Tue,  8 Oct 2019 14:34:17 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7B26C36014C;
        Tue,  8 Oct 2019 14:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570538057; bh=YVSzd0MqV7won9JFSsoZRiwEMwhD7Xyu+FymKYBpowA=;
        h=To:Cc:From:Subject:Date:From;
        b=RBvmbRVjIhnW1mzTIJgBvKh61ASOlOick3JL0homIAy980483edV+0Y50vArqEScX
         2URhS27aeWDunvwBOxAJhoL/jLNIkSU8YAiWSuXV7kc6eVMGe4GPbjMHNV8u9PR73t
         9kJhkCWZobiw3GBq7JhmHz0satvW+ODdRR3WAL90=
To:     Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Subject: dma coherent memory user-space maps
Organization: VMware Inc.
Message-ID: <b811f66d-2353-23c6-c9fa-e279cdb0f832@shipmail.org>
Date:   Tue, 8 Oct 2019 14:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph,

Following our previous discussion I wonder if something along the lines 
of the following could work / be acceptible

typedef unsigned long dma_pfn_t /* Opaque pfn type. Arch dependent. This 
could if needed be a struct with a pointer and an offset */

/* Similar to vmf_insert_mixed() */
vm_fault_t dma_vmf_insert_mixed(struct device *dev,
                 struct vm_area_struct *vma,
                 unsigned long addr,
                 dma_pfn_t dpfn,
                 unsigned long attrs);

/* Similar to vmf_insert_pfn_pmd() */
vm_fault_t dma_vmf_insert_pfn_pmd(struct device *dev,
                   struct vm_area_struct *vma,
                   unsigned long addr,
                   dma_pfn_t dpfn,
                   unsigned long attrs);

/* Like vmap, but takes struct dma_pfns. */
extern void *dma_vmap(struct device *dev,
               dma_pfn_t dpfns[],
               unsigned int count, unsigned long flags,
               unsigned long attrs);

/* Obtain struct dma_pfn pointers from a dma coherent allocation */
int dma_get_dpfns(struct device *dev, void *cpu_addr, dma_addr_t dma_addr,
           pgoff_t offset, pgoff_t num, dma_pfn_t dpfns[]);

I figure, for most if not all architectures we could use an ordinary pfn 
as dma_pfn_t, but the dma layer would still have control over how those 
pfns are obtained and how they are used in the kernel's mapping APIs.

If so, I could start looking at this, time permitting,  for the cases 
where the pfn can be obtained from the kernel address or from 
arch_dma_coherent_to_pfn(), and also the needed work to have a tailored 
vmap_pfn().

Thanks,
/Thomas



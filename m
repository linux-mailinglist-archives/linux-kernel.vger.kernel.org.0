Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3034F7C9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 19:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfGaRIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 13:08:01 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33294 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbfGaRIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:08:01 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hss4m-0005K0-0o; Wed, 31 Jul 2019 11:07:44 -0600
To:     Greentime Hu <green.hu@gmail.com>, greentime.hu@sifive.com,
        paul.walmsley@sifive.com
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190109203911.7887-1-logang@deltatee.com>
 <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com>
Date:   Wed, 31 Jul 2019 11:07:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: hch@lst.de, michaeljclark@mac.com, linux-riscv@lists.infradead.org, olof@lixom.net, zong@andestech.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, paul.walmsley@sifive.com, greentime.hu@sifive.com, green.hu@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-31 12:30 a.m., Greentime Hu wrote:
> I look this issue more closely.
> I found it always sets each memblock region to node 0. Does this make sense?
> I am not sure if I understand this correctly. Do you have any idea for
> this? Thank you. :)

Yes, I think this is normal. When we talk about memory nodes we're
talking about NUMA nodes which is unrelated to device tree nodes.

I'm not really sure what's causing the crash. Have you verified it's
this patch that causes it? Is it related to there being a hole in your
memory, does it work if you only have one memory node?

Thanks,

Logan

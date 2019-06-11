Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55383C480
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbfFKGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 02:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391233AbfFKGvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:51:07 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C20920896;
        Tue, 11 Jun 2019 06:51:04 +0000 (UTC)
Subject: Re: binfmt_flat cleanups and RISC-V support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
References: <20190610212015.9157-1-hch@lst.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <6e5fb7db-1d6f-7d49-553c-edc18f14f641@linux-m68k.org>
Date:   Tue, 11 Jun 2019 16:51:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 11/6/19 7:20 am, Christoph Hellwig wrote:
> below is a larger stash of cleanups for the binfmt_misc code,
> preparing for the last patch that now trivially adds RISC-V
> support, which will be used for the RISC-V nommu series I am
> about to post.

Whole series looks pretty good. Just the one comment I made.

I normally take these through the m68knommu git tree,
if you have no problem with that I'll push it in there.
It will hit linux-next from there.

Thanks
Greg



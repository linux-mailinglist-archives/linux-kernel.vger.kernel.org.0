Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6CEA4FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfIBHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 03:20:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfIBHUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:20:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DCCE4AF39;
        Mon,  2 Sep 2019 07:20:15 +0000 (UTC)
Subject: Re: [PATCH] swiotlb-zen: Convert to use macro
To:     Souptick Joarder <jrdr.linux@gmail.com>, sstabellini@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <1567366136-874-1-git-send-email-jrdr.linux@gmail.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <b0c46bfb-9903-a3da-be30-e5b3fbabc9bf@suse.com>
Date:   Mon, 2 Sep 2019 09:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567366136-874-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.19 21:28, Souptick Joarder wrote:
> Rather than using static int max_dma_bits, this
> can be coverted to use as macro.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

s/zen/xen/ in the patch title, other than that:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

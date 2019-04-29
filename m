Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE5E6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfD2PuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 11:50:24 -0400
Received: from foss.arm.com ([217.140.101.70]:32808 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfD2PuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:50:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AE8980D;
        Mon, 29 Apr 2019 08:50:24 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34E983F5C1;
        Mon, 29 Apr 2019 08:50:23 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:50:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_sdei: Prohibit probing in '_sdei_handler'
Message-ID: <20190429155020.GB11429@fuggles.cambridge.arm.com>
References: <1556244996-1047-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556244996-1047-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:16:36AM +0800, Xiongfeng Wang wrote:
> Functions called in '_sdei_handler' are needed to be marked as
> 'nokprobe'. Because these functions are called in NMI context and
> neither the arch-code's debug infrastructure nor kprobes core supports
> this.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  drivers/firmware/arm_sdei.c | 3 +++
>  1 file changed, 3 insertions(+)

Queued for 5.2. Thanks.

Will

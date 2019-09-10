Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1275BAE388
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 08:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfIJGOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 02:14:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfIJGOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ooVpJ2SD+rn1QcsxA1qs/HCcA7+9ths/8oKDP+8Zv2E=; b=HBYGIqs2obOsolH7tKYMlb2vb
        lTy3q6ukVFPa75Licsymn8SiCK7UynNwZk/DUE5fmObUFL0ZPj2ZjRLaSjnihJpy58tzCY7nm56mZ
        klHjiK6Ku0q4BH+76zBfeHDHpiGDJJPk/f/vytlnFgRKa6gX7f7K7y+z2NKDr6Qx62ysyQcrYIVoV
        kd7weIkooLiGhTHmu0kSTDtodoiQjeZpYl0iM9nTkNitvJpuNXJZbTb7YxfB08MlMuX7Egu5xNqWC
        IPwrIS+Qs0dgyoco0hRsD8sg5PrVDfMuFYqiU/HrurTEz9P1m7AlkmE1l34nDqsvKMTBTQfi143Gt
        lSRQIlsSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ZQ7-0005nI-MC; Tue, 10 Sep 2019 06:14:31 +0000
Date:   Mon, 9 Sep 2019 23:14:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2] riscv: dts: sifive: Drop "clock-frequency" property
 of cpu nodes
Message-ID: <20190910061431.GB10968@infradead.org>
References: <1567687553-22334-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567687553-22334-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 05:45:53AM -0700, Bin Meng wrote:
> The "clock-frequency" property of cpu nodes isn't required. Drop it.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

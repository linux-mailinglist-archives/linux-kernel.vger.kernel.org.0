Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7C8A1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfHLO73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:59:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfHLO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2kI06ikxewQ1svqr4cBcgeHbdrXOn2mrV3htIHlbS8I=; b=Cs9K04j3cdzZxwbZLsTm+xC7U
        pduUawhaPsZ8z5CEc2/F7zQrEFrMX5pVtB9JY+xe/jt6hbzs2YpD0KPgYTvVOE8xlRCMl5vhAxjkK
        Q2IbvDxV4+DOTyYEQTg6ruh+sDJHN23ZcwRma5EPve3xoM0xFheuId8M69IIznLCkKnTYE99teYEe
        V0zrQRhiRo8ftvdSFgqUv3pi0bBiUnMLSRgnbvf2wZH08S+bo8fb92N7oGoX4dhGUi6A3c276SO0i
        Tsdv1cw+KK9HCCt+YMir9yg5pq3U0e4mj+qLRGeKcWI67Lje73j8SH7xW5ZB7ApWh/+8ptl646hVw
        w8Rbk7YpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBnE-0003nb-EN; Mon, 12 Aug 2019 14:59:28 +0000
Date:   Mon, 12 Aug 2019 07:59:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Make __fstate_clean() can work correctly.
Message-ID: <20190812145928.GE26897@infradead.org>
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com>
 <1565251121-28490-3-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565251121-28490-3-git-send-email-vincent.chen@sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe s/can //g in the subject?

> +	regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;

No need for the inner braces here either.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>

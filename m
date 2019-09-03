Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC69A6A52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfICNqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 09:46:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfICNqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5xcrdJhe1CaSBDIE24CROvZ8eU8JV2jbD+QewBGRHLo=; b=Ge+rdNqlWwdRA1MKwHqO7HVGdj
        JNxsqzdducX3NbrxpvXl5GTJbifbFiERHaxIV8a+C/O7yG7DUn3RviX86rOzGrVsub0/P+YH2IveZ
        bdhUoWO8V4FOkJCjkKDLPGoXPle2y0gQMJ4l6ppBpXhsoKfGjhYNvaG64lftEt5iI13V03zF9kHwD
        4Wmlhahbh7xrLacS2C7waGiJp8zaZ/ON7w+EQsalPMSmBVJTbicBjSbfMy5UYaKdaGCBNXKxD4XTB
        wxPg3ZeNmgqJnLaXmysyr76/2JJkKf/ZuPjSH1Zh7Ld7ThLOtiGcGUBBAkcpZD8mq2yR5hjVoPSAI
        7oe88T6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i598z-00024k-Aw; Tue, 03 Sep 2019 13:46:49 +0000
Date:   Tue, 3 Sep 2019 06:46:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 2/4] s390/mm: Export force_dma_unencrypted
Message-ID: <20190903134649.GB2951@infradead.org>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903131504.18935-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:15:02PM +0200, Thomas Hellstr�m (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> The force_dma_unencrypted symbol is needed by TTM to set up the correct
> page protection when memory encryption is active. Export it.

Smae here.  None of a drivers business.  DMA decisions are hidden
behind the DMA API.
